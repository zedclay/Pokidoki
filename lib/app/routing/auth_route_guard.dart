import '../app_bootstrap.dart';
import '../providers/app_providers.dart';
import 'route_names.dart';

/// Routes reachable without a backend-authenticated session.
bool isPublicAuthRoute(String location) {
  const public = {
    AppRoutes.splash,
    AppRoutes.onboarding,
    AppRoutes.welcome,
    AppRoutes.createAccount,
    AppRoutes.signIn,
    AppRoutes.emailVerification,
    AppRoutes.usernameSetup,
    AppRoutes.profileSetup,
    AppRoutes.createPin,
    AppRoutes.confirmPin,
    AppRoutes.enableBiometrics,
    AppRoutes.appLock,
    AppRoutes.accountRecovery,
    AppRoutes.pinRecovery,
    AppRoutes.devPlaceholder,
    AppRoutes.conversationsHomePlaceholder,
    AppRoutes.reportUserPlaceholder,
  };

  if (public.contains(location)) {
    return true;
  }

  return location.startsWith('/dev/');
}

bool isProtectedRoute(String location) {
  if (isPublicAuthRoute(location)) {
    return false;
  }

  const protectedPrefixes = [
    AppRoutes.appChats,
    AppRoutes.appContacts,
    AppRoutes.appSettings,
    AppRoutes.settingsAccount,
    AppRoutes.settingsLinkedDevices,
    AppRoutes.settingsSecurityActivity,
    AppRoutes.settingsBlockedUsers,
    AppRoutes.settingsAppLock,
    AppRoutes.settingsAppearance,
    AppRoutes.settingsLanguage,
    AppRoutes.settingsStorage,
    AppRoutes.newConversation,
    AppRoutes.userSearch,
    AppRoutes.contactRequests,
    AppRoutes.qrScanner,
    AppRoutes.myQrCode,
  ];

  if (protectedPrefixes.any(
    (prefix) => location == prefix || location.startsWith('$prefix/'),
  )) {
    return true;
  }

  return location.startsWith('/chats/') ||
      location.startsWith('/users/') ||
      location.startsWith('/report/') ||
      location.startsWith('/security/contact-verification/') ||
      location.startsWith('/security/safety-number/');
}

/// Resolves post-splash entry based on auth and onboarding state.
String resolveInitialEntry({
  required AuthPresentationStatus authStatus,
  required bool onboardingCompleted,
}) {
  if (authStatus == AuthPresentationStatus.authenticated) {
    return AppRoutes.appLock;
  }
  if (!onboardingCompleted) {
    return AppRoutes.onboarding;
  }
  return AppRoutes.welcome;
}

/// GoRouter redirect for authentication-aware navigation.
String? authRedirect({
  required AuthPresentationStatus authStatus,
  required BootstrapPhase bootstrapPhase,
  required String location,
}) {
  if (bootstrapPhase != BootstrapPhase.ready ||
      authStatus == AuthPresentationStatus.unknown) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  if (authStatus == AuthPresentationStatus.unauthenticated) {
    if (isProtectedRoute(location)) {
      return AppRoutes.signIn;
    }
    return null;
  }

  // Authenticated users should not return to pre-auth entry screens.
  const signedInBlocked = {
    AppRoutes.signIn,
    AppRoutes.welcome,
    AppRoutes.createAccount,
    AppRoutes.onboarding,
  };
  if (signedInBlocked.contains(location)) {
    return AppRoutes.appLock;
  }

  return null;
}
