import 'dart:async';

import 'package:drift/drift.dart';

import '../../../../data/models/message.dart';
import '../../domain/local_message_status.dart';
import '../../domain/queue_retry_scheduler.dart';
import '../messaging_failure.dart';
import '../api/api_conversations_repository.dart';
import '../api/messaging_api_mapper.dart';
import '../api/messaging_api_models.dart';
import '../local/database/messaging_database.dart';
import '../local/mappers/local_message_mapper.dart';
import '../realtime/messaging_socket_models.dart';
import '../realtime/messaging_socket_service.dart';
import 'messaging_sync_engine.dart';

typedef QueueProcessorClock = DateTime Function();

class OutboundMessageQueueProcessor {
  OutboundMessageQueueProcessor({
    required MessagingDatabase database,
    required ApiConversationsRepository remote,
    required MessagingSocketService socketService,
    required MessagingSyncEngine syncEngine,
    required String? Function() currentUserId,
    QueueRetryScheduler? retryScheduler,
    QueueProcessorClock? clock,
  }) : _db = database,
       _remote = remote,
       _socket = socketService,
       _sync = syncEngine,
       _currentUserId = currentUserId,
       _retry = retryScheduler ?? QueueRetryScheduler(),
       _clock = clock ?? DateTime.now;

  final MessagingDatabase _db;
  final ApiConversationsRepository _remote;
  final MessagingSocketService _socket;
  final MessagingSyncEngine _sync;
  final String? Function() _currentUserId;
  final QueueRetryScheduler _retry;
  final QueueProcessorClock _clock;

  bool _draining = false;
  bool _stopped = false;

  void stop() {
    _stopped = true;
  }

  void resume() {
    _stopped = false;
  }

  Future<void> recoverStaleJobs() async {
    final now = _clock().toUtc();
    await _db.outboundQueueDao.recoverStaleInFlight(
      staleBefore: now.subtract(const Duration(minutes: 2)),
      retryAt: now,
    );
  }

  Future<void> requestDrain() async {
    if (_stopped || _draining) {
      return;
    }
    _draining = true;
    try {
      await recoverStaleJobs();
      while (!_stopped) {
        final now = _clock().toUtc();
        final item = await _db.outboundQueueDao.acquireNextEligible(now);
        if (item == null) {
          break;
        }
        await _processItem(item, now);
      }
    } finally {
      _draining = false;
    }
  }

  Future<void> _processItem(OutboundMessageQueueData item, DateTime now) async {
    await _db.outboundQueueDao.markInFlight(item.id, now);
    await _db.messagesDao.updateByClientId(
      clientMessageId: item.clientMessageId,
      fields: LocalMessagesCompanion(
        deliveryStatus: Value(LocalMessageStatus.sending.name),
        lastUpdatedAt: Value(now),
      ),
    );

    try {
      ChatMessage? serverMessage;
      if (_socket.status == MessagingSocketStatus.connected) {
        final ack = await _socket.sendMessage(
          conversationId: item.conversationId,
          clientMessageId: item.clientMessageId,
          text: item.textPayload,
        );
        if (ack.ok && ack.rawMessage != null) {
          serverMessage = mapMessageDto(
            MessageDto.fromJson(ack.rawMessage!),
            currentUserId: _currentUserId(),
          );
        } else if (ack.code != null) {
          throw MessagingFailure(code: ack.code!);
        }
      }

      serverMessage ??= await _remote.sendMessage(
        conversationId: item.conversationId,
        clientMessageId: item.clientMessageId,
        text: item.textPayload,
      );

      await _sync.upsertRemoteChatMessage(serverMessage);
      await _db.outboundQueueDao.markCompleted(item.id);
      await _db.conversationsDao.updatePreview(
        conversationId: item.conversationId,
        preview: item.textPayload,
        at: serverMessage.sentAt,
        isOutgoing: true,
        lastMessageId: serverMessage.id.startsWith('local-')
            ? null
            : serverMessage.id,
        lastMessageClientId: item.clientMessageId,
      );
    } on MessagingFailure catch (failure) {
      await _handleFailure(
        item: item,
        code: failure.code,
        attemptCount: item.attemptCount + 1,
      );
    } on Object {
      await _handleFailure(
        item: item,
        code: 'SYNC_TEMPORARILY_UNAVAILABLE',
        attemptCount: item.attemptCount + 1,
      );
    }
  }

  Future<void> _handleFailure({
    required OutboundMessageQueueData item,
    required String code,
    required int attemptCount,
  }) async {
    if (_retry.isPermanentError(code)) {
      await _db.outboundQueueDao.markFailedPermanent(
        queueId: item.id,
        errorCode: code,
      );
      await _db.messagesDao.markClientMessageFailed(
        clientMessageId: item.clientMessageId,
        errorCode: code,
      );
      return;
    }

    final nextAttempt = _retry.nextAttemptAt(attemptCount: attemptCount);
    await _db.outboundQueueDao.markWaitingRetry(
      queueId: item.id,
      nextAttemptAt: nextAttempt,
      attemptCount: attemptCount,
      errorCode: code,
    );
    await _db.messagesDao.updateByClientId(
      clientMessageId: item.clientMessageId,
      fields: LocalMessagesCompanion(
        deliveryStatus: Value(LocalMessageStatus.queued.name),
        errorCode: Value(code),
        lastUpdatedAt: Value(_clock().toUtc()),
      ),
    );
  }
}
