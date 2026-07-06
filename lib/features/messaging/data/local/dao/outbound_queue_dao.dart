import 'package:drift/drift.dart';

import '../../../domain/local_message_status.dart';
import '../database/messaging_database.dart';
import '../tables/outbound_message_queue.dart';

part 'outbound_queue_dao.g.dart';

@DriftAccessor(tables: [OutboundMessageQueue])
class OutboundQueueDao extends DatabaseAccessor<MessagingDatabase>
    with _$OutboundQueueDaoMixin {
  OutboundQueueDao(super.db);

  Future<int> enqueue(OutboundMessageQueueCompanion companion) {
    return into(outboundMessageQueue).insert(
      companion,
      onConflict: DoUpdate(
        (old) => companion,
        target: [outboundMessageQueue.clientMessageId],
      ),
    );
  }

  Future<OutboundMessageQueueData?> acquireNextEligible(DateTime now) async {
    return (select(outboundMessageQueue)
          ..where(
            (t) =>
                t.queueState.equals(QueueState.pending.name) |
                (t.queueState.equals(QueueState.waitingRetry.name) &
                    t.nextAttemptAt.isSmallerOrEqualValue(now)),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> markInFlight(int queueId, DateTime now) {
    return (update(
      outboundMessageQueue,
    )..where((t) => t.id.equals(queueId))).write(
      OutboundMessageQueueCompanion(
        queueState: Value(QueueState.inFlight.name),
        inFlightSince: Value(now),
        lastAttemptAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> markWaitingRetry({
    required int queueId,
    required DateTime nextAttemptAt,
    required int attemptCount,
    String? errorCode,
  }) {
    final now = DateTime.now().toUtc();
    return (update(
      outboundMessageQueue,
    )..where((t) => t.id.equals(queueId))).write(
      OutboundMessageQueueCompanion(
        queueState: Value(QueueState.waitingRetry.name),
        nextAttemptAt: Value(nextAttemptAt),
        attemptCount: Value(attemptCount),
        inFlightSince: const Value(null),
        errorCode: Value(errorCode),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> markCompleted(int queueId) {
    final now = DateTime.now().toUtc();
    return (update(
      outboundMessageQueue,
    )..where((t) => t.id.equals(queueId))).write(
      OutboundMessageQueueCompanion(
        queueState: Value(QueueState.completed.name),
        inFlightSince: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> markFailedPermanent({required int queueId, String? errorCode}) {
    final now = DateTime.now().toUtc();
    return (update(
      outboundMessageQueue,
    )..where((t) => t.id.equals(queueId))).write(
      OutboundMessageQueueCompanion(
        queueState: Value(QueueState.failedPermanent.name),
        inFlightSince: const Value(null),
        errorCode: Value(errorCode),
        updatedAt: Value(now),
      ),
    );
  }

  Future<int> recoverStaleInFlight({
    required DateTime staleBefore,
    required DateTime retryAt,
  }) {
    return (update(outboundMessageQueue)..where(
          (t) =>
              t.queueState.equals(QueueState.inFlight.name) &
              t.inFlightSince.isSmallerThanValue(staleBefore),
        ))
        .write(
          OutboundMessageQueueCompanion(
            queueState: Value(QueueState.waitingRetry.name),
            nextAttemptAt: Value(retryAt),
            inFlightSince: const Value(null),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
  }

  Future<void> releaseWaitingRetries({DateTime? now}) {
    final retryAt = now ?? DateTime.now().toUtc();
    return (update(
      outboundMessageQueue,
    )..where((t) => t.queueState.equals(QueueState.waitingRetry.name))).write(
      OutboundMessageQueueCompanion(
        nextAttemptAt: Value(retryAt),
        updatedAt: Value(retryAt),
      ),
    );
  }

  Future<int> countPending() async {
    final rows =
        await (select(outboundMessageQueue)..where(
              (t) =>
                  t.queueState.equals(QueueState.pending.name) |
                  t.queueState.equals(QueueState.waitingRetry.name) |
                  t.queueState.equals(QueueState.inFlight.name),
            ))
            .get();
    return rows.length;
  }

  Future<void> failPendingForConversation({
    required String conversationId,
    required String errorCode,
  }) async {
    final now = DateTime.now().toUtc();
    await (update(outboundMessageQueue)..where(
          (t) =>
              t.conversationId.equals(conversationId) &
              (t.queueState.equals(QueueState.pending.name) |
                  t.queueState.equals(QueueState.waitingRetry.name) |
                  t.queueState.equals(QueueState.inFlight.name)),
        ))
        .write(
          OutboundMessageQueueCompanion(
            queueState: Value(QueueState.failedPermanent.name),
            errorCode: Value(errorCode),
            inFlightSince: const Value(null),
            updatedAt: Value(now),
          ),
        );
  }

  Future<void> clearAll() => delete(outboundMessageQueue).go();
}
