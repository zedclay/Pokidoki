/// Domain-safe network failure codes mapped to localization keys.
enum NetworkFailureCode {
  noInternet('authNoInternet'),
  connectionTimeout('authRequestTimedOut'),
  receiveTimeout('authRequestTimedOut'),
  sendTimeout('authRequestTimedOut'),
  serverUnavailable('authServerUnavailable'),
  invalidResponse('authUnexpectedError'),
  tlsError('authUnexpectedError'),
  invalidApiBaseUrl('authUnexpectedError'),
  unexpected('authUnexpectedError');

  const NetworkFailureCode(this.messageKey);

  final String messageKey;
}

class NetworkFailure implements Exception {
  const NetworkFailure(this.code);

  final NetworkFailureCode code;

  String get messageKey => code.messageKey;
}
