// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Pokidoki';

  @override
  String get splashTagline => 'Private conversations, protected.';

  @override
  String get splashPreparing => 'Securing your space';

  @override
  String get splashLoadingSemantic => 'Pokidoki is starting';

  @override
  String get splashReadySemantic => 'Pokidoki is ready';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionContinueUpper => 'CONTINUE';

  @override
  String get actionGetStarted => 'GET STARTED';

  @override
  String get actionSkip => 'Skip';

  @override
  String get actionRetry => 'Try again';

  @override
  String get actionCreateAccount => 'CREATE ACCOUNT';

  @override
  String get actionSignIn => 'Sign in';

  @override
  String onboardingPageSemantic(int current, int total) {
    return 'Onboarding page $current of $total';
  }

  @override
  String get onboarding1Title => 'Your conversations stay private';

  @override
  String get onboarding1Body =>
      'Messages are protected on your device and can only be read by conversation participants.';

  @override
  String get onboarding1IllustrationSemantic =>
      'Illustration of private conversation between two people';

  @override
  String get onboarding2Title => 'Know who you are talking to';

  @override
  String get onboarding2Body =>
      'Verify trusted contacts using a QR code or safety number before sharing sensitive information.';

  @override
  String get onboarding2IllustrationSemantic =>
      'Illustration of contact verification with a QR code and checkmark';

  @override
  String get onboarding3Title => 'Your private space stays locked';

  @override
  String get onboarding3Body =>
      'Protect Pokidoki with an app PIN and your device biometrics, so only you can access your conversations.';

  @override
  String get onboarding3IllustrationSemantic =>
      'Illustration of app lock with PIN and biometrics';

  @override
  String get welcomeTitle => 'Welcome to your private space';

  @override
  String get welcomeBody =>
      'Connect with the people you trust and keep your conversations protected.';

  @override
  String get welcomeFeaturePrivate => 'Private conversations';

  @override
  String get welcomeFeatureVerification => 'Contact verification';

  @override
  String get welcomeFeatureAppLock => 'App lock protection';

  @override
  String get welcomeTermsPrefix => 'By continuing, you agree to the ';

  @override
  String get welcomeTermsOfService => 'Terms of Service';

  @override
  String get welcomeTermsMiddle => ' and ';

  @override
  String get welcomePrivacyPolicy => 'Privacy Policy';

  @override
  String get welcomeTermsSuffix => '.';

  @override
  String get welcomePrivacyNote =>
      'Pokidoki cannot read your private messages.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageFrench => 'Français';

  @override
  String languageSelectorSemantic(String language) {
    return 'Language, currently $language';
  }

  @override
  String get devPlaceholderTitle => 'Screen not implemented yet';

  @override
  String get devPlaceholderBody =>
      'This destination is reserved for a later implementation batch.';

  @override
  String get devPlaceholderBadge => 'Temporary development screen';

  @override
  String get devScreenCreateAccount => 'Create Account is not implemented yet.';

  @override
  String get devScreenSignIn => 'Sign In is not implemented yet.';

  @override
  String get devConversationsHome =>
      'Conversations Home will be implemented in a later batch.';

  @override
  String get devAccountRecovery =>
      'Account Recovery will be implemented in the next batch.';

  @override
  String get devAccountRecoveryNextBatch =>
      'Account Recovery will be implemented in the next batch.';

  @override
  String get devPinRecovery =>
      'App PIN recovery will be implemented in a later batch.';

  @override
  String get devSettings => 'Settings will be implemented in a later batch.';

  @override
  String get devOneToOneChat =>
      'One-to-One Chat will be implemented in a later batch.';

  @override
  String get devQrScanner => 'QR Scanner will be implemented in a later batch.';

  @override
  String get devReportUser =>
      'Report User will be implemented in the next batch.';

  @override
  String get devChangePassword =>
      'Change Password will be implemented in the next batch.';

  @override
  String get devEmailManagement =>
      'Email Management will be implemented in the next batch.';

  @override
  String get actionTryAgain => 'Try again';

  @override
  String get routeNotFoundTitle => 'Page not found';

  @override
  String get routeNotFoundBody => 'This link is not available in the app.';

  @override
  String get routeNotFoundAction => 'Go to Welcome';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get chatsYouPrefix => 'You: ';

  @override
  String get chatsYesterday => 'Yesterday';

  @override
  String chatsUnreadCount(int count) {
    return '$count unread messages';
  }

  @override
  String get chatsSearchHint => 'Search conversations';

  @override
  String get chatsProtectedBanner =>
      'Your conversations are protected with end-to-end encryption.';

  @override
  String get chatsPinned => 'Pinned';

  @override
  String get chatsRecent => 'Recent';

  @override
  String get chatsRecentContacts => 'Recent contacts';

  @override
  String get chatsNewConversation => 'New conversation';

  @override
  String get chatsEmptyTitle => 'No conversations yet';

  @override
  String get chatsEmptyBody =>
      'Start a private conversation with one of your contacts.';

  @override
  String get contactsSearchHint => 'Search contacts';

  @override
  String get contactsRequestsTitle => 'Contact requests';

  @override
  String contactsRequestsWaiting(int count) {
    return '$count requests are waiting for your review.';
  }

  @override
  String get contactsVerifiedSection => 'Verified contacts';

  @override
  String get contactsAllContacts => 'All contacts';

  @override
  String get contactsEmptyTitle => 'No contacts yet';

  @override
  String get contactsEmptyBody =>
      'Search for someone or accept a contact request.';

  @override
  String get contactsReviewRequests => 'Review requests';

  @override
  String get contactsRequestsInfo =>
      'Accepting a request adds the account to your contacts. It does not verify the person’s identity. Verify the contact before sharing sensitive information.';

  @override
  String get contactsReceived => 'Received';

  @override
  String get contactsSent => 'Sent';

  @override
  String get contactsAccept => 'ACCEPT';

  @override
  String get contactsDecline => 'DECLINE';

  @override
  String get contactsCancelRequest => 'Cancel';

  @override
  String get contactsRequestAccepted => 'Contact request accepted.';

  @override
  String get contactsRequestDeclined => 'Contact request declined.';

  @override
  String get contactsNoReceivedRequests => 'No received requests.';

  @override
  String get contactsNoSentRequests => 'No sent requests.';

  @override
  String get usersFindSomeone => 'Find someone';

  @override
  String get usersFindPeople => 'Find people';

  @override
  String get usersSearchByUsernameOrId => 'Search by username or Pokidoki ID';

  @override
  String get usersSearchInitial => 'Search by username or Pokidoki ID.';

  @override
  String get usersNoResultsTitle => 'No users found';

  @override
  String get usersNoResultsBody => 'Try another username or Pokidoki ID.';

  @override
  String get usersScanQr => 'Scan QR code';

  @override
  String get usersScanQrSubtitle => 'Add or verify someone nearby';

  @override
  String get usersNewGroup => 'New group';

  @override
  String get usersNewGroupSubtitle => 'Create a private conversation...';

  @override
  String get usersComingLater => 'Coming later';

  @override
  String get usersProfileTitle => 'Profile';

  @override
  String get usersSendRequest => 'Send contact request';

  @override
  String get usersRequestSent => 'Contact request sent.';

  @override
  String get usersRequestPending => 'Request sent';

  @override
  String get usersMessage => 'Message';

  @override
  String get usersNotInContacts => 'Not in your contacts';

  @override
  String get usersInContacts => 'In your contacts';

  @override
  String get usersNotVerified => 'Not verified';

  @override
  String get usersVerifyBeforeSensitive =>
      'Verify this person before sharing sensitive information.';

  @override
  String get usersAbout => 'About';

  @override
  String get usersSharedContext => 'Shared context';

  @override
  String get usersCopyId => 'Copy Pokidoki ID';

  @override
  String get usersBlockAction => 'Block';

  @override
  String get usersReportAction => 'Report';

  @override
  String usersBlockTitle(String name) {
    return 'Block $name?';
  }

  @override
  String usersBlockBody(String name) {
    return '$name will not be able to send you new contact requests or messages.';
  }

  @override
  String get usersBlocked => 'User blocked.';

  @override
  String get qrScanTitle => 'Scan QR Code';

  @override
  String get qrScanHeading => 'Scan a Pokidoki QR code';

  @override
  String get qrScanBody =>
      'Place the code inside the frame to add or verify someone';

  @override
  String get qrLookingForCode => 'Looking for a Pokidoki code...';

  @override
  String get qrFrameSemantic => 'QR scanning frame';

  @override
  String get qrSimulateScan => 'Simulate scan';

  @override
  String get qrInvalidCode =>
      'This QR code is not a valid Pokidoki contact code.';

  @override
  String get qrFlash => 'Flash';

  @override
  String get qrGallery => 'Gallery';

  @override
  String get qrMyCodeAction => 'My QR Code';

  @override
  String get qrMyCodeTitle => 'My Pokidoki QR';

  @override
  String get qrHelp => 'Help';

  @override
  String get qrBrightness => 'Brightness';

  @override
  String get qrCodeSemantic => 'Your Pokidoki contact QR code';

  @override
  String get qrPublicIdentity => 'Your public Pokidoki identity';

  @override
  String get qrPublicIdHelp => 'People can use this ID to find your account.';

  @override
  String get qrShareExplanation =>
      'Your Pokidoki QR code helps people find or verify your account without typing your username or ID.';

  @override
  String get qrShareAction => 'Share';

  @override
  String get qrShareReady => 'Your Pokidoki contact code is ready to share.';

  @override
  String get qrRefreshAction => 'Refresh';

  @override
  String get qrRefreshTitle => 'Create a new QR code?';

  @override
  String get qrRefreshBody =>
      'The previous contact code will no longer be used for new scans.';

  @override
  String get verifyContactTitle => 'Verify contact';

  @override
  String get verifyNotVerified => 'Not verified';

  @override
  String get verifyQrRecognized => 'QR code recognized';

  @override
  String verifyQrRecognizedBody(String name) {
    return 'This code belongs to $name’s Pokidoki profile.';
  }

  @override
  String get verifyConfirmInPerson =>
      'Confirm that you are talking to the right person';

  @override
  String get verifyScanQrMethod => 'Scan QR code';

  @override
  String get verifyScanQrMethodBody => 'Recommended when you are together';

  @override
  String get verifyCompareSafetyNumber => 'Compare safety number';

  @override
  String get verifyCompareSafetyNumberBody =>
      'Useful when you are not in the same place';

  @override
  String get verifyWhatItConfirms => 'What verification confirms';

  @override
  String get verifyBulletSameIdentity =>
      'You are comparing the same contact identity';

  @override
  String get verifyBulletNotReplaced =>
      'The contact’s security identity has not been unexpectedly replaced';

  @override
  String get verifyBulletMarkedOnDevice =>
      'Pokidoki can mark this contact as verified on your device';

  @override
  String verifyMarkTitle(String name) {
    return 'Verify $name?';
  }

  @override
  String verifyMarkBody(String name) {
    return 'Only continue if you confirmed this profile with $name in person or through another trusted channel.';
  }

  @override
  String get verifyMarkAction => 'Mark as verified';

  @override
  String get verifySafetyConfirmed => 'Safety number confirmed.';

  @override
  String get verifyResetTitle => 'Reset verification?';

  @override
  String verifyResetBody(String name) {
    return '$name will appear unverified until you compare the identity again.';
  }

  @override
  String get verifyResetAction => 'Reset';

  @override
  String get safetyNumberTitle => 'Safety number';

  @override
  String safetyCompareHeading(String name) {
    return 'Compare this number with $name';
  }

  @override
  String get safetyCompareBody =>
      'Both devices should display the same safety number. Compare it in person or through another communication method you already trust.';

  @override
  String get safetyNumberSemantic => 'Safety number digit groups';

  @override
  String get safetyNumberCopied => 'Safety number copied.';

  @override
  String get safetyDoNotCompareOnlyInChat =>
      'Do not compare this number only inside the conversation you are verifying.';

  @override
  String get chatTypeMessage => 'Type a message';

  @override
  String get chatSend => 'Send';

  @override
  String get chatAttach => 'Attachment';

  @override
  String get chatReply => 'Reply';

  @override
  String get chatCopy => 'Copy';

  @override
  String get chatDelete => 'Delete';

  @override
  String get chatDeleteForMe => 'Delete for me';

  @override
  String get chatDeleteTitle => 'Delete this message?';

  @override
  String get chatDeleteBody => 'This removes the message from this device.';

  @override
  String get chatMessageInfo => 'Message info';

  @override
  String get chatMessageCopied => 'Message copied.';

  @override
  String get chatSearchInConversation => 'Search';

  @override
  String get chatConversationInfo => 'Conversation info';

  @override
  String get chatProtectedBanner =>
      'Messages in this conversation are protected with end-to-end encryption.';

  @override
  String get chatToday => 'Today';

  @override
  String get chatAttachmentLater =>
      'Attachment selection will be connected in a later phase.';

  @override
  String chatBlockedNotice(String name) {
    return 'You blocked $name.';
  }

  @override
  String get chatSent => 'Sent';

  @override
  String get chatDelivered => 'Delivered';

  @override
  String get chatRead => 'Read';

  @override
  String get chatMuteNotifications => 'Notifications';

  @override
  String get chatDisappearingMessages => 'Disappearing messages';

  @override
  String get chatDisappearingOff => 'Off';

  @override
  String get chatDisappearingOffHelp => 'Messages stay until deleted';

  @override
  String get chatDisappearingOneHour => '1 hour';

  @override
  String get chatDisappearingOneHourHelp => 'Standard temporary chat';

  @override
  String get chatDisappearingOneDay => '1 day';

  @override
  String get chatDisappearingOneDayHelp => 'Default privacy setting';

  @override
  String get chatDisappearingOneWeek => '1 week';

  @override
  String get chatDisappearingOneWeekHelp => 'Extended conversation history';

  @override
  String get chatDisappearingAppliesFuture =>
      'The new timer applies to future messages. Previous messages will keep their original timer.';

  @override
  String get chatDisappearingScreenshotWarning =>
      'Disappearing does not prevent copying. Recipients can still take screenshots, copy text, or forward messages before they disappear.';

  @override
  String get chatSharedContent => 'Shared content';

  @override
  String chatSharedWith(String name) {
    return 'Shared with $name';
  }

  @override
  String get chatPhotosAndVideos => 'Photos and videos';

  @override
  String get chatFiles => 'Files';

  @override
  String get chatLinks => 'Links';

  @override
  String get chatMedia => 'Media';

  @override
  String get chatNoMedia => 'No media yet';

  @override
  String get chatNoFiles => 'No files yet';

  @override
  String get chatNoLinks => 'No links yet';

  @override
  String get chatFilePreviewLater =>
      'File preview will be connected in a later phase.';

  @override
  String get chatSearchHint => 'Search messages';

  @override
  String get chatSearchInitial => 'Search messages in this conversation.';

  @override
  String chatSearchResultCount(int count) {
    return '$count results';
  }

  @override
  String get chatNoMessagesFound => 'No messages found';

  @override
  String get chatNoMessagesFoundBody => 'Try another word or phrase.';

  @override
  String get chatDeleteConversation => 'Delete conversation';

  @override
  String get chatDeleteConversationTitle => 'Delete this conversation?';

  @override
  String get chatDeleteConversationBody =>
      'This removes the local mock conversation history from this device.';

  @override
  String get authCreateAccountTitle => 'Create account';

  @override
  String get authCreateAccountHeading => 'Create your private account';

  @override
  String get authCreateAccountBody =>
      'Set up your Pokidoki account to start connecting with people you trust.';

  @override
  String get authCreateAccountAction => 'Create account';

  @override
  String get authCreateAccountLink => 'Create an account';

  @override
  String get authEmailLabel => 'Email address';

  @override
  String get authEmailOrUsernameLabel => 'Email or username';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authConfirmPasswordLabel => 'Confirm password';

  @override
  String get authPasswordRequirements => 'Your password must include:';

  @override
  String get authPasswordMinLength => 'At least 10 characters';

  @override
  String get authPasswordUppercase => 'One uppercase letter';

  @override
  String get authPasswordLowercase => 'One lowercase letter';

  @override
  String get authPasswordNumber => 'One number';

  @override
  String get authPasswordSymbol => 'One symbol';

  @override
  String get authAgreePrefix => 'I agree to the ';

  @override
  String get authPasswordPrivacyNote =>
      'Your login password protects your account. Your private message keys remain on your device.';

  @override
  String get authAlreadyHaveAccount => 'Already have an account? ';

  @override
  String get authInvalidEmail => 'Enter a valid email address.';

  @override
  String get authPasswordMismatch => 'Passwords do not match.';

  @override
  String get authGenericError => 'Something went wrong. Try again.';

  @override
  String get authSignInTitle => 'Sign in';

  @override
  String get authSignInHeading => 'Welcome back';

  @override
  String get authSignInBody => 'Sign in to access your private conversations.';

  @override
  String get authSignInAction => 'SIGN IN';

  @override
  String get authRememberDevice => 'Remember this device';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authOrContinueSecurely => 'Or continue securely';

  @override
  String get authUseFingerprint => 'Use fingerprint';

  @override
  String get authFingerprintAfterSignIn =>
      'Fingerprint unlock is available after you sign in.';

  @override
  String get authNewToPokidoki => 'New to Pokidoki? ';

  @override
  String get authSignInError =>
      'We could not sign you in. Check your information and try again.';

  @override
  String get authInvalidCredentialsForm =>
      'Enter your email or username and password.';

  @override
  String get authVerifyEmailTitle => 'Verify email';

  @override
  String get authCheckYourEmail => 'Check your email';

  @override
  String get authVerificationBody =>
      'Enter the six-digit verification code we sent to your email address.';

  @override
  String get authVerificationCodeSemantic => 'Verification code';

  @override
  String get authVerifyEmailAction => 'VERIFY EMAIL';

  @override
  String get authResendCode => 'Resend code';

  @override
  String get authResendReady => 'You can resend a code now.';

  @override
  String authResendCountdown(String seconds) {
    return 'Resend available in 00:$seconds';
  }

  @override
  String get authChangeEmail => 'Change email';

  @override
  String get authCodeResent => 'A new verification code was sent.';

  @override
  String get authVerificationError => 'That code is not valid. Try again.';

  @override
  String get authProfileStep1 => 'Profile setup · Step 1 of 2';

  @override
  String get authProfileStep2 => 'Profile setup · Step 2 of 2';

  @override
  String get authUsernameHeading => 'Create your Pokidoki username';

  @override
  String get authUsernameBody =>
      'People can use your username to find you and send a contact request.';

  @override
  String authUsernameAvailable(String username) {
    return '@$username is available';
  }

  @override
  String get authUsernameUnavailable => 'That username is not available.';

  @override
  String get authUsernameRequirements => 'Username requirements';

  @override
  String get authUsernameLength => '3 to 24 characters';

  @override
  String get authUsernameCharset =>
      'Lowercase letters, numbers, periods, and underscores';

  @override
  String get authUsernameStartsWithLetter => 'Must begin with a letter';

  @override
  String get authUsernameNoSpaces => 'No spaces';

  @override
  String get authUsernameUnique => 'Must be unique';

  @override
  String get authCreateProfileTitle => 'Create profile';

  @override
  String get authProfileHeading => 'Make Pokidoki feel like yours';

  @override
  String get authProfileBody =>
      'Add the name and photo that trusted contacts will recognize.';

  @override
  String get authDisplayNameLabel => 'Display name';

  @override
  String get authAboutYouLabel => 'About you (optional)';

  @override
  String get authSkipOptionalDetails => 'Skip optional details';

  @override
  String get authChoosePhoto => 'Choose photo';

  @override
  String get authTakePhoto => 'Take photo';

  @override
  String get authRemovePhoto => 'Remove photo';

  @override
  String get authCreatePinTitle => 'Create app PIN';

  @override
  String get authCreatePinHeading => 'Create an app PIN';

  @override
  String get authCreatePinBody =>
      'Choose a six-digit PIN to protect access to Pokidoki on this device.';

  @override
  String get authPinDifferentFromPassword =>
      'This PIN is different from your account password.';

  @override
  String get authPinLocalProtectionNote =>
      'Your app PIN protects local access. It is not your message-encryption key.';

  @override
  String authPinDigitsEntered(int count) {
    return '$count of 6 digits entered';
  }

  @override
  String get authConfirmPinTitle => 'Confirm app PIN';

  @override
  String get authConfirmPinHeading => 'Confirm your app PIN';

  @override
  String get authConfirmPinBody =>
      'Enter the same six-digit PIN again to make sure you remember it.';

  @override
  String get authConfirmPinAction => 'Confirm PIN';

  @override
  String get authChooseDifferentPin => 'Choose a different PIN';

  @override
  String get authEnterAllSixDigits => 'Enter all six digits to continue';

  @override
  String get authPinMismatch => 'The PINs do not match. Try again.';

  @override
  String get authBiometricsHeading => 'Unlock Pokidoki more quickly';

  @override
  String get authBiometricsBody =>
      'Your app PIN will remain available as a fallback.';

  @override
  String get authBiometricsFasterTitle => 'Faster access';

  @override
  String get authBiometricsFasterBody =>
      'Open Pokidoki without typing your PIN each time.';

  @override
  String get authBiometricsDeviceTitle => 'Protected by your device';

  @override
  String get authBiometricsDeviceBody =>
      'Authentication is handled by your phone\'s security system.';

  @override
  String get authBiometricsPinTitle => 'PIN remains available';

  @override
  String get authBiometricsPinBody =>
      'You can still unlock Pokidoki with your six-digit app PIN.';

  @override
  String get authBiometricsPrivacyNote =>
      'Your biometric data is managed by your device and is not stored by Pokidoki.';

  @override
  String get authEnableBiometricsAction => 'Enable biometric unlock';

  @override
  String get authNotNow => 'Not now';

  @override
  String get authAppLockHeading => 'Pokidoki is locked';

  @override
  String get authAppLockBody =>
      'Enter your six-digit app PIN or use biometrics to access your conversations.';

  @override
  String get authEnterAppPin => 'Enter your app PIN';

  @override
  String get authAppLockError => 'That PIN is incorrect. Try again.';

  @override
  String get authForgotPin => 'Forgot your app PIN?';

  @override
  String get authUseBiometrics => 'Use biometrics';

  @override
  String get authDeleteDigit => 'Delete digit';

  @override
  String get authBiometricsUnavailable =>
      'Biometric unlock is not enabled for this session.';

  @override
  String get stateLoading => 'Loading';

  @override
  String get stateEmpty => 'Nothing here yet';

  @override
  String get stateError => 'Something went wrong';

  @override
  String get stateOffline => 'You appear to be offline';

  @override
  String get navChats => 'Chats';

  @override
  String get navContacts => 'Contacts';

  @override
  String get navSettings => 'Settings';

  @override
  String get semanticVerified => 'Verified';

  @override
  String get semanticClose => 'Close';

  @override
  String get semanticBack => 'Back';

  @override
  String get semanticSearch => 'Search';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsAccountProtected => 'Account protected';

  @override
  String get settingsPrivacySecurity => 'Privacy & Security';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsAppLock => 'App lock';

  @override
  String get settingsAppLockSubtitle => 'PIN and biometrics';

  @override
  String get settingsBiometricUnlock => 'Biometric unlock';

  @override
  String get settingsAutomaticallyLock => 'Automatically lock';

  @override
  String get settingsScreenPrivacy => 'Screen privacy';

  @override
  String get settingsScreenPrivacySubtitle => 'Hide content in app switcher';

  @override
  String get settingsReadReceipts => 'Read receipts';

  @override
  String get settingsTypingIndicators => 'Typing indicators';

  @override
  String get settingsBlockedUsers => 'Blocked users';

  @override
  String get settingsLinkedDevices => 'Linked devices';

  @override
  String settingsActiveDevices(int count) {
    return '$count active';
  }

  @override
  String get settingsSecurityActivity => 'Security activity';

  @override
  String get settingsSecurityActivitySubtitle => 'Review important changes';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsStorageUsage => 'Storage usage';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsMessageNotifications => 'Message notifications';

  @override
  String get settingsNotificationPreviews => 'Notification previews';

  @override
  String get settingsNotificationPreviewsSubtitle => 'Show message text';

  @override
  String get settingsNotificationSound => 'Notification sound';

  @override
  String get settingsNotificationSoundDefault => 'Pokidoki Default';

  @override
  String get settingsVibration => 'Vibration';

  @override
  String get settingsHelpInformation => 'Help & Information';

  @override
  String get settingsHelpCenter => 'Help center';

  @override
  String get settingsHelpPlaceholder =>
      'Help content will be available in a later release.';

  @override
  String get settingsPokidokiVersion => 'Pokidoki version';

  @override
  String get settingsSignOutTitle => 'Sign out of Pokidoki?';

  @override
  String get settingsSignOutBody =>
      'You will need to sign in again to access this account.';

  @override
  String get settingsSignOutAction => 'Sign out';

  @override
  String get settingsPublicIdentity => 'Public identity';

  @override
  String get settingsDisplayName => 'Display name';

  @override
  String get settingsUsername => 'Username';

  @override
  String get settingsPokidokiId => 'Pokidoki ID';

  @override
  String get settingsCopyId => 'Copy Pokidoki ID';

  @override
  String get settingsIdCopied => 'Pokidoki ID copied.';

  @override
  String get settingsSharePublicIdentity =>
      'Share your public Pokidoki identity';

  @override
  String get settingsPreviewPublicProfile => 'Preview public profile';

  @override
  String get settingsPreviewPublicProfileBody =>
      'See what other Pokidoki users can view';

  @override
  String get settingsSignInRecovery => 'Sign-in and recovery';

  @override
  String get settingsEmailAddress => 'Email address';

  @override
  String get settingsVerified => 'Verified';

  @override
  String get settingsPassword => 'Password';

  @override
  String get settingsPasswordChangedAgo => 'Changed 3 months ago';

  @override
  String get settingsAccountRecovery => 'Account recovery';

  @override
  String get settingsAccountRecoverySubtitle =>
      'Review recovery and verification options';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String get settingsDeleteAccountUnavailable =>
      'Delete Account is not available in this UI batch.';

  @override
  String get settingsLinkedDevicesInfo =>
      'Review this list regularly and remove any device you do not recognize.';

  @override
  String get settingsLinkedDevicesError => 'We could not load linked devices.';

  @override
  String get settingsDeviceLinkedRecently => 'A device was linked recently';

  @override
  String get settingsDeviceLinkedRecentlyBody =>
      'Review the device below and remove it if you do not recognize it.';

  @override
  String get settingsThisDevice => 'This device';

  @override
  String get settingsOtherDevices => 'Other devices';

  @override
  String get settingsCurrentDevice => 'Current';

  @override
  String get settingsNeedsReview => 'Needs review';

  @override
  String get settingsActiveNow => 'Active now';

  @override
  String get settingsLastActiveRecently => 'Last active recently';

  @override
  String get settingsNoOtherDevices => 'No other linked devices';

  @override
  String get settingsNoOtherDevicesBody =>
      'Only this phone is currently linked to your account.';

  @override
  String settingsRemoveDeviceTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get settingsRemoveDeviceBody =>
      'This device will need to sign in again.';

  @override
  String get settingsRemoveDeviceAction => 'Remove device';

  @override
  String get settingsDeviceRemoved => 'Device removed.';

  @override
  String get settingsSecurityActivityError =>
      'We could not load security activity.';

  @override
  String get settingsSecurityHistoryTitle => 'Your account security history';

  @override
  String get settingsSecurityHistoryBody =>
      'Review recent security events like new sign-ins, password changes, and device additions.';

  @override
  String settingsEventsNeedReview(int count) {
    return '$count event needs your review';
  }

  @override
  String get settingsFilterAll => 'All';

  @override
  String get settingsFilterDevices => 'Devices';

  @override
  String get settingsFilterIdentity => 'Identity';

  @override
  String get settingsFilterSignIn => 'Sign-in';

  @override
  String get settingsNoSecurityEvents => 'No security events to show.';

  @override
  String get settingsReviewLinkedDevices => 'Review linked devices';

  @override
  String get settingsReviewLinkedDevicesHint =>
      'If you do not recognize this device, review your linked devices.';

  @override
  String get settingsBlockedUsersInfo => 'Blocked accounts cannot contact you';

  @override
  String get settingsBlockedUsersError => 'We could not load blocked users.';

  @override
  String settingsBlockedUsersCount(int count) {
    return '$count blocked users';
  }

  @override
  String get settingsNoBlockedUsers => 'No blocked users';

  @override
  String get settingsNoBlockedUsersBody => 'People you block will appear here.';

  @override
  String settingsUnblockTitle(String name) {
    return 'Unblock $name?';
  }

  @override
  String settingsUnblockBody(String name) {
    return '$name may be able to send you messages or contact requests again.';
  }

  @override
  String get settingsUnblockAction => 'Unblock';

  @override
  String settingsUnblockedSnack(String name) {
    return '$name was unblocked.';
  }

  @override
  String get settingsProtected => 'Protected';

  @override
  String get settingsUseAppLock => 'Use App Lock';

  @override
  String get settingsTurnOffAppLockTitle => 'Turn off App Lock?';

  @override
  String get settingsTurnOffAppLockBody =>
      'Pokidoki will no longer require your app PIN when opening the app.';

  @override
  String get settingsTurnOffAppLockAction => 'Turn off';

  @override
  String get settingsUnlockMethods => 'Unlock Methods';

  @override
  String get settingsChangeAppPin => 'Change app PIN';

  @override
  String get settingsPinLength => 'PIN length';

  @override
  String get settingsPinLengthValue => '6 digits';

  @override
  String get settingsAutomaticLocking => 'Automatic Locking';

  @override
  String get settingsLockImmediately => 'Immediately';

  @override
  String get settingsLockAfter1Minute => 'After 1 minute';

  @override
  String get settingsLockAfter5Minutes => 'After 5 minutes';

  @override
  String get settingsLockAfter30Minutes => 'After 30 minutes';

  @override
  String get settingsLockAfterRestart => 'Require PIN after device restart';

  @override
  String get settingsAlwaysRequired => 'Always required';

  @override
  String get settingsPrivacyWhileLocked => 'Privacy While Locked';

  @override
  String get settingsHideContentInAppSwitcher => 'Hide content in app switcher';

  @override
  String get settingsPinNotPassword =>
      'The app PIN is not your account password';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeSystem => 'Use device setting';

  @override
  String get settingsThemeSystemBody => 'Matches system theme automatically';

  @override
  String get settingsDarkActive => 'Dark appearance is active';

  @override
  String get settingsDarkActiveBody =>
      'Saves battery and reduces eye strain in low light.';

  @override
  String get settingsLightActive => 'Light appearance is active';

  @override
  String get settingsLightActiveBody =>
      'Uses a brighter surface palette for daytime use.';

  @override
  String get settingsSystemActive => 'System appearance is active';

  @override
  String get settingsAppearanceSecurityNote =>
      'Appearance does not change your security';

  @override
  String settingsLanguageActive(String name) {
    return '$name is active';
  }

  @override
  String settingsLanguageActiveBody(String name) {
    return 'Pokidoki menus, settings, and system messages are displayed in $name.';
  }

  @override
  String get settingsAppLanguage => 'App language';

  @override
  String get settingsLeftToRight => 'Left to right';

  @override
  String get settingsRightToLeft => 'Right to left';

  @override
  String get settingsLanguageMessagesNote =>
      'Changing language does not translate messages';

  @override
  String get settingsStorageError => 'We could not calculate storage usage.';

  @override
  String get settingsStorageUsedOnDevice => 'Used by Pokidoki on this device';

  @override
  String settingsStorageSummarySemantic(String total) {
    return 'Total storage used: $total';
  }

  @override
  String get settingsCategories => 'Categories';

  @override
  String get settingsStorageMedia => 'Photos and videos';

  @override
  String get settingsStorageFiles => 'Files';

  @override
  String get settingsStorageVoice => 'Voice messages';

  @override
  String get settingsStorageCache => 'Cache';

  @override
  String get settingsStorageOther => 'Other local data';

  @override
  String get settingsClear => 'Clear';

  @override
  String get settingsClearCache => 'Clear cache';

  @override
  String get settingsClearCacheSubtitle => 'Safely remove temp data';

  @override
  String get settingsClearCacheTitle => 'Clear cached files?';

  @override
  String get settingsClearCacheBody =>
      'Downloaded media can be retrieved again when needed.';

  @override
  String get settingsClearCacheAction => 'Clear cache';

  @override
  String get settingsCacheCleared => 'Cache cleared.';

  @override
  String get accountChangePassword => 'Change Password';

  @override
  String get accountProtectAccount => 'Protect your Pokidoki account';

  @override
  String get accountCurrentPassword => 'Current password';

  @override
  String get accountForgotCurrentPassword => 'Forgot current password?';

  @override
  String get accountNewPassword => 'New password';

  @override
  String get accountConfirmNewPassword => 'Confirm new password';

  @override
  String get accountPasswordRequirements => 'Requirements:';

  @override
  String get accountPasswordMinLength => 'At least 12 characters';

  @override
  String get accountPasswordUpperLower => 'Upper and lowercase letters';

  @override
  String get accountPasswordNumber => 'At least one number';

  @override
  String get accountPasswordSymbol => 'At least one symbol (!@#\$%^&*)';

  @override
  String get accountPasswordDifferent => 'Different from current password';

  @override
  String get accountPasswordMismatch => 'Passwords do not match.';

  @override
  String get accountSignOutOtherDevices => 'Sign out other devices';

  @override
  String get accountSignOutOtherDevicesRecommended =>
      'Recommended for security';

  @override
  String get accountPasswordPinDifferent =>
      'Your password and app PIN are different';

  @override
  String get accountUpdatePassword => 'Update Password';

  @override
  String get accountPasswordUpdated => 'Password updated.';

  @override
  String get accountPasswordUpdateFailed =>
      'We could not update your password. Check your current password and try again.';

  @override
  String get accountSecurityGenericError =>
      'We could not complete this action. Your account remains unchanged.';

  @override
  String get accountShowPassword => 'Show password';

  @override
  String get accountHidePassword => 'Hide password';

  @override
  String get accountEmailTitle => 'Email';

  @override
  String get accountEmailVerifiedTitle => 'Your email is verified';

  @override
  String get accountEmailRecoveryHelp =>
      'This email can be used for account recovery and important security alerts.';

  @override
  String accountVerifiedOn(String date) {
    return 'Verified on $date';
  }

  @override
  String get accountEmailSection => 'Account email';

  @override
  String get accountLastVerified => 'Last verified';

  @override
  String get accountRecoveryAvailable => 'Available';

  @override
  String get accountChangeEmail => 'Change email address';

  @override
  String get accountChangeEmailSubtitle =>
      'Replace the verified email associated with this account';

  @override
  String get accountSecurityEmails => 'Security emails';

  @override
  String get accountSecurityAlerts => 'Security alerts';

  @override
  String get accountSecurityAlertsBody =>
      'Receive important account and device security notifications.';

  @override
  String get accountAlwaysOn => 'Always on';

  @override
  String get accountNewDeviceAlerts => 'New device alerts';

  @override
  String get accountNewDeviceAlertsBody =>
      'Receive an email when a new device is linked or signs in.';

  @override
  String get accountRecoveryAlerts => 'Recovery alerts';

  @override
  String get accountRecoveryAlertsBody =>
      'Receive an email when account recovery is started.';

  @override
  String get accountOptionalCommunications => 'Optional communications';

  @override
  String get accountProductUpdates => 'Product news and tips';

  @override
  String get accountResearchInvitations => 'Research invitations';

  @override
  String get accountEmailNotPublic =>
      'Your verified email helps recover your account and is not shown to contacts.';

  @override
  String get accountReauthenticateTitle => 'Confirm your password';

  @override
  String get accountReauthenticateBody =>
      'Enter your current password to continue changing your email.';

  @override
  String get accountEnterNewEmailBody =>
      'Enter the new email address for this account.';

  @override
  String get accountEmailInvalid => 'Enter a valid email address.';

  @override
  String get accountEmailConflict =>
      'This email cannot be used for this account.';

  @override
  String get accountVerifyEmailTitle => 'Verify your email';

  @override
  String accountVerifyEmailBody(String email) {
    return 'Enter the six-digit code sent to $email.';
  }

  @override
  String get accountVerificationCode => 'Verification code';

  @override
  String get accountVerifyAction => 'Verify';

  @override
  String get accountCodeInvalid =>
      'The verification code is incorrect or has expired.';

  @override
  String get accountEmailUpdated => 'Your email address was updated.';

  @override
  String get accountRecoveryTitle => 'Account Recovery';

  @override
  String get accountRecoveryAvailableTitle => 'Account recovery is available';

  @override
  String get accountRecoveryMethod => 'Recovery method';

  @override
  String get accountVerifiedEmail => 'Verified email';

  @override
  String get accountThisPhone => 'This phone';

  @override
  String get accountRecognized => 'Recognized';

  @override
  String get accountWhatHappensNext => 'What happens next';

  @override
  String get accountRecoveryStep1 => 'Receive a verification code';

  @override
  String get accountRecoveryStep1Body => 'Sent to your verified email address.';

  @override
  String get accountRecoveryStep2 => 'Confirm this device';

  @override
  String get accountRecoveryStep2Body =>
      'Verify that you are using a recognized device.';

  @override
  String get accountRecoveryStep3 => 'Create a new password';

  @override
  String get accountRecoveryStep3Body => 'Choose a strong account password.';

  @override
  String get accountRecoveryStep4 => 'Review account security';

  @override
  String get accountRecoveryStep4Body =>
      'Review linked devices and recent activity.';

  @override
  String get accountLocalDataWarning =>
      'Some protected local data may be unavailable. Recovery confirms account ownership and does not create a backdoor into encrypted conversations.';

  @override
  String get accountStartRecoveryTitle => 'Start account recovery?';

  @override
  String accountStartRecoveryBody(String email) {
    return 'A verification code will be sent to $email.';
  }

  @override
  String get accountStartRecoveryAction => 'Start Recovery';

  @override
  String get accountCancelRecovery => 'Cancel Recovery';

  @override
  String get accountCannotAccessEmail => 'I cannot access this email';

  @override
  String get accountSupportNeverasks =>
      'Support will never ask for your password, app PIN, or verification code.';

  @override
  String get accountRecoveryCodeInvalid =>
      'The verification code is incorrect or has expired.';

  @override
  String get accountCreateNewPassword => 'Create a new password';

  @override
  String get accountRestoreAccess => 'Restore access';

  @override
  String get accountRecoveryCompleted => 'Account access restored.';

  @override
  String get accountRecoveryCompletedBody =>
      'You can continue using Pokidoki with your new password. Your app PIN was not changed.';

  @override
  String get reportUserTitle => 'Report user';

  @override
  String get reportBlockedBadge => 'Blocked';

  @override
  String get reportHelpReview => 'Reports help Pokidoki review possible abuse';

  @override
  String get reportWhyTitle => 'Why are you reporting this account?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Harassment';

  @override
  String get reportReasonImpersonation => 'Impersonation';

  @override
  String get reportReasonThreats => 'Threats or violence';

  @override
  String get reportReasonInappropriate => 'Sexual or inappropriate content';

  @override
  String get reportReasonScam => 'Scam or fraud';

  @override
  String get reportReasonOther => 'Other';

  @override
  String get reportAdditionalDetails => 'Additional details (Optional)';

  @override
  String get reportDetailsHelper =>
      'Do not enter passwords, PINs, verification codes, or private keys.';

  @override
  String get reportEvidence => 'Evidence';

  @override
  String get reportIncludeEvidence => 'Include selected conversation evidence';

  @override
  String get reportEvidenceDefaultOff =>
      'Nothing is included by default. Select messages from the chat to include them as evidence.';

  @override
  String reportSelectedEvidenceCount(int count) {
    return '$count selected';
  }

  @override
  String get reportSelectEvidence => 'Select evidence';

  @override
  String get reportNotBlocking =>
      'Reporting is not blocking. Reporting sends information for review. Blocking prevents new contact requests or messages.';

  @override
  String get reportWhatWillBeSent => 'What will be sent';

  @override
  String get reportAccountIdentifier => 'Account identifier';

  @override
  String get reportReasonLabel => 'Reason';

  @override
  String get reportDetailsLabel => 'Details';

  @override
  String get reportNotSelected => 'Not selected';

  @override
  String get reportNone => 'None';

  @override
  String get reportDetailsIncluded => 'Included';

  @override
  String get reportNotIncluded => 'Not included';

  @override
  String get reportReviewData => 'Review report data';

  @override
  String get reportSubmitTitle => 'Submit this report?';

  @override
  String get reportSubmitBody =>
      'Pokidoki will receive the selected reason, your optional details, and only the evidence you reviewed.';

  @override
  String reportRemainsBlocked(String name) {
    return '$name will remain blocked.';
  }

  @override
  String get reportSubmitAction => 'Submit Report';

  @override
  String get reportSubmitted => 'Report submitted.';

  @override
  String get reportSubmitFailed => 'Your report has not been sent.';

  @override
  String get reportNotEmergency =>
      'Pokidoki reports are not an emergency service.';
}
