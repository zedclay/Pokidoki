import '../../../../core/network/api_exception.dart';

class MessagingFailure implements Exception {
  const MessagingFailure({required this.code, this.messageKey});

  final String code;
  final String? messageKey;

  factory MessagingFailure.fromApiException(ApiException exception) {
    return MessagingFailure(code: exception.code, messageKey: null);
  }
}
