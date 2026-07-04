import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/app_shell/presentation/screens/main_shell_screen.dart';
import '../../features/authentication/presentation/screens/create_account_screen.dart';
import '../../features/authentication/presentation/screens/email_verification_screen.dart';
import '../../features/authentication/presentation/screens/profile_setup_screen.dart';
import '../../features/authentication/presentation/screens/sign_in_screen.dart';
import '../../features/authentication/presentation/screens/username_setup_screen.dart';
import '../../features/chats/presentation/screens/conversations_home_screen.dart';
import '../../features/chats/presentation/screens/new_conversation_screen.dart';
import '../../features/contacts/presentation/screens/contact_requests_screen.dart';
import '../../features/contacts/presentation/screens/contacts_screen.dart';
import '../../features/dev/presentation/screens/dev_placeholder_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import '../../features/security_setup/presentation/screens/app_lock_screen.dart';
import '../../features/security_setup/presentation/screens/confirm_pin_screen.dart';
import '../../features/security_setup/presentation/screens/create_pin_screen.dart';
import '../../features/security_setup/presentation/screens/enable_biometrics_screen.dart';
import '../../features/account_security/presentation/screens/account_recovery_screen.dart';
import '../../features/account_security/presentation/screens/change_password_screen.dart';
import '../../features/account_security/presentation/screens/email_management_screen.dart';
import '../../features/safety/presentation/screens/report_user_screen.dart';
import '../../features/settings/presentation/screens/account_management_screen.dart';
import '../../features/settings/presentation/screens/app_lock_settings_screen.dart';
import '../../features/settings/presentation/screens/appearance_screen.dart';
import '../../features/settings/presentation/screens/blocked_users_screen.dart';
import '../../features/settings/presentation/screens/language_screen.dart';
import '../../features/settings/presentation/screens/linked_devices_screen.dart';
import '../../features/settings/presentation/screens/security_activity_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/settings/presentation/screens/storage_usage_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/messaging/presentation/screens/conversation_info_screen.dart';
import '../../features/messaging/presentation/screens/conversation_search_screen.dart';
import '../../features/messaging/presentation/screens/disappearing_messages_screen.dart';
import '../../features/messaging/presentation/screens/one_to_one_chat_screen.dart';
import '../../features/messaging/presentation/screens/shared_content_screen.dart';
import '../../features/users/presentation/screens/user_profile_preview_screen.dart';
import '../../features/users/presentation/screens/user_search_screen.dart';
import '../../features/verification/presentation/screens/contact_verification_screen.dart';
import '../../features/verification/presentation/screens/my_qr_code_screen.dart';
import '../../features/verification/presentation/screens/qr_scanner_screen.dart';
import '../../features/verification/presentation/screens/safety_number_screen.dart';
import '../../features/welcome/presentation/screens/welcome_screen.dart';
import 'route_names.dart';
import 'route_not_found_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    errorBuilder: (context, state) => const RouteNotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingFlowScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        name: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.createAccount,
        name: RouteNames.createAccount,
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        name: RouteNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.emailVerification,
        name: RouteNames.emailVerification,
        builder: (context, state) => const EmailVerificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.usernameSetup,
        name: RouteNames.usernameSetup,
        builder: (context, state) => const UsernameSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileSetup,
        name: RouteNames.profileSetup,
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.createPin,
        name: RouteNames.createPin,
        builder: (context, state) => CreatePinScreen(
          fromSettings: state.uri.queryParameters['mode'] == 'settings',
        ),
      ),
      GoRoute(
        path: AppRoutes.confirmPin,
        name: RouteNames.confirmPin,
        builder: (context, state) => ConfirmPinScreen(
          fromSettings: state.uri.queryParameters['mode'] == 'settings',
        ),
      ),
      GoRoute(
        path: AppRoutes.enableBiometrics,
        name: RouteNames.enableBiometrics,
        builder: (context, state) => const EnableBiometricsScreen(),
      ),
      GoRoute(
        path: AppRoutes.appLock,
        name: RouteNames.appLock,
        builder: (context, state) => const AppLockScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.appChats,
                name: RouteNames.appChats,
                builder: (context, state) => const ConversationsHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.appContacts,
                name: RouteNames.appContacts,
                builder: (context, state) => const ContactsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.appSettings,
                name: RouteNames.appSettings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settingsAccount,
        name: RouteNames.settingsAccount,
        builder: (context, state) => const AccountManagementScreen(),
        routes: [
          GoRoute(
            path: 'change-password',
            name: RouteNames.settingsAccountChangePassword,
            builder: (context, state) => const ChangePasswordScreen(),
          ),
          GoRoute(
            path: 'email',
            name: RouteNames.settingsAccountEmail,
            builder: (context, state) => const EmailManagementScreen(),
          ),
          GoRoute(
            path: 'recovery',
            name: RouteNames.settingsAccountRecovery,
            builder: (context, state) => const AccountRecoveryScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settingsLinkedDevices,
        name: RouteNames.settingsLinkedDevices,
        builder: (context, state) => const LinkedDevicesScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsSecurityActivity,
        name: RouteNames.settingsSecurityActivity,
        builder: (context, state) => const SecurityActivityScreen(),
        routes: [
          GoRoute(
            path: ':eventId',
            name: RouteNames.settingsSecurityEvent,
            builder: (context, state) => SecurityEventDetailScreen(
              eventId: state.pathParameters['eventId']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settingsBlockedUsers,
        name: RouteNames.settingsBlockedUsers,
        builder: (context, state) => const BlockedUsersScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsAppLock,
        name: RouteNames.settingsAppLock,
        builder: (context, state) => const AppLockSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsAppearance,
        name: RouteNames.settingsAppearance,
        builder: (context, state) => const AppearanceScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsLanguage,
        name: RouteNames.settingsLanguage,
        builder: (context, state) => const LanguageScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsStorage,
        name: RouteNames.settingsStorage,
        builder: (context, state) => const StorageUsageScreen(),
      ),
      GoRoute(
        path: '/report/:userId',
        name: RouteNames.reportUser,
        builder: (context, state) =>
            ReportUserScreen(userId: state.pathParameters['userId']!),
      ),
      GoRoute(
        path: AppRoutes.newConversation,
        name: RouteNames.newConversation,
        builder: (context, state) => const NewConversationScreen(),
      ),
      GoRoute(
        path: AppRoutes.userSearch,
        name: RouteNames.userSearch,
        builder: (context, state) => const UserSearchScreen(),
      ),
      GoRoute(
        path: '/users/:userId',
        name: RouteNames.userProfile,
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return UserProfilePreviewScreen(userId: userId);
        },
      ),
      GoRoute(
        path: AppRoutes.contactRequests,
        name: RouteNames.contactRequests,
        builder: (context, state) => const ContactRequestsScreen(),
      ),
      GoRoute(
        path: '/chats/:conversationId',
        name: RouteNames.chat,
        builder: (context, state) => OneToOneChatScreen(
          conversationId: state.pathParameters['conversationId']!,
        ),
        routes: [
          GoRoute(
            path: 'info',
            name: RouteNames.conversationInfo,
            builder: (context, state) => ConversationInfoScreen(
              conversationId: state.pathParameters['conversationId']!,
            ),
          ),
          GoRoute(
            path: 'search',
            name: RouteNames.conversationSearch,
            builder: (context, state) => ConversationSearchScreen(
              conversationId: state.pathParameters['conversationId']!,
            ),
          ),
          GoRoute(
            path: 'shared',
            name: RouteNames.sharedContent,
            builder: (context, state) => SharedContentScreen(
              conversationId: state.pathParameters['conversationId']!,
            ),
          ),
          GoRoute(
            path: 'disappearing-messages',
            name: RouteNames.disappearingMessages,
            builder: (context, state) => DisappearingMessagesScreen(
              conversationId: state.pathParameters['conversationId']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.qrScanner,
        name: RouteNames.qrScanner,
        builder: (context, state) => const QrScannerScreen(),
      ),
      GoRoute(
        path: AppRoutes.myQrCode,
        name: RouteNames.myQrCode,
        builder: (context, state) => const MyQrCodeScreen(),
      ),
      GoRoute(
        path: '/security/contact-verification/:userId',
        name: RouteNames.contactVerification,
        builder: (context, state) =>
            ContactVerificationScreen(userId: state.pathParameters['userId']!),
      ),
      GoRoute(
        path: '/security/safety-number/:userId',
        name: RouteNames.safetyNumber,
        builder: (context, state) =>
            SafetyNumberScreen(userId: state.pathParameters['userId']!),
      ),
      GoRoute(
        path: AppRoutes.reportUserPlaceholder,
        name: RouteNames.reportUserPlaceholder,
        redirect: (context, state) => AppRoutes.reportUserPath('u-riad'),
      ),
      GoRoute(
        path: AppRoutes.conversationsHomePlaceholder,
        name: RouteNames.conversationsHomePlaceholder,
        redirect: (context, state) => AppRoutes.appChats,
      ),
      GoRoute(
        path: AppRoutes.accountRecovery,
        name: RouteNames.accountRecovery,
        redirect: (context, state) => AppRoutes.settingsAccountRecovery,
      ),
      GoRoute(
        path: AppRoutes.pinRecovery,
        name: RouteNames.pinRecovery,
        builder: (context, state) =>
            DevPlaceholderScreen(messageBuilder: (l10n) => l10n.devPinRecovery),
      ),
      GoRoute(
        path: AppRoutes.devPlaceholder,
        name: RouteNames.devPlaceholder,
        builder: (context, state) => const DevPlaceholderScreen(),
      ),
    ],
  );
});
