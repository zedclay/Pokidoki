/// Local delivery/sync status stored in Drift.
enum LocalMessageStatus {
  queued,
  sending,
  sent,
  delivered,
  read,
  failedPermanent,
}

enum LocalSyncState { localOnly, pendingAck, synced }

enum QueueState { pending, inFlight, waitingRetry, completed, failedPermanent }

class MessageStatusRank {
  const MessageStatusRank._();

  static int rank(LocalMessageStatus status) {
    return switch (status) {
      LocalMessageStatus.failedPermanent => 0,
      LocalMessageStatus.queued => 1,
      LocalMessageStatus.sending => 2,
      LocalMessageStatus.sent => 3,
      LocalMessageStatus.delivered => 4,
      LocalMessageStatus.read => 5,
    };
  }

  static LocalMessageStatus max(
    LocalMessageStatus current,
    LocalMessageStatus incoming,
  ) {
    return rank(incoming) >= rank(current) ? incoming : current;
  }

  static LocalMessageStatus fromStorage(String value) {
    return LocalMessageStatus.values.firstWhere(
      (item) => item.name == value,
      orElse: () => LocalMessageStatus.sent,
    );
  }
}

class QueueStateCodec {
  const QueueStateCodec._();

  static QueueState fromStorage(String value) {
    return QueueState.values.firstWhere(
      (item) => item.name == value,
      orElse: () => QueueState.pending,
    );
  }
}

/// Maps local status to UI [MessageDeliveryStatus].
class DeliveryStatusMapper {
  const DeliveryStatusMapper._();

  static String toUiStatus(LocalMessageStatus status) {
    return switch (status) {
      LocalMessageStatus.queued => 'sending',
      LocalMessageStatus.sending => 'sending',
      LocalMessageStatus.sent => 'sent',
      LocalMessageStatus.delivered => 'delivered',
      LocalMessageStatus.read => 'read',
      LocalMessageStatus.failedPermanent => 'failed',
    };
  }

  static LocalMessageStatus fromUiStatus(String status) {
    return switch (status) {
      'sending' => LocalMessageStatus.sending,
      'sent' => LocalMessageStatus.sent,
      'delivered' => LocalMessageStatus.delivered,
      'read' => LocalMessageStatus.read,
      'failed' => LocalMessageStatus.failedPermanent,
      _ => LocalMessageStatus.sent,
    };
  }
}
