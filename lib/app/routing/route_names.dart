/// Route path constants.
abstract final class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const welcome = '/welcome';

  static const createAccount = '/auth/create-account';
  static const signIn = '/auth/sign-in';
  static const emailVerification = '/auth/email-verification';
  static const usernameSetup = '/auth/username-setup';
  static const profileSetup = '/auth/profile-setup';

  static const createPin = '/security/create-pin';
  static const confirmPin = '/security/confirm-pin';
  static const enableBiometrics = '/security/enable-biometrics';
  static const appLock = '/security/app-lock';

  static const appChats = '/app/chats';
  static const appContacts = '/app/contacts';
  static const appSettings = '/app/settings';

  static const settingsAccount = '/settings/account';
  static const settingsLinkedDevices = '/settings/linked-devices';
  static const settingsSecurityActivity = '/settings/security-activity';
  static const settingsBlockedUsers = '/settings/blocked-users';
  static const settingsAppLock = '/settings/app-lock';
  static const settingsAppearance = '/settings/appearance';
  static const settingsLanguage = '/settings/language';
  static const settingsStorage = '/settings/storage';
  static const settingsAccountChangePassword =
      '/settings/account/change-password';
  static const settingsAccountEmail = '/settings/account/email';
  static const settingsAccountRecovery = '/settings/account/recovery';

  static String settingsSecurityEventPath(String eventId) =>
      '/settings/security-activity/$eventId';

  static String reportUserPath(String userId) => '/report/$userId';

  static const newConversation = '/chats/new';
  static const userSearch = '/users/search';
  static const contactRequests = '/contacts/requests';

  static const devPlaceholder = '/dev/placeholder';
  static const conversationsHomePlaceholder = '/dev/conversations-home';
  static const accountRecovery = '/dev/account-recovery';
  static const pinRecovery = '/dev/pin-recovery';
  static const qrScanner = '/security/qr-scanner';
  static const myQrCode = '/security/my-qr';
  static const reportUserPlaceholder = '/dev/report-user';

  /// Legacy placeholder path redirects to the real scanner.
  static const qrScannerPlaceholder = qrScanner;

  static String contactVerificationPath(String userId) =>
      '/security/contact-verification/$userId';

  static String safetyNumberPath(String userId) =>
      '/security/safety-number/$userId';

  static const chats = appChats;
  static const contacts = appContacts;
  static const settings = appSettings;

  static String userProfilePath(String userId) => '/users/$userId';

  static String chatPath(String conversationId) => '/chats/$conversationId';

  static String conversationInfoPath(String conversationId) =>
      '/chats/$conversationId/info';

  static String conversationSearchPath(String conversationId) =>
      '/chats/$conversationId/search';

  static String sharedContentPath(String conversationId) =>
      '/chats/$conversationId/shared';

  static String disappearingMessagesPath(String conversationId) =>
      '/chats/$conversationId/disappearing-messages';

  /// Legacy placeholder path used by older call sites.
  static const oneToOneChatPlaceholder = '/chats/conv-amira';
}

abstract final class RouteNames {
  static const splash = 'splash';
  static const onboarding = 'onboarding';
  static const welcome = 'welcome';
  static const createAccount = 'createAccount';
  static const signIn = 'signIn';
  static const emailVerification = 'emailVerification';
  static const usernameSetup = 'usernameSetup';
  static const profileSetup = 'profileSetup';
  static const createPin = 'createPin';
  static const confirmPin = 'confirmPin';
  static const enableBiometrics = 'enableBiometrics';
  static const appLock = 'appLock';
  static const appChats = 'appChats';
  static const appContacts = 'appContacts';
  static const appSettings = 'appSettings';
  static const settingsAccount = 'settingsAccount';
  static const settingsLinkedDevices = 'settingsLinkedDevices';
  static const settingsSecurityActivity = 'settingsSecurityActivity';
  static const settingsSecurityEvent = 'settingsSecurityEvent';
  static const settingsBlockedUsers = 'settingsBlockedUsers';
  static const settingsAppLock = 'settingsAppLock';
  static const settingsAppearance = 'settingsAppearance';
  static const settingsLanguage = 'settingsLanguage';
  static const settingsStorage = 'settingsStorage';
  static const settingsAccountChangePassword = 'settingsAccountChangePassword';
  static const settingsAccountEmail = 'settingsAccountEmail';
  static const settingsAccountRecovery = 'settingsAccountRecovery';
  static const reportUser = 'reportUser';
  static const newConversation = 'newConversation';
  static const userSearch = 'userSearch';
  static const userProfile = 'userProfile';
  static const contactRequests = 'contactRequests';
  static const devPlaceholder = 'devPlaceholder';
  static const conversationsHomePlaceholder = 'conversationsHomePlaceholder';
  static const accountRecovery = 'accountRecovery';
  static const pinRecovery = 'pinRecovery';
  static const chat = 'chat';
  static const conversationInfo = 'conversationInfo';
  static const conversationSearch = 'conversationSearch';
  static const sharedContent = 'sharedContent';
  static const disappearingMessages = 'disappearingMessages';
  static const qrScanner = 'qrScanner';
  static const myQrCode = 'myQrCode';
  static const contactVerification = 'contactVerification';
  static const safetyNumber = 'safetyNumber';
  static const reportUserPlaceholder = 'reportUserPlaceholder';
}
