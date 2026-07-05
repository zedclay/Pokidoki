import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import '../../core/services/secure_messaging_service.dart';
import '../../data/mock/mock_security_repository.dart';
import '../../data/repositories/security_repository.dart';

export '../../features/contacts/data/contacts_providers.dart';
export '../../features/messaging/data/messaging_providers.dart';
export '../../features/users/data/user_providers.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

/// `null` means follow the device locale when supported.
final localeOverrideProvider = StateProvider<Locale?>((ref) => null);

final securityRepositoryProvider = Provider<SecurityRepository>((ref) {
  return const MockSecurityRepository();
});

final secureMessagingServiceProvider = Provider<SecureMessagingService>((ref) {
  return const MockSecureMessagingService();
});

/// Presentation-only authentication state for routing decisions.
enum AuthPresentationStatus { unknown, unauthenticated, authenticated }

final authPresentationProvider = StateProvider<AuthPresentationStatus>((ref) {
  return AuthPresentationStatus.unknown;
});

/// Whether onboarding has been completed on this device (mock).
final onboardingCompletedProvider = StateProvider<bool>((ref) => false);
