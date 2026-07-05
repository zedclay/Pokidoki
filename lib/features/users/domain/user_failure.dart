class UserFailure implements Exception {
  const UserFailure({required this.messageKey, this.backendCode});

  final String messageKey;
  final String? backendCode;
}
