import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the device app-lock PIN outside in-memory auth flow state.
abstract interface class AppPinStorage {
  Future<String?> readPin();

  Future<void> savePin(String pin);

  Future<void> deletePin();
}

class SecureAppPinStorage implements AppPinStorage {
  SecureAppPinStorage({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock,
            ),
          );

  static const _pinKey = 'pokidoki_app_lock_pin';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readPin() => _storage.read(key: _pinKey);

  @override
  Future<void> savePin(String pin) => _storage.write(key: _pinKey, value: pin);

  @override
  Future<void> deletePin() => _storage.delete(key: _pinKey);
}

class InMemoryAppPinStorage implements AppPinStorage {
  String? _pin;

  @override
  Future<String?> readPin() async => _pin;

  @override
  Future<void> savePin(String pin) async {
    _pin = pin;
  }

  @override
  Future<void> deletePin() async {
    _pin = null;
  }
}
