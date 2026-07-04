import 'app_environment.dart';

/// Non-secret application configuration.
///
/// API base URLs and feature flags may be supplied via `--dart-define`.
/// Do not store API keys, tokens, or credentials here.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableVerboseLogging,
  });

  factory AppConfig.fromEnvironment() {
    final environment = AppEnvironment.fromDefine();
    const apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.example.pokidoki.invalid',
    );

    return AppConfig(
      environment: environment,
      apiBaseUrl: apiBaseUrl,
      enableVerboseLogging: environment.isDevelopment,
    );
  }

  final AppEnvironment environment;
  final String apiBaseUrl;
  final bool enableVerboseLogging;
}
