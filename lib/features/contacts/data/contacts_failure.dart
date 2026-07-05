class ContactsFailure implements Exception {
  const ContactsFailure({required this.messageKey, this.backendCode});

  final String messageKey;
  final String? backendCode;
}
