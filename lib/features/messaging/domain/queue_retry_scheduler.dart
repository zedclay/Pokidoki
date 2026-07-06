import 'dart:math';

/// Bounded exponential backoff with jitter for queue retries.
class QueueRetryScheduler {
  QueueRetryScheduler({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const _permanentCodes = {
    'MESSAGE_INVALID',
    'MESSAGE_TOO_LONG',
    'MESSAGE_SEND_NOT_ALLOWED',
    'CONVERSATION_CONTACT_REQUIRED',
    'CONVERSATION_UNAVAILABLE',
    'CONVERSATION_FORBIDDEN',
    'CONVERSATION_NOT_FOUND',
    'CONVERSATION_ARCHIVED',
    'CONVERSATION_BLOCKED',
  };

  static const _transientCodes = {
    'WEBSOCKET_UNAUTHORIZED',
    'WEBSOCKET_SESSION_EXPIRED',
    'MESSAGING_UNAVAILABLE',
    'SYNC_TEMPORARILY_UNAVAILABLE',
    'REQUEST_ERROR',
    'CONNECTION_ERROR',
    'HTTP_408',
    'HTTP_429',
    'HTTP_500',
    'HTTP_502',
    'HTTP_503',
    'HTTP_504',
  };

  static const delays = [
    Duration(seconds: 2),
    Duration(seconds: 5),
    Duration(seconds: 10),
    Duration(seconds: 30),
    Duration(seconds: 60),
    Duration(minutes: 5),
  ];

  DateTime nextAttemptAt({required int attemptCount, DateTime? now}) {
    final base = now ?? DateTime.now().toUtc();
    final index = attemptCount.clamp(0, delays.length - 1);
    final delay = delays[index];
    final jitterMs = _random.nextInt(500);
    return base.add(delay + Duration(milliseconds: jitterMs));
  }

  bool isPermanentError(String? code) {
    if (code == null || code.isEmpty) {
      return false;
    }
    return _permanentCodes.contains(code);
  }

  bool isTransientError(String? code) {
    if (code == null || code.isEmpty) {
      return true;
    }
    if (_permanentCodes.contains(code)) {
      return false;
    }
    return _transientCodes.contains(code) || !_permanentCodes.contains(code);
  }

  String codeForHttpStatus(int? statusCode) {
    return switch (statusCode) {
      408 => 'HTTP_408',
      429 => 'HTTP_429',
      500 => 'HTTP_500',
      502 => 'HTTP_502',
      503 => 'HTTP_503',
      504 => 'HTTP_504',
      _ => 'REQUEST_ERROR',
    };
  }
}
