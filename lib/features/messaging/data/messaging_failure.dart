import '../../../../core/network/api_exception.dart';

class MessagingFailure implements Exception {
  const MessagingFailure({required this.code, this.messageKey});

  final String code;
  final String? messageKey;

  String get resolvedMessageKey =>
      messageKey ?? messageKeyForCode(code) ?? 'messagingUnavailable';

  static String? messageKeyForCode(String code) {
    return switch (code) {
      'LOCAL_DATABASE_UNAVAILABLE' => 'localDatabaseUnavailable',
      'LOCAL_DATABASE_KEY_UNAVAILABLE' => 'localDatabaseKeyUnavailable',
      'LOCAL_DATABASE_CORRUPT' => 'localDatabaseCorrupt',
      'LOCAL_DATABASE_ENCRYPTION_UNAVAILABLE' =>
        'localDatabaseEncryptionUnavailable',
      'SYNC_TEMPORARILY_UNAVAILABLE' => 'syncTemporarilyUnavailable',
      'REQUEST_ERROR' => 'messagingUnavailable',
      'CONVERSATION_NOT_FOUND' => 'conversationUnavailable',
      'CONVERSATION_FORBIDDEN' => 'conversationUnavailable',
      'CONVERSATION_SELF_NOT_ALLOWED' => 'conversationSelfNotAllowed',
      'CONVERSATION_CONTACT_REQUIRED' => 'conversationContactRequired',
      'CONVERSATION_UNAVAILABLE' => 'conversationUnavailable',
      'MESSAGE_SEND_NOT_ALLOWED' => 'cannotMessageUser',
      _ => null,
    };
  }

  factory MessagingFailure.fromApiException(ApiException exception) {
    return MessagingFailure(code: exception.code, messageKey: null);
  }
}
