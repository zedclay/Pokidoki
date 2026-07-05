import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/core/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('fromEnvironment provides debug fallback URL', () {
      final config = AppConfig.fromEnvironment();
      expect(config.apiBaseUrl, 'http://127.0.0.1:3000/api/v1');
    });

    test('validateApiBaseUrl accepts valid URL', () {
      expect(
        () => AppConfig.validateApiBaseUrl('http://10.0.2.2:3000/api/v1'),
        returnsNormally,
      );
    });

    test('validateApiBaseUrl rejects invalid URL', () {
      expect(
        () => AppConfig.validateApiBaseUrl('not-a-url'),
        throwsA(isA<StateError>()),
      );
    });

    test('validateApiBaseUrl rejects missing API prefix', () {
      expect(
        () => AppConfig.validateApiBaseUrl('http://127.0.0.1:3000'),
        throwsA(isA<StateError>()),
      );
    });

    test('validateApiBaseUrl rejects embedded credentials', () {
      expect(
        () => AppConfig.validateApiBaseUrl(
          'http://user:pass@127.0.0.1:3000/api/v1',
        ),
        throwsA(isA<StateError>()),
      );
    });
  });
}
