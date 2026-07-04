/// Boundary for future native cryptography integration.
///
/// Implementations must not invent custom encryption, present base64 as
/// encryption, or claim production cryptographic protection from mock state.
/// See `docs/SECURITY_BOUNDARIES.md`.
abstract interface class SecureMessagingService {
  /// Prepares messaging dependencies for the current session.
  ///
  /// Mock implementations may return a development-ready state only.
  Future<bool> initialize();

  /// Whether this implementation provides production-grade protection.
  ///
  /// Must be `false` for all mock and development implementations.
  bool get providesProductionProtection;
}

/// Development-only stand-in. Does not perform cryptography.
class MockSecureMessagingService implements SecureMessagingService {
  const MockSecureMessagingService();

  @override
  bool get providesProductionProtection => false;

  @override
  Future<bool> initialize() async {
    // Simulated dependency warm-up for UI development only.
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return true;
  }
}
