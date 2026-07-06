import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/features/messaging/domain/queue_retry_scheduler.dart';

void main() {
  final scheduler = QueueRetryScheduler(random: Random(0));

  test('backoff increases with attempt count', () {
    final base = DateTime.utc(2026, 1, 1, 12);
    final first = scheduler.nextAttemptAt(attemptCount: 0, now: base);
    final second = scheduler.nextAttemptAt(attemptCount: 1, now: base);
    expect(first.isAfter(base), isTrue);
    expect(second.difference(base), greaterThan(first.difference(base)));
  });

  test('permanent errors are classified', () {
    expect(scheduler.isPermanentError('MESSAGE_TOO_LONG'), isTrue);
    expect(scheduler.isPermanentError('MESSAGE_SEND_NOT_ALLOWED'), isTrue);
    expect(scheduler.isTransientError('MESSAGE_TOO_LONG'), isFalse);
    expect(scheduler.isTransientError(null), isTrue);
  });
}
