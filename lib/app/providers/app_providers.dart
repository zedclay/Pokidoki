import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import '../../core/services/secure_messaging_service.dart';
import '../../data/mock/mock_conversations_repository.dart';
import '../../data/mock/mock_security_repository.dart';
import '../../data/mock/mock_user_repository.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/conversations_repository.dart';
import '../../data/repositories/security_repository.dart';
import '../../data/repositories/user_repository.dart';
export '../../features/contacts/data/contacts_providers.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

/// `null` means follow the device locale when supported.
final localeOverrideProvider = StateProvider<Locale?>((ref) => null);

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return const MockUserRepository();
});

final conversationsRepositoryProvider = Provider<ConversationsRepository>((
  ref,
) {
  return const MockConversationsRepository();
});

final securityRepositoryProvider = Provider<SecurityRepository>((ref) {
  return const MockSecurityRepository();
});

final secureMessagingServiceProvider = Provider<SecureMessagingService>((ref) {
  return const MockSecureMessagingService();
});

final currentUserProvider = FutureProvider<UserProfile?>((ref) async {
  return ref.watch(userRepositoryProvider).getCurrentUser();
});

/// Presentation-only authentication state for routing decisions.
enum AuthPresentationStatus { unknown, unauthenticated, authenticated }

final authPresentationProvider = StateProvider<AuthPresentationStatus>((ref) {
  return AuthPresentationStatus.unknown;
});

/// Whether onboarding has been completed on this device (mock).
final onboardingCompletedProvider = StateProvider<bool>((ref) => false);
