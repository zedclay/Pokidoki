import 'package:drift/drift.dart';

import '../../../../../data/models/message.dart';
import '../../../domain/local_message_status.dart';
import '../database/messaging_database.dart';

extension LocalMessageMapper on LocalMessage {
  ChatMessage toDomain({required String? currentUserId}) {
    final status = MessageStatusRank.fromStorage(deliveryStatus);
    final isOutgoing =
        currentUserId != null &&
        currentUserId.isNotEmpty &&
        senderId == currentUserId;
    return ChatMessage(
      id: serverMessageId ?? 'local-$clientMessageId',
      conversationId: conversationId,
      clientMessageId: clientMessageId,
      senderId: senderId,
      body: body,
      sentAt: serverCreatedAt ?? localCreatedAt,
      isOutgoing: isOutgoing,
      type: _mapType(messageType),
      deliveryStatus: _mapDelivery(status),
      replyToMessageId: replyToMessageId,
      replyPreview: replyPreview,
      expiresAt: expiresAt,
    );
  }

  MessageContentType _mapType(String raw) {
    return switch (raw) {
      'SYSTEM' => MessageContentType.system,
      _ => MessageContentType.text,
    };
  }

  MessageDeliveryStatus _mapDelivery(LocalMessageStatus status) {
    if (status == LocalMessageStatus.queued &&
        errorCode != null &&
        errorCode!.isNotEmpty) {
      return MessageDeliveryStatus.retrying;
    }
    return switch (status) {
      LocalMessageStatus.queued => MessageDeliveryStatus.queued,
      LocalMessageStatus.sending => MessageDeliveryStatus.sending,
      LocalMessageStatus.sent => MessageDeliveryStatus.sent,
      LocalMessageStatus.delivered => MessageDeliveryStatus.delivered,
      LocalMessageStatus.read => MessageDeliveryStatus.read,
      LocalMessageStatus.failedPermanent => MessageDeliveryStatus.failed,
    };
  }
}

LocalMessagesCompanion messageToInsertCompanion({
  required String clientMessageId,
  required String conversationId,
  required String senderId,
  required String text,
  required LocalMessageStatus status,
  required LocalSyncState syncState,
  String? serverMessageId,
  DateTime? serverCreatedAt,
  DateTime? expiresAt,
  String? replyToMessageId,
  String? replyPreview,
  String? errorCode,
  String type = 'TEXT',
}) {
  final now = DateTime.now().toUtc();
  return LocalMessagesCompanion.insert(
    serverMessageId: Value(serverMessageId),
    clientMessageId: clientMessageId,
    conversationId: conversationId,
    senderId: senderId,
    messageType: Value(type),
    body: text,
    localCreatedAt: now,
    serverCreatedAt: Value(serverCreatedAt),
    expiresAt: Value(expiresAt),
    deliveryStatus: status.name,
    syncState: syncState.name,
    errorCode: Value(errorCode),
    replyToMessageId: Value(replyToMessageId),
    replyPreview: Value(replyPreview),
    lastUpdatedAt: now,
  );
}
