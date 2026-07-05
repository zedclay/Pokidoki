import 'package:flutter/foundation.dart';

import 'app_environment.dart';

/// Non-secret application configuration.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableVerboseLogging,
  });

  factory AppConfig.fromEnvironment() {
    final environment = AppEnvironment.fromDefine();
    const configuredBaseUrl = String.fromEnvironment('API_BASE_URL');

    final apiBaseUrl = _resolveApiBaseUrl(
      configuredBaseUrl: configuredBaseUrl,
      isDebugMode: kDebugMode,
      environment: environment,
    );

    return AppConfig(
      environment: environment,
      apiBaseUrl: apiBaseUrl,
      enableVerboseLogging: environment.isDevelopment && kDebugMode,
    );
  }

  final AppEnvironment environment;
  final String apiBaseUrl;
  final bool enableVerboseLogging;

  static String _resolveApiBaseUrl({
    required String configuredBaseUrl,
    required bool isDebugMode,
    required AppEnvironment environment,
  }) {
    if (configuredBaseUrl.isNotEmpty) {
      _validateApiBaseUrl(configuredBaseUrl);
      return configuredBaseUrl;
    }

    if (isDebugMode && environment.isDevelopment) {
      const fallback = 'http://127.0.0.1:3000/api/v1';
      _validateApiBaseUrl(fallback);
      return fallback;
    }

    throw StateError(
      'API_BASE_URL must be provided via --dart-define for release builds.',
    );
  }

  static void validateApiBaseUrl(String value) => _validateApiBaseUrl(value);

  static void _validateApiBaseUrl(String value) {
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      throw StateError('API_BASE_URL is invalid.');
    }
    if (uri.userInfo.isNotEmpty) {
      throw StateError('API_BASE_URL must not contain credentials.');
    }
    if (!value.endsWith('/api/v1')) {
      throw StateError('API_BASE_URL must include the /api/v1 prefix.');
    }
  }
}
