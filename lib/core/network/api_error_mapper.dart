import 'package:dio/dio.dart';

import 'api_exception.dart';
import 'network_failure.dart';

class ApiErrorMapper {
  const ApiErrorMapper();

  String messageKeyForBackendCode(String code) {
    return switch (code) {
      'AUTH_EMAIL_UNAVAILABLE' => 'authEmailUnavailable',
      'AUTH_INVALID_CREDENTIALS' => 'authInvalidCredentials',
      'AUTH_EMAIL_NOT_VERIFIED' => 'authEmailNotVerified',
      'AUTH_ACCOUNT_SUSPENDED' => 'authAccountSuspended',
      'AUTH_ACCOUNT_DISABLED' => 'authAccountDisabled',
      'AUTH_VERIFICATION_INVALID' => 'authVerificationInvalid',
      'AUTH_VERIFICATION_EXPIRED' => 'authVerificationExpired',
      'AUTH_VERIFICATION_ATTEMPTS_EXCEEDED' =>
        'authVerificationAttemptsExceeded',
      'AUTH_VERIFICATION_RESEND_TOO_SOON' => 'authVerificationResendTooSoon',
      'AUTH_REFRESH_INVALID' => 'authSessionExpired',
      'AUTH_REFRESH_EXPIRED' => 'authSessionExpired',
      'AUTH_SESSION_REVOKED' => 'authSessionExpired',
      'AUTH_REFRESH_REUSE_DETECTED' => 'authSessionExpired',
      'AUTH_RATE_LIMITED' => 'authRateLimited',
      'CONTACT_REQUEST_SELF_NOT_ALLOWED' => 'contactsSelfNotAllowed',
      'CONTACT_REQUEST_ALREADY_PENDING' => 'contactsAlreadyPending',
      'CONTACT_REQUEST_REVERSE_PENDING' => 'contactsReversePending',
      'CONTACT_REQUEST_NOT_FOUND' => 'contactsRequestNotFound',
      'CONTACT_REQUEST_NOT_PENDING' => 'contactsRequestNotPending',
      'CONTACT_REQUEST_FORBIDDEN' => 'contactsRequestForbidden',
      'CONTACT_ALREADY_EXISTS' => 'contactsAlreadyExists',
      'CONTACT_NOT_FOUND' => 'contactsNotFound',
      'USER_NOT_AVAILABLE' => 'contactsUserUnavailable',
      'USER_ALREADY_BLOCKED' => 'contactsAlreadyBlocked',
      'USER_NOT_BLOCKED' => 'contactsNotBlocked',
      'RELATIONSHIP_UNAVAILABLE' => 'contactsRelationshipUnavailable',
      'VALIDATION_ERROR' => 'authGenericError',
      _ => 'authUnexpectedError',
    };
  }

  ApiException mapResponse(DioException error) {
    final response = error.response;
    if (response?.data is Map<String, dynamic>) {
      final body = response!.data as Map<String, dynamic>;
      final code = body['code']?.toString() ?? 'REQUEST_ERROR';
      final message = body['message']?.toString() ?? 'Request failed.';
      return ApiException(
        statusCode: response.statusCode ?? 500,
        code: code,
        message: message,
      );
    }

    return ApiException(
      statusCode: response?.statusCode ?? 500,
      code: 'REQUEST_ERROR',
      message: 'Request failed.',
    );
  }

  NetworkFailure mapDioException(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout => const NetworkFailure(
        NetworkFailureCode.connectionTimeout,
      ),
      DioExceptionType.sendTimeout => const NetworkFailure(
        NetworkFailureCode.sendTimeout,
      ),
      DioExceptionType.receiveTimeout => const NetworkFailure(
        NetworkFailureCode.receiveTimeout,
      ),
      DioExceptionType.connectionError => const NetworkFailure(
        NetworkFailureCode.noInternet,
      ),
      DioExceptionType.badCertificate => const NetworkFailure(
        NetworkFailureCode.tlsError,
      ),
      DioExceptionType.badResponse
          when error.response?.statusCode != null &&
              error.response!.statusCode! >= 500 =>
        const NetworkFailure(NetworkFailureCode.serverUnavailable),
      _ => const NetworkFailure(NetworkFailureCode.unexpected),
    };
  }
}
