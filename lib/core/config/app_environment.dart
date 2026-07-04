/// Compile-time application environment.
///
/// Pass with `--dart-define=APP_ENV=staging` (or `production`).
/// Defaults to development. Never place secrets in this file.
enum AppEnvironment {
  development,
  staging,
  production;

  static AppEnvironment fromDefine() {
    const value = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    return switch (value.toLowerCase()) {
      'staging' => AppEnvironment.staging,
      'production' || 'prod' => AppEnvironment.production,
      _ => AppEnvironment.development,
    };
  }

  bool get isDevelopment => this == AppEnvironment.development;
  bool get isProduction => this == AppEnvironment.production;
}
