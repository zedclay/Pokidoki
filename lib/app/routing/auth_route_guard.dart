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

bool isProfileOnboardingRoute(String location) {
  const routes = {
    AppRoutes.usernameSetup,
    AppRoutes.profileSetup,
    AppRoutes.createPin,
    AppRoutes.confirmPin,
    AppRoutes.enableBiometrics,
  };
  return routes.contains(location);
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

/// Resolves post-splash entry based on auth, profile, and onboarding state.
String resolveInitialEntry({
  required AuthPresentationStatus authStatus,
  required bool onboardingCompleted,
  required ProfileCompletionStatus profileStatus,
}) {
  if (authStatus == AuthPresentationStatus.authenticated) {
    if (profileStatus == ProfileCompletionStatus.missing) {
      return AppRoutes.usernameSetup;
    }
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
  required ProfileCompletionStatus profileStatus,
  required String location,
}) {
  if (bootstrapPhase != BootstrapPhase.ready ||
      authStatus == AuthPresentationStatus.unknown) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  if (authStatus == AuthPresentationStatus.authenticated &&
      profileStatus == ProfileCompletionStatus.unknown) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  if (authStatus == AuthPresentationStatus.unauthenticated) {
    if (isProtectedRoute(location)) {
      return AppRoutes.signIn;
    }
    return null;
  }

  if (profileStatus == ProfileCompletionStatus.missing) {
    if (isProtectedRoute(location) || location == AppRoutes.appLock) {
      if (isProfileOnboardingRoute(location) ||
          location == AppRoutes.emailVerification) {
        return null;
      }
      return AppRoutes.usernameSetup;
    }
  }

  if (profileStatus == ProfileCompletionStatus.complete &&
      isProfileOnboardingRoute(location) &&
      location != AppRoutes.profileSetup &&
      location != AppRoutes.usernameSetup) {
    // Allow username/profile setup from account management when complete.
  }

  // Authenticated users should not return to pre-auth entry screens.
  const signedInBlocked = {
    AppRoutes.signIn,
    AppRoutes.welcome,
    AppRoutes.createAccount,
    AppRoutes.onboarding,
  };
  if (signedInBlocked.contains(location)) {
    return profileStatus == ProfileCompletionStatus.missing
        ? AppRoutes.usernameSetup
        : AppRoutes.appLock;
  }

  return null;
}
