import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// Application display name
  ///
  /// In en, this message translates to:
  /// **'Pokidoki'**
  String get appName;

  /// Supporting line shown on the splash screen
  ///
  /// In en, this message translates to:
  /// **'Private conversations, protected.'**
  String get splashTagline;

  /// Initialization status line on the splash screen
  ///
  /// In en, this message translates to:
  /// **'Securing your space'**
  String get splashPreparing;

  /// Screen-reader announcement while splash initializes
  ///
  /// In en, this message translates to:
  /// **'Pokidoki is starting'**
  String get splashLoadingSemantic;

  /// Screen-reader announcement when splash bootstrap completes
  ///
  /// In en, this message translates to:
  /// **'Pokidoki is ready'**
  String get splashReadySemantic;

  /// Primary continue action
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// Uppercase continue action for onboarding page 2
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get actionContinueUpper;

  /// Final onboarding primary action
  ///
  /// In en, this message translates to:
  /// **'GET STARTED'**
  String get actionGetStarted;

  /// Skip onboarding action
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionSkip;

  /// Generic retry action label
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionRetry;

  /// Welcome primary action
  ///
  /// In en, this message translates to:
  /// **'CREATE ACCOUNT'**
  String get actionCreateAccount;

  /// Welcome secondary action
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get actionSignIn;

  /// Screen-reader announcement for onboarding progress
  ///
  /// In en, this message translates to:
  /// **'Onboarding page {current} of {total}'**
  String onboardingPageSemantic(int current, int total);

  /// Onboarding page 1 title
  ///
  /// In en, this message translates to:
  /// **'Your conversations stay private'**
  String get onboarding1Title;

  /// Onboarding page 1 body
  ///
  /// In en, this message translates to:
  /// **'Messages are protected on your device and can only be read by conversation participants.'**
  String get onboarding1Body;

  /// Accessibility label for onboarding page 1 illustration
  ///
  /// In en, this message translates to:
  /// **'Illustration of private conversation between two people'**
  String get onboarding1IllustrationSemantic;

  /// Onboarding page 2 title
  ///
  /// In en, this message translates to:
  /// **'Know who you are talking to'**
  String get onboarding2Title;

  /// Onboarding page 2 body
  ///
  /// In en, this message translates to:
  /// **'Verify trusted contacts using a QR code or safety number before sharing sensitive information.'**
  String get onboarding2Body;

  /// Accessibility label for onboarding page 2 illustration
  ///
  /// In en, this message translates to:
  /// **'Illustration of contact verification with a QR code and checkmark'**
  String get onboarding2IllustrationSemantic;

  /// Onboarding page 3 title
  ///
  /// In en, this message translates to:
  /// **'Your private space stays locked'**
  String get onboarding3Title;

  /// Onboarding page 3 body
  ///
  /// In en, this message translates to:
  /// **'Protect Pokidoki with an app PIN and your device biometrics, so only you can access your conversations.'**
  String get onboarding3Body;

  /// Accessibility label for onboarding page 3 illustration
  ///
  /// In en, this message translates to:
  /// **'Illustration of app lock with PIN and biometrics'**
  String get onboarding3IllustrationSemantic;

  /// Welcome screen headline
  ///
  /// In en, this message translates to:
  /// **'Welcome to your private space'**
  String get welcomeTitle;

  /// Welcome screen supporting text
  ///
  /// In en, this message translates to:
  /// **'Connect with the people you trust and keep your conversations protected.'**
  String get welcomeBody;

  /// Welcome reassurance row for private conversations
  ///
  /// In en, this message translates to:
  /// **'Private conversations'**
  String get welcomeFeaturePrivate;

  /// Welcome reassurance row for contact verification
  ///
  /// In en, this message translates to:
  /// **'Contact verification'**
  String get welcomeFeatureVerification;

  /// Welcome reassurance row for app lock
  ///
  /// In en, this message translates to:
  /// **'App lock protection'**
  String get welcomeFeatureAppLock;

  /// Terms disclaimer prefix
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to the '**
  String get welcomeTermsPrefix;

  /// Terms of Service link label
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get welcomeTermsOfService;

  /// Terms disclaimer conjunction
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get welcomeTermsMiddle;

  /// Privacy Policy link label
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get welcomePrivacyPolicy;

  /// Terms disclaimer suffix
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get welcomeTermsSuffix;

  /// Welcome footer privacy reassurance
  ///
  /// In en, this message translates to:
  /// **'Pokidoki cannot read your private messages.'**
  String get welcomePrivacyNote;

  /// English language label
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Arabic language label
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// French language label
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// Accessibility label for language selector
  ///
  /// In en, this message translates to:
  /// **'Language, currently {language}'**
  String languageSelectorSemantic(String language);

  /// Temporary development placeholder title
  ///
  /// In en, this message translates to:
  /// **'Screen not implemented yet'**
  String get devPlaceholderTitle;

  /// Temporary development placeholder body
  ///
  /// In en, this message translates to:
  /// **'This destination is reserved for a later implementation batch.'**
  String get devPlaceholderBody;

  /// Badge marking the placeholder as non-production
  ///
  /// In en, this message translates to:
  /// **'Temporary development screen'**
  String get devPlaceholderBadge;

  /// Placeholder message for create account
  ///
  /// In en, this message translates to:
  /// **'Create Account is not implemented yet.'**
  String get devScreenCreateAccount;

  /// Placeholder message for sign in
  ///
  /// In en, this message translates to:
  /// **'Sign In is not implemented yet.'**
  String get devScreenSignIn;

  /// No description provided for @devConversationsHome.
  ///
  /// In en, this message translates to:
  /// **'Conversations Home will be implemented in a later batch.'**
  String get devConversationsHome;

  /// No description provided for @devAccountRecovery.
  ///
  /// In en, this message translates to:
  /// **'Account Recovery will be implemented in the next batch.'**
  String get devAccountRecovery;

  /// No description provided for @devAccountRecoveryNextBatch.
  ///
  /// In en, this message translates to:
  /// **'Account Recovery will be implemented in the next batch.'**
  String get devAccountRecoveryNextBatch;

  /// No description provided for @devPinRecovery.
  ///
  /// In en, this message translates to:
  /// **'App PIN recovery will be implemented in a later batch.'**
  String get devPinRecovery;

  /// No description provided for @devSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings will be implemented in a later batch.'**
  String get devSettings;

  /// No description provided for @devOneToOneChat.
  ///
  /// In en, this message translates to:
  /// **'One-to-One Chat will be implemented in a later batch.'**
  String get devOneToOneChat;

  /// No description provided for @devQrScanner.
  ///
  /// In en, this message translates to:
  /// **'QR Scanner will be implemented in a later batch.'**
  String get devQrScanner;

  /// No description provided for @devReportUser.
  ///
  /// In en, this message translates to:
  /// **'Report User will be implemented in the next batch.'**
  String get devReportUser;

  /// No description provided for @devChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password will be implemented in the next batch.'**
  String get devChangePassword;

  /// No description provided for @devEmailManagement.
  ///
  /// In en, this message translates to:
  /// **'Email Management will be implemented in the next batch.'**
  String get devEmailManagement;

  /// No description provided for @actionTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionTryAgain;

  /// No description provided for @routeNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get routeNotFoundTitle;

  /// No description provided for @routeNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'This link is not available in the app.'**
  String get routeNotFoundBody;

  /// No description provided for @routeNotFoundAction.
  ///
  /// In en, this message translates to:
  /// **'Go to Welcome'**
  String get routeNotFoundAction;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @chatsYouPrefix.
  ///
  /// In en, this message translates to:
  /// **'You: '**
  String get chatsYouPrefix;

  /// No description provided for @chatsYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get chatsYesterday;

  /// No description provided for @chatsUnreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unread messages'**
  String chatsUnreadCount(int count);

  /// No description provided for @chatsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search conversations'**
  String get chatsSearchHint;

  /// No description provided for @chatsProtectedBanner.
  ///
  /// In en, this message translates to:
  /// **'Your conversations are protected with end-to-end encryption.'**
  String get chatsProtectedBanner;

  /// No description provided for @chatsPinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get chatsPinned;

  /// No description provided for @chatsRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get chatsRecent;

  /// No description provided for @chatsRecentContacts.
  ///
  /// In en, this message translates to:
  /// **'Recent contacts'**
  String get chatsRecentContacts;

  /// No description provided for @chatsNewConversation.
  ///
  /// In en, this message translates to:
  /// **'New conversation'**
  String get chatsNewConversation;

  /// No description provided for @chatsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get chatsEmptyTitle;

  /// No description provided for @chatsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Start a private conversation with one of your contacts.'**
  String get chatsEmptyBody;

  /// No description provided for @contactsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search contacts'**
  String get contactsSearchHint;

  /// No description provided for @contactsRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact requests'**
  String get contactsRequestsTitle;

  /// No description provided for @contactsRequestsWaiting.
  ///
  /// In en, this message translates to:
  /// **'{count} requests are waiting for your review.'**
  String contactsRequestsWaiting(int count);

  /// No description provided for @contactsVerifiedSection.
  ///
  /// In en, this message translates to:
  /// **'Verified contacts'**
  String get contactsVerifiedSection;

  /// No description provided for @contactsAllContacts.
  ///
  /// In en, this message translates to:
  /// **'All contacts'**
  String get contactsAllContacts;

  /// No description provided for @contactsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get contactsEmptyTitle;

  /// No description provided for @contactsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Search for someone or accept a contact request.'**
  String get contactsEmptyBody;

  /// No description provided for @contactsReviewRequests.
  ///
  /// In en, this message translates to:
  /// **'Review requests'**
  String get contactsReviewRequests;

  /// No description provided for @contactsRequestsInfo.
  ///
  /// In en, this message translates to:
  /// **'Accepting a request adds the account to your contacts. It does not verify the person’s identity. Verify the contact before sharing sensitive information.'**
  String get contactsRequestsInfo;

  /// No description provided for @contactsReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get contactsReceived;

  /// No description provided for @contactsSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get contactsSent;

  /// No description provided for @contactsAccept.
  ///
  /// In en, this message translates to:
  /// **'ACCEPT'**
  String get contactsAccept;

  /// No description provided for @contactsDecline.
  ///
  /// In en, this message translates to:
  /// **'DECLINE'**
  String get contactsDecline;

  /// No description provided for @contactsCancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get contactsCancelRequest;

  /// No description provided for @contactsRequestAccepted.
  ///
  /// In en, this message translates to:
  /// **'Contact request accepted.'**
  String get contactsRequestAccepted;

  /// No description provided for @contactsRequestDeclined.
  ///
  /// In en, this message translates to:
  /// **'Contact request declined.'**
  String get contactsRequestDeclined;

  /// No description provided for @contactsNoReceivedRequests.
  ///
  /// In en, this message translates to:
  /// **'No received requests.'**
  String get contactsNoReceivedRequests;

  /// No description provided for @contactsNoSentRequests.
  ///
  /// In en, this message translates to:
  /// **'No sent requests.'**
  String get contactsNoSentRequests;

  /// No description provided for @usersFindSomeone.
  ///
  /// In en, this message translates to:
  /// **'Find someone'**
  String get usersFindSomeone;

  /// No description provided for @usersFindPeople.
  ///
  /// In en, this message translates to:
  /// **'Find people'**
  String get usersFindPeople;

  /// No description provided for @usersSearchByUsernameOrId.
  ///
  /// In en, this message translates to:
  /// **'Search by username or Pokidoki ID'**
  String get usersSearchByUsernameOrId;

  /// No description provided for @usersSearchInitial.
  ///
  /// In en, this message translates to:
  /// **'Search by username or Pokidoki ID.'**
  String get usersSearchInitial;

  /// No description provided for @usersNoResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get usersNoResultsTitle;

  /// No description provided for @usersNoResultsBody.
  ///
  /// In en, this message translates to:
  /// **'Try another username or Pokidoki ID.'**
  String get usersNoResultsBody;

  /// No description provided for @usersScanQr.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get usersScanQr;

  /// No description provided for @usersScanQrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add or verify someone nearby'**
  String get usersScanQrSubtitle;

  /// No description provided for @usersNewGroup.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get usersNewGroup;

  /// No description provided for @usersNewGroupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a private conversation...'**
  String get usersNewGroupSubtitle;

  /// No description provided for @usersComingLater.
  ///
  /// In en, this message translates to:
  /// **'Coming later'**
  String get usersComingLater;

  /// No description provided for @usersProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get usersProfileTitle;

  /// No description provided for @usersSendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send contact request'**
  String get usersSendRequest;

  /// No description provided for @usersRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Contact request sent.'**
  String get usersRequestSent;

  /// No description provided for @usersRequestPending.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get usersRequestPending;

  /// No description provided for @usersMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get usersMessage;

  /// No description provided for @usersNotInContacts.
  ///
  /// In en, this message translates to:
  /// **'Not in your contacts'**
  String get usersNotInContacts;

  /// No description provided for @usersInContacts.
  ///
  /// In en, this message translates to:
  /// **'In your contacts'**
  String get usersInContacts;

  /// No description provided for @usersNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get usersNotVerified;

  /// No description provided for @usersVerifyBeforeSensitive.
  ///
  /// In en, this message translates to:
  /// **'Verify this person before sharing sensitive information.'**
  String get usersVerifyBeforeSensitive;

  /// No description provided for @usersAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get usersAbout;

  /// No description provided for @usersSharedContext.
  ///
  /// In en, this message translates to:
  /// **'Shared context'**
  String get usersSharedContext;

  /// No description provided for @usersCopyId.
  ///
  /// In en, this message translates to:
  /// **'Copy Pokidoki ID'**
  String get usersCopyId;

  /// No description provided for @usersBlockAction.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get usersBlockAction;

  /// No description provided for @usersReportAction.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get usersReportAction;

  /// No description provided for @usersBlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Block {name}?'**
  String usersBlockTitle(String name);

  /// No description provided for @usersBlockBody.
  ///
  /// In en, this message translates to:
  /// **'{name} will not be able to send you new contact requests or messages.'**
  String usersBlockBody(String name);

  /// No description provided for @usersBlocked.
  ///
  /// In en, this message translates to:
  /// **'User blocked.'**
  String get usersBlocked;

  /// No description provided for @qrScanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get qrScanTitle;

  /// No description provided for @qrScanHeading.
  ///
  /// In en, this message translates to:
  /// **'Scan a Pokidoki QR code'**
  String get qrScanHeading;

  /// No description provided for @qrScanBody.
  ///
  /// In en, this message translates to:
  /// **'Place the code inside the frame to add or verify someone'**
  String get qrScanBody;

  /// No description provided for @qrLookingForCode.
  ///
  /// In en, this message translates to:
  /// **'Looking for a Pokidoki code...'**
  String get qrLookingForCode;

  /// No description provided for @qrFrameSemantic.
  ///
  /// In en, this message translates to:
  /// **'QR scanning frame'**
  String get qrFrameSemantic;

  /// No description provided for @qrSimulateScan.
  ///
  /// In en, this message translates to:
  /// **'Simulate scan'**
  String get qrSimulateScan;

  /// No description provided for @qrInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'This QR code is not a valid Pokidoki contact code.'**
  String get qrInvalidCode;

  /// No description provided for @qrFlash.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get qrFlash;

  /// No description provided for @qrGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get qrGallery;

  /// No description provided for @qrMyCodeAction.
  ///
  /// In en, this message translates to:
  /// **'My QR Code'**
  String get qrMyCodeAction;

  /// No description provided for @qrMyCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'My Pokidoki QR'**
  String get qrMyCodeTitle;

  /// No description provided for @qrHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get qrHelp;

  /// No description provided for @qrBrightness.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get qrBrightness;

  /// No description provided for @qrCodeSemantic.
  ///
  /// In en, this message translates to:
  /// **'Your Pokidoki contact QR code'**
  String get qrCodeSemantic;

  /// No description provided for @qrPublicIdentity.
  ///
  /// In en, this message translates to:
  /// **'Your public Pokidoki identity'**
  String get qrPublicIdentity;

  /// No description provided for @qrPublicIdHelp.
  ///
  /// In en, this message translates to:
  /// **'People can use this ID to find your account.'**
  String get qrPublicIdHelp;

  /// No description provided for @qrShareExplanation.
  ///
  /// In en, this message translates to:
  /// **'Your Pokidoki QR code helps people find or verify your account without typing your username or ID.'**
  String get qrShareExplanation;

  /// No description provided for @qrShareAction.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get qrShareAction;

  /// No description provided for @qrShareReady.
  ///
  /// In en, this message translates to:
  /// **'Your Pokidoki contact code is ready to share.'**
  String get qrShareReady;

  /// No description provided for @qrRefreshAction.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get qrRefreshAction;

  /// No description provided for @qrRefreshTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new QR code?'**
  String get qrRefreshTitle;

  /// No description provided for @qrRefreshBody.
  ///
  /// In en, this message translates to:
  /// **'The previous contact code will no longer be used for new scans.'**
  String get qrRefreshBody;

  /// No description provided for @verifyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify contact'**
  String get verifyContactTitle;

  /// No description provided for @verifyNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get verifyNotVerified;

  /// No description provided for @verifyQrRecognized.
  ///
  /// In en, this message translates to:
  /// **'QR code recognized'**
  String get verifyQrRecognized;

  /// No description provided for @verifyQrRecognizedBody.
  ///
  /// In en, this message translates to:
  /// **'This code belongs to {name}’s Pokidoki profile.'**
  String verifyQrRecognizedBody(String name);

  /// No description provided for @verifyConfirmInPerson.
  ///
  /// In en, this message translates to:
  /// **'Confirm that you are talking to the right person'**
  String get verifyConfirmInPerson;

  /// No description provided for @verifyScanQrMethod.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get verifyScanQrMethod;

  /// No description provided for @verifyScanQrMethodBody.
  ///
  /// In en, this message translates to:
  /// **'Recommended when you are together'**
  String get verifyScanQrMethodBody;

  /// No description provided for @verifyCompareSafetyNumber.
  ///
  /// In en, this message translates to:
  /// **'Compare safety number'**
  String get verifyCompareSafetyNumber;

  /// No description provided for @verifyCompareSafetyNumberBody.
  ///
  /// In en, this message translates to:
  /// **'Useful when you are not in the same place'**
  String get verifyCompareSafetyNumberBody;

  /// No description provided for @verifyWhatItConfirms.
  ///
  /// In en, this message translates to:
  /// **'What verification confirms'**
  String get verifyWhatItConfirms;

  /// No description provided for @verifyBulletSameIdentity.
  ///
  /// In en, this message translates to:
  /// **'You are comparing the same contact identity'**
  String get verifyBulletSameIdentity;

  /// No description provided for @verifyBulletNotReplaced.
  ///
  /// In en, this message translates to:
  /// **'The contact’s security identity has not been unexpectedly replaced'**
  String get verifyBulletNotReplaced;

  /// No description provided for @verifyBulletMarkedOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki can mark this contact as verified on your device'**
  String get verifyBulletMarkedOnDevice;

  /// No description provided for @verifyMarkTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify {name}?'**
  String verifyMarkTitle(String name);

  /// No description provided for @verifyMarkBody.
  ///
  /// In en, this message translates to:
  /// **'Only continue if you confirmed this profile with {name} in person or through another trusted channel.'**
  String verifyMarkBody(String name);

  /// No description provided for @verifyMarkAction.
  ///
  /// In en, this message translates to:
  /// **'Mark as verified'**
  String get verifyMarkAction;

  /// No description provided for @verifySafetyConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Safety number confirmed.'**
  String get verifySafetyConfirmed;

  /// No description provided for @verifyResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset verification?'**
  String get verifyResetTitle;

  /// No description provided for @verifyResetBody.
  ///
  /// In en, this message translates to:
  /// **'{name} will appear unverified until you compare the identity again.'**
  String verifyResetBody(String name);

  /// No description provided for @verifyResetAction.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get verifyResetAction;

  /// No description provided for @safetyNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety number'**
  String get safetyNumberTitle;

  /// No description provided for @safetyCompareHeading.
  ///
  /// In en, this message translates to:
  /// **'Compare this number with {name}'**
  String safetyCompareHeading(String name);

  /// No description provided for @safetyCompareBody.
  ///
  /// In en, this message translates to:
  /// **'Both devices should display the same safety number. Compare it in person or through another communication method you already trust.'**
  String get safetyCompareBody;

  /// No description provided for @safetyNumberSemantic.
  ///
  /// In en, this message translates to:
  /// **'Safety number digit groups'**
  String get safetyNumberSemantic;

  /// No description provided for @safetyNumberCopied.
  ///
  /// In en, this message translates to:
  /// **'Safety number copied.'**
  String get safetyNumberCopied;

  /// No description provided for @safetyDoNotCompareOnlyInChat.
  ///
  /// In en, this message translates to:
  /// **'Do not compare this number only inside the conversation you are verifying.'**
  String get safetyDoNotCompareOnlyInChat;

  /// No description provided for @chatTypeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get chatTypeMessage;

  /// No description provided for @chatSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get chatSend;

  /// No description provided for @chatPeerTyping.
  ///
  /// In en, this message translates to:
  /// **'Typing…'**
  String get chatPeerTyping;

  /// No description provided for @chatAttach.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get chatAttach;

  /// No description provided for @chatReply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get chatReply;

  /// No description provided for @chatCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get chatCopy;

  /// No description provided for @chatDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get chatDelete;

  /// No description provided for @chatDeleteForMe.
  ///
  /// In en, this message translates to:
  /// **'Delete for me'**
  String get chatDeleteForMe;

  /// No description provided for @chatDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this message?'**
  String get chatDeleteTitle;

  /// No description provided for @chatDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the message from this device.'**
  String get chatDeleteBody;

  /// No description provided for @chatMessageInfo.
  ///
  /// In en, this message translates to:
  /// **'Message info'**
  String get chatMessageInfo;

  /// No description provided for @chatMessageCopied.
  ///
  /// In en, this message translates to:
  /// **'Message copied.'**
  String get chatMessageCopied;

  /// No description provided for @chatSearchInConversation.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get chatSearchInConversation;

  /// No description provided for @chatConversationInfo.
  ///
  /// In en, this message translates to:
  /// **'Conversation info'**
  String get chatConversationInfo;

  /// No description provided for @chatProtectedBanner.
  ///
  /// In en, this message translates to:
  /// **'Messages in this conversation are protected with end-to-end encryption.'**
  String get chatProtectedBanner;

  /// No description provided for @chatToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chatToday;

  /// No description provided for @chatAttachmentLater.
  ///
  /// In en, this message translates to:
  /// **'Attachment selection will be connected in a later phase.'**
  String get chatAttachmentLater;

  /// No description provided for @chatBlockedNotice.
  ///
  /// In en, this message translates to:
  /// **'You blocked {name}.'**
  String chatBlockedNotice(String name);

  /// No description provided for @chatSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get chatSent;

  /// No description provided for @chatDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get chatDelivered;

  /// No description provided for @chatRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get chatRead;

  /// No description provided for @chatMuteNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get chatMuteNotifications;

  /// No description provided for @chatDisappearingMessages.
  ///
  /// In en, this message translates to:
  /// **'Disappearing messages'**
  String get chatDisappearingMessages;

  /// No description provided for @chatDisappearingOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get chatDisappearingOff;

  /// No description provided for @chatDisappearingOffHelp.
  ///
  /// In en, this message translates to:
  /// **'Messages stay until deleted'**
  String get chatDisappearingOffHelp;

  /// No description provided for @chatDisappearingOneHour.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get chatDisappearingOneHour;

  /// No description provided for @chatDisappearingOneHourHelp.
  ///
  /// In en, this message translates to:
  /// **'Standard temporary chat'**
  String get chatDisappearingOneHourHelp;

  /// No description provided for @chatDisappearingOneDay.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get chatDisappearingOneDay;

  /// No description provided for @chatDisappearingOneDayHelp.
  ///
  /// In en, this message translates to:
  /// **'Default privacy setting'**
  String get chatDisappearingOneDayHelp;

  /// No description provided for @chatDisappearingOneWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get chatDisappearingOneWeek;

  /// No description provided for @chatDisappearingOneWeekHelp.
  ///
  /// In en, this message translates to:
  /// **'Extended conversation history'**
  String get chatDisappearingOneWeekHelp;

  /// No description provided for @chatDisappearingAppliesFuture.
  ///
  /// In en, this message translates to:
  /// **'The new timer applies to future messages. Previous messages will keep their original timer.'**
  String get chatDisappearingAppliesFuture;

  /// No description provided for @chatDisappearingScreenshotWarning.
  ///
  /// In en, this message translates to:
  /// **'Disappearing does not prevent copying. Recipients can still take screenshots, copy text, or forward messages before they disappear.'**
  String get chatDisappearingScreenshotWarning;

  /// No description provided for @chatSharedContent.
  ///
  /// In en, this message translates to:
  /// **'Shared content'**
  String get chatSharedContent;

  /// No description provided for @chatSharedWith.
  ///
  /// In en, this message translates to:
  /// **'Shared with {name}'**
  String chatSharedWith(String name);

  /// No description provided for @chatPhotosAndVideos.
  ///
  /// In en, this message translates to:
  /// **'Photos and videos'**
  String get chatPhotosAndVideos;

  /// No description provided for @chatFiles.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get chatFiles;

  /// No description provided for @chatLinks.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get chatLinks;

  /// No description provided for @chatMedia.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get chatMedia;

  /// No description provided for @chatNoMedia.
  ///
  /// In en, this message translates to:
  /// **'No media yet'**
  String get chatNoMedia;

  /// No description provided for @chatNoFiles.
  ///
  /// In en, this message translates to:
  /// **'No files yet'**
  String get chatNoFiles;

  /// No description provided for @chatNoLinks.
  ///
  /// In en, this message translates to:
  /// **'No links yet'**
  String get chatNoLinks;

  /// No description provided for @chatFilePreviewLater.
  ///
  /// In en, this message translates to:
  /// **'File preview will be connected in a later phase.'**
  String get chatFilePreviewLater;

  /// No description provided for @chatSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search messages'**
  String get chatSearchHint;

  /// No description provided for @chatSearchInitial.
  ///
  /// In en, this message translates to:
  /// **'Search messages in this conversation.'**
  String get chatSearchInitial;

  /// No description provided for @chatSearchResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count} results'**
  String chatSearchResultCount(int count);

  /// No description provided for @chatNoMessagesFound.
  ///
  /// In en, this message translates to:
  /// **'No messages found'**
  String get chatNoMessagesFound;

  /// No description provided for @chatNoMessagesFoundBody.
  ///
  /// In en, this message translates to:
  /// **'Try another word or phrase.'**
  String get chatNoMessagesFoundBody;

  /// No description provided for @chatDeleteConversation.
  ///
  /// In en, this message translates to:
  /// **'Delete conversation'**
  String get chatDeleteConversation;

  /// No description provided for @chatDeleteConversationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this conversation?'**
  String get chatDeleteConversationTitle;

  /// No description provided for @chatDeleteConversationBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the local mock conversation history from this device.'**
  String get chatDeleteConversationBody;

  /// No description provided for @authCreateAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccountTitle;

  /// No description provided for @authCreateAccountHeading.
  ///
  /// In en, this message translates to:
  /// **'Create your private account'**
  String get authCreateAccountHeading;

  /// No description provided for @authCreateAccountBody.
  ///
  /// In en, this message translates to:
  /// **'Set up your Pokidoki account to start connecting with people you trust.'**
  String get authCreateAccountBody;

  /// No description provided for @authCreateAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccountAction;

  /// No description provided for @authCreateAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get authCreateAccountLink;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get authEmailLabel;

  /// No description provided for @authEmailOrUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Email or username'**
  String get authEmailOrUsernameLabel;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authPasswordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Your password must include:'**
  String get authPasswordRequirements;

  /// No description provided for @authPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'At least 12 characters'**
  String get authPasswordMinLength;

  /// No description provided for @authPasswordUppercase.
  ///
  /// In en, this message translates to:
  /// **'One uppercase letter'**
  String get authPasswordUppercase;

  /// No description provided for @authPasswordLowercase.
  ///
  /// In en, this message translates to:
  /// **'One lowercase letter'**
  String get authPasswordLowercase;

  /// No description provided for @authPasswordNumber.
  ///
  /// In en, this message translates to:
  /// **'One number'**
  String get authPasswordNumber;

  /// No description provided for @authPasswordSymbol.
  ///
  /// In en, this message translates to:
  /// **'One symbol'**
  String get authPasswordSymbol;

  /// No description provided for @authAgreePrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get authAgreePrefix;

  /// No description provided for @authPasswordPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Your login password protects your account. Your private message keys remain on your device.'**
  String get authPasswordPrivacyNote;

  /// No description provided for @authAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get authAlreadyHaveAccount;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authInvalidEmail;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get authPasswordMismatch;

  /// No description provided for @authGenericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get authGenericError;

  /// No description provided for @authEmailUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This email cannot be used. Try another address.'**
  String get authEmailUnavailable;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'We could not sign you in. Check your information and try again.'**
  String get authInvalidCredentials;

  /// No description provided for @authEmailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Verify your email before signing in.'**
  String get authEmailNotVerified;

  /// No description provided for @authAccountSuspended.
  ///
  /// In en, this message translates to:
  /// **'This account is temporarily unavailable.'**
  String get authAccountSuspended;

  /// No description provided for @authAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account is disabled.'**
  String get authAccountDisabled;

  /// No description provided for @authVerificationInvalid.
  ///
  /// In en, this message translates to:
  /// **'That code is not valid. Try again.'**
  String get authVerificationInvalid;

  /// No description provided for @authVerificationExpired.
  ///
  /// In en, this message translates to:
  /// **'That code has expired. Request a new one.'**
  String get authVerificationExpired;

  /// No description provided for @authVerificationAttemptsExceeded.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Request a new code.'**
  String get authVerificationAttemptsExceeded;

  /// No description provided for @authVerificationResendTooSoon.
  ///
  /// In en, this message translates to:
  /// **'Please wait before requesting another code.'**
  String get authVerificationResendTooSoon;

  /// No description provided for @authSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session expired. Sign in again.'**
  String get authSessionExpired;

  /// No description provided for @authRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait and try again.'**
  String get authRateLimited;

  /// No description provided for @authNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your network and try again.'**
  String get authNoInternet;

  /// No description provided for @authRequestTimedOut.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Try again.'**
  String get authRequestTimedOut;

  /// No description provided for @authServerUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The server is unavailable. Try again later.'**
  String get authServerUnavailable;

  /// No description provided for @authUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get authUnexpectedError;

  /// No description provided for @profileNotCreated.
  ///
  /// In en, this message translates to:
  /// **'Your profile has not been set up yet.'**
  String get profileNotCreated;

  /// No description provided for @profileAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'A profile already exists for this account.'**
  String get profileAlreadyExists;

  /// No description provided for @profileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Profile not found.'**
  String get profileNotFound;

  /// No description provided for @profileNotDiscoverable.
  ///
  /// In en, this message translates to:
  /// **'This profile is not available.'**
  String get profileNotDiscoverable;

  /// No description provided for @usernameInvalid.
  ///
  /// In en, this message translates to:
  /// **'That username is not valid.'**
  String get usernameInvalid;

  /// No description provided for @usernameChangeTooSoon.
  ///
  /// In en, this message translates to:
  /// **'You changed your username recently. Try again later.'**
  String get usernameChangeTooSoon;

  /// No description provided for @userSearchQueryTooShort.
  ///
  /// In en, this message translates to:
  /// **'Enter at least two characters to search.'**
  String get userSearchQueryTooShort;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get userNotFound;

  /// No description provided for @userUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get userUnexpectedError;

  /// No description provided for @authSignedOut.
  ///
  /// In en, this message translates to:
  /// **'You have been signed out.'**
  String get authSignedOut;

  /// No description provided for @authSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInTitle;

  /// No description provided for @authSignInHeading.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authSignInHeading;

  /// No description provided for @authSignInBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your private conversations.'**
  String get authSignInBody;

  /// No description provided for @authSignInAction.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get authSignInAction;

  /// No description provided for @authRememberDevice.
  ///
  /// In en, this message translates to:
  /// **'Remember this device'**
  String get authRememberDevice;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authOrContinueSecurely.
  ///
  /// In en, this message translates to:
  /// **'Or continue securely'**
  String get authOrContinueSecurely;

  /// No description provided for @authUseFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint'**
  String get authUseFingerprint;

  /// No description provided for @authFingerprintAfterSignIn.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint unlock is available after you sign in.'**
  String get authFingerprintAfterSignIn;

  /// No description provided for @authNewToPokidoki.
  ///
  /// In en, this message translates to:
  /// **'New to Pokidoki? '**
  String get authNewToPokidoki;

  /// No description provided for @authSignInError.
  ///
  /// In en, this message translates to:
  /// **'We could not sign you in. Check your information and try again.'**
  String get authSignInError;

  /// No description provided for @authInvalidCredentialsForm.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or username and password.'**
  String get authInvalidCredentialsForm;

  /// No description provided for @authVerifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify email'**
  String get authVerifyEmailTitle;

  /// No description provided for @authCheckYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get authCheckYourEmail;

  /// No description provided for @authVerificationBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the six-digit verification code we sent to your email address.'**
  String get authVerificationBody;

  /// No description provided for @authVerificationCodeSemantic.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get authVerificationCodeSemantic;

  /// No description provided for @authVerifyEmailAction.
  ///
  /// In en, this message translates to:
  /// **'VERIFY EMAIL'**
  String get authVerifyEmailAction;

  /// No description provided for @authResendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get authResendCode;

  /// No description provided for @authResendReady.
  ///
  /// In en, this message translates to:
  /// **'You can resend a code now.'**
  String get authResendReady;

  /// No description provided for @authResendCountdown.
  ///
  /// In en, this message translates to:
  /// **'Resend available in 00:{seconds}'**
  String authResendCountdown(String seconds);

  /// No description provided for @authChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get authChangeEmail;

  /// No description provided for @authCodeResent.
  ///
  /// In en, this message translates to:
  /// **'A new verification code was sent.'**
  String get authCodeResent;

  /// No description provided for @authVerificationError.
  ///
  /// In en, this message translates to:
  /// **'That code is not valid. Try again.'**
  String get authVerificationError;

  /// No description provided for @authProfileStep1.
  ///
  /// In en, this message translates to:
  /// **'Profile setup · Step 1 of 2'**
  String get authProfileStep1;

  /// No description provided for @authProfileStep2.
  ///
  /// In en, this message translates to:
  /// **'Profile setup · Step 2 of 2'**
  String get authProfileStep2;

  /// No description provided for @authUsernameHeading.
  ///
  /// In en, this message translates to:
  /// **'Create your Pokidoki username'**
  String get authUsernameHeading;

  /// No description provided for @authUsernameBody.
  ///
  /// In en, this message translates to:
  /// **'People can use your username to find you and send a contact request.'**
  String get authUsernameBody;

  /// No description provided for @authUsernameAvailable.
  ///
  /// In en, this message translates to:
  /// **'@{username} is available'**
  String authUsernameAvailable(String username);

  /// No description provided for @authUsernameUnavailable.
  ///
  /// In en, this message translates to:
  /// **'That username is not available.'**
  String get authUsernameUnavailable;

  /// No description provided for @authUsernameRequirements.
  ///
  /// In en, this message translates to:
  /// **'Username requirements'**
  String get authUsernameRequirements;

  /// No description provided for @authUsernameLength.
  ///
  /// In en, this message translates to:
  /// **'3 to 24 characters'**
  String get authUsernameLength;

  /// No description provided for @authUsernameCharset.
  ///
  /// In en, this message translates to:
  /// **'Lowercase letters, numbers, periods, and underscores'**
  String get authUsernameCharset;

  /// No description provided for @authUsernameStartsWithLetter.
  ///
  /// In en, this message translates to:
  /// **'Must begin with a letter'**
  String get authUsernameStartsWithLetter;

  /// No description provided for @authUsernameNoSpaces.
  ///
  /// In en, this message translates to:
  /// **'No spaces'**
  String get authUsernameNoSpaces;

  /// No description provided for @authUsernameUnique.
  ///
  /// In en, this message translates to:
  /// **'Must be unique'**
  String get authUsernameUnique;

  /// No description provided for @authCreateProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Create profile'**
  String get authCreateProfileTitle;

  /// No description provided for @authProfileHeading.
  ///
  /// In en, this message translates to:
  /// **'Make Pokidoki feel like yours'**
  String get authProfileHeading;

  /// No description provided for @authProfileBody.
  ///
  /// In en, this message translates to:
  /// **'Add the name and photo that trusted contacts will recognize.'**
  String get authProfileBody;

  /// No description provided for @authDisplayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get authDisplayNameLabel;

  /// No description provided for @authAboutYouLabel.
  ///
  /// In en, this message translates to:
  /// **'About you (optional)'**
  String get authAboutYouLabel;

  /// No description provided for @authSkipOptionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Skip optional details'**
  String get authSkipOptionalDetails;

  /// No description provided for @authChoosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose photo'**
  String get authChoosePhoto;

  /// No description provided for @authTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get authTakePhoto;

  /// No description provided for @authRemovePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get authRemovePhoto;

  /// No description provided for @authCreatePinTitle.
  ///
  /// In en, this message translates to:
  /// **'Create app PIN'**
  String get authCreatePinTitle;

  /// No description provided for @authCreatePinHeading.
  ///
  /// In en, this message translates to:
  /// **'Create an app PIN'**
  String get authCreatePinHeading;

  /// No description provided for @authCreatePinBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a six-digit PIN to protect access to Pokidoki on this device.'**
  String get authCreatePinBody;

  /// No description provided for @authPinDifferentFromPassword.
  ///
  /// In en, this message translates to:
  /// **'This PIN is different from your account password.'**
  String get authPinDifferentFromPassword;

  /// No description provided for @authPinLocalProtectionNote.
  ///
  /// In en, this message translates to:
  /// **'Your app PIN protects local access. It is not your message-encryption key.'**
  String get authPinLocalProtectionNote;

  /// No description provided for @authPinDigitsEntered.
  ///
  /// In en, this message translates to:
  /// **'{count} of 6 digits entered'**
  String authPinDigitsEntered(int count);

  /// No description provided for @authConfirmPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm app PIN'**
  String get authConfirmPinTitle;

  /// No description provided for @authConfirmPinHeading.
  ///
  /// In en, this message translates to:
  /// **'Confirm your app PIN'**
  String get authConfirmPinHeading;

  /// No description provided for @authConfirmPinBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the same six-digit PIN again to make sure you remember it.'**
  String get authConfirmPinBody;

  /// No description provided for @authConfirmPinAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get authConfirmPinAction;

  /// No description provided for @authChooseDifferentPin.
  ///
  /// In en, this message translates to:
  /// **'Choose a different PIN'**
  String get authChooseDifferentPin;

  /// No description provided for @authEnterAllSixDigits.
  ///
  /// In en, this message translates to:
  /// **'Enter all six digits to continue'**
  String get authEnterAllSixDigits;

  /// No description provided for @authPinMismatch.
  ///
  /// In en, this message translates to:
  /// **'The PINs do not match. Try again.'**
  String get authPinMismatch;

  /// No description provided for @authBiometricsHeading.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pokidoki more quickly'**
  String get authBiometricsHeading;

  /// No description provided for @authBiometricsBody.
  ///
  /// In en, this message translates to:
  /// **'Your app PIN will remain available as a fallback.'**
  String get authBiometricsBody;

  /// No description provided for @authBiometricsFasterTitle.
  ///
  /// In en, this message translates to:
  /// **'Faster access'**
  String get authBiometricsFasterTitle;

  /// No description provided for @authBiometricsFasterBody.
  ///
  /// In en, this message translates to:
  /// **'Open Pokidoki without typing your PIN each time.'**
  String get authBiometricsFasterBody;

  /// No description provided for @authBiometricsDeviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Protected by your device'**
  String get authBiometricsDeviceTitle;

  /// No description provided for @authBiometricsDeviceBody.
  ///
  /// In en, this message translates to:
  /// **'Authentication is handled by your phone\'s security system.'**
  String get authBiometricsDeviceBody;

  /// No description provided for @authBiometricsPinTitle.
  ///
  /// In en, this message translates to:
  /// **'PIN remains available'**
  String get authBiometricsPinTitle;

  /// No description provided for @authBiometricsPinBody.
  ///
  /// In en, this message translates to:
  /// **'You can still unlock Pokidoki with your six-digit app PIN.'**
  String get authBiometricsPinBody;

  /// No description provided for @authBiometricsPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Your biometric data is managed by your device and is not stored by Pokidoki.'**
  String get authBiometricsPrivacyNote;

  /// No description provided for @authEnableBiometricsAction.
  ///
  /// In en, this message translates to:
  /// **'Enable biometric unlock'**
  String get authEnableBiometricsAction;

  /// No description provided for @authNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get authNotNow;

  /// No description provided for @authAppLockHeading.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki is locked'**
  String get authAppLockHeading;

  /// No description provided for @authAppLockBody.
  ///
  /// In en, this message translates to:
  /// **'Enter your six-digit app PIN or use biometrics to access your conversations.'**
  String get authAppLockBody;

  /// No description provided for @authEnterAppPin.
  ///
  /// In en, this message translates to:
  /// **'Enter your app PIN'**
  String get authEnterAppPin;

  /// No description provided for @authAppLockError.
  ///
  /// In en, this message translates to:
  /// **'That PIN is incorrect. Try again.'**
  String get authAppLockError;

  /// No description provided for @authForgotPin.
  ///
  /// In en, this message translates to:
  /// **'Forgot your app PIN?'**
  String get authForgotPin;

  /// No description provided for @authUseBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Use biometrics'**
  String get authUseBiometrics;

  /// No description provided for @authDeleteDigit.
  ///
  /// In en, this message translates to:
  /// **'Delete digit'**
  String get authDeleteDigit;

  /// No description provided for @authBiometricsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock is not enabled for this session.'**
  String get authBiometricsUnavailable;

  /// Generic loading state label
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get stateLoading;

  /// Generic empty state label
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get stateEmpty;

  /// Generic recoverable error label
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get stateError;

  /// Generic offline banner label
  ///
  /// In en, this message translates to:
  /// **'You appear to be offline'**
  String get stateOffline;

  /// Primary tab label for conversations
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get navChats;

  /// Primary tab label for contacts
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get navContacts;

  /// Primary tab label for settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Accessibility label for verified badge
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get semanticVerified;

  /// Accessibility label for close actions
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get semanticClose;

  /// Accessibility label for back navigation
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get semanticBack;

  /// Accessibility label for search fields
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get semanticSearch;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsAccountProtected.
  ///
  /// In en, this message translates to:
  /// **'Account protected'**
  String get settingsAccountProtected;

  /// No description provided for @settingsPrivacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get settingsPrivacySecurity;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @settingsAppLock.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get settingsAppLock;

  /// No description provided for @settingsAppLockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'PIN and biometrics'**
  String get settingsAppLockSubtitle;

  /// No description provided for @settingsBiometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock'**
  String get settingsBiometricUnlock;

  /// No description provided for @settingsAutomaticallyLock.
  ///
  /// In en, this message translates to:
  /// **'Automatically lock'**
  String get settingsAutomaticallyLock;

  /// No description provided for @settingsScreenPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Screen privacy'**
  String get settingsScreenPrivacy;

  /// No description provided for @settingsScreenPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hide content in app switcher'**
  String get settingsScreenPrivacySubtitle;

  /// No description provided for @settingsReadReceipts.
  ///
  /// In en, this message translates to:
  /// **'Read receipts'**
  String get settingsReadReceipts;

  /// No description provided for @settingsTypingIndicators.
  ///
  /// In en, this message translates to:
  /// **'Typing indicators'**
  String get settingsTypingIndicators;

  /// No description provided for @settingsBlockedUsers.
  ///
  /// In en, this message translates to:
  /// **'Blocked users'**
  String get settingsBlockedUsers;

  /// No description provided for @settingsLinkedDevices.
  ///
  /// In en, this message translates to:
  /// **'Linked devices'**
  String get settingsLinkedDevices;

  /// No description provided for @settingsActiveDevices.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String settingsActiveDevices(int count);

  /// No description provided for @settingsSecurityActivity.
  ///
  /// In en, this message translates to:
  /// **'Security activity'**
  String get settingsSecurityActivity;

  /// No description provided for @settingsSecurityActivitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review important changes'**
  String get settingsSecurityActivitySubtitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsStorageUsage.
  ///
  /// In en, this message translates to:
  /// **'Storage usage'**
  String get settingsStorageUsage;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsMessageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Message notifications'**
  String get settingsMessageNotifications;

  /// No description provided for @settingsNotificationPreviews.
  ///
  /// In en, this message translates to:
  /// **'Notification previews'**
  String get settingsNotificationPreviews;

  /// No description provided for @settingsNotificationPreviewsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show message text'**
  String get settingsNotificationPreviewsSubtitle;

  /// No description provided for @settingsNotificationSound.
  ///
  /// In en, this message translates to:
  /// **'Notification sound'**
  String get settingsNotificationSound;

  /// No description provided for @settingsNotificationSoundDefault.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki Default'**
  String get settingsNotificationSoundDefault;

  /// No description provided for @settingsVibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsVibration;

  /// No description provided for @settingsHelpInformation.
  ///
  /// In en, this message translates to:
  /// **'Help & Information'**
  String get settingsHelpInformation;

  /// No description provided for @settingsHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get settingsHelpCenter;

  /// No description provided for @settingsHelpPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Help content will be available in a later release.'**
  String get settingsHelpPlaceholder;

  /// No description provided for @settingsPokidokiVersion.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki version'**
  String get settingsPokidokiVersion;

  /// No description provided for @settingsSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of Pokidoki?'**
  String get settingsSignOutTitle;

  /// No description provided for @settingsSignOutBody.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access this account.'**
  String get settingsSignOutBody;

  /// No description provided for @settingsSignOutAction.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get settingsSignOutAction;

  /// No description provided for @settingsPublicIdentity.
  ///
  /// In en, this message translates to:
  /// **'Public identity'**
  String get settingsPublicIdentity;

  /// No description provided for @settingsDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get settingsDisplayName;

  /// No description provided for @settingsUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get settingsUsername;

  /// No description provided for @settingsPokidokiId.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki ID'**
  String get settingsPokidokiId;

  /// No description provided for @settingsCopyId.
  ///
  /// In en, this message translates to:
  /// **'Copy Pokidoki ID'**
  String get settingsCopyId;

  /// No description provided for @settingsIdCopied.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki ID copied.'**
  String get settingsIdCopied;

  /// No description provided for @settingsSharePublicIdentity.
  ///
  /// In en, this message translates to:
  /// **'Share your public Pokidoki identity'**
  String get settingsSharePublicIdentity;

  /// No description provided for @settingsPreviewPublicProfile.
  ///
  /// In en, this message translates to:
  /// **'Preview public profile'**
  String get settingsPreviewPublicProfile;

  /// No description provided for @settingsPreviewPublicProfileBody.
  ///
  /// In en, this message translates to:
  /// **'See what other Pokidoki users can view'**
  String get settingsPreviewPublicProfileBody;

  /// No description provided for @settingsSignInRecovery.
  ///
  /// In en, this message translates to:
  /// **'Sign-in and recovery'**
  String get settingsSignInRecovery;

  /// No description provided for @settingsEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get settingsEmailAddress;

  /// No description provided for @settingsVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get settingsVerified;

  /// No description provided for @settingsPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get settingsPassword;

  /// No description provided for @settingsPasswordChangedAgo.
  ///
  /// In en, this message translates to:
  /// **'Changed 3 months ago'**
  String get settingsPasswordChangedAgo;

  /// No description provided for @settingsAccountRecovery.
  ///
  /// In en, this message translates to:
  /// **'Account recovery'**
  String get settingsAccountRecovery;

  /// No description provided for @settingsAccountRecoverySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review recovery and verification options'**
  String get settingsAccountRecoverySubtitle;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Delete Account is not available in this UI batch.'**
  String get settingsDeleteAccountUnavailable;

  /// No description provided for @settingsLinkedDevicesInfo.
  ///
  /// In en, this message translates to:
  /// **'Review this list regularly and remove any device you do not recognize.'**
  String get settingsLinkedDevicesInfo;

  /// No description provided for @settingsLinkedDevicesError.
  ///
  /// In en, this message translates to:
  /// **'We could not load linked devices.'**
  String get settingsLinkedDevicesError;

  /// No description provided for @settingsDeviceLinkedRecently.
  ///
  /// In en, this message translates to:
  /// **'A device was linked recently'**
  String get settingsDeviceLinkedRecently;

  /// No description provided for @settingsDeviceLinkedRecentlyBody.
  ///
  /// In en, this message translates to:
  /// **'Review the device below and remove it if you do not recognize it.'**
  String get settingsDeviceLinkedRecentlyBody;

  /// No description provided for @settingsThisDevice.
  ///
  /// In en, this message translates to:
  /// **'This device'**
  String get settingsThisDevice;

  /// No description provided for @settingsOtherDevices.
  ///
  /// In en, this message translates to:
  /// **'Other devices'**
  String get settingsOtherDevices;

  /// No description provided for @settingsCurrentDevice.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get settingsCurrentDevice;

  /// No description provided for @settingsNeedsReview.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get settingsNeedsReview;

  /// No description provided for @settingsActiveNow.
  ///
  /// In en, this message translates to:
  /// **'Active now'**
  String get settingsActiveNow;

  /// No description provided for @settingsLastActiveRecently.
  ///
  /// In en, this message translates to:
  /// **'Last active recently'**
  String get settingsLastActiveRecently;

  /// No description provided for @settingsNoOtherDevices.
  ///
  /// In en, this message translates to:
  /// **'No other linked devices'**
  String get settingsNoOtherDevices;

  /// No description provided for @settingsNoOtherDevicesBody.
  ///
  /// In en, this message translates to:
  /// **'Only this phone is currently linked to your account.'**
  String get settingsNoOtherDevicesBody;

  /// No description provided for @settingsRemoveDeviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String settingsRemoveDeviceTitle(String name);

  /// No description provided for @settingsRemoveDeviceBody.
  ///
  /// In en, this message translates to:
  /// **'This device will need to sign in again.'**
  String get settingsRemoveDeviceBody;

  /// No description provided for @settingsRemoveDeviceAction.
  ///
  /// In en, this message translates to:
  /// **'Remove device'**
  String get settingsRemoveDeviceAction;

  /// No description provided for @settingsDeviceRemoved.
  ///
  /// In en, this message translates to:
  /// **'Device removed.'**
  String get settingsDeviceRemoved;

  /// No description provided for @settingsSecurityActivityError.
  ///
  /// In en, this message translates to:
  /// **'We could not load security activity.'**
  String get settingsSecurityActivityError;

  /// No description provided for @settingsSecurityHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your account security history'**
  String get settingsSecurityHistoryTitle;

  /// No description provided for @settingsSecurityHistoryBody.
  ///
  /// In en, this message translates to:
  /// **'Review recent security events like new sign-ins, password changes, and device additions.'**
  String get settingsSecurityHistoryBody;

  /// No description provided for @settingsEventsNeedReview.
  ///
  /// In en, this message translates to:
  /// **'{count} event needs your review'**
  String settingsEventsNeedReview(int count);

  /// No description provided for @settingsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get settingsFilterAll;

  /// No description provided for @settingsFilterDevices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get settingsFilterDevices;

  /// No description provided for @settingsFilterIdentity.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get settingsFilterIdentity;

  /// No description provided for @settingsFilterSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign-in'**
  String get settingsFilterSignIn;

  /// No description provided for @settingsNoSecurityEvents.
  ///
  /// In en, this message translates to:
  /// **'No security events to show.'**
  String get settingsNoSecurityEvents;

  /// No description provided for @settingsReviewLinkedDevices.
  ///
  /// In en, this message translates to:
  /// **'Review linked devices'**
  String get settingsReviewLinkedDevices;

  /// No description provided for @settingsReviewLinkedDevicesHint.
  ///
  /// In en, this message translates to:
  /// **'If you do not recognize this device, review your linked devices.'**
  String get settingsReviewLinkedDevicesHint;

  /// No description provided for @settingsBlockedUsersInfo.
  ///
  /// In en, this message translates to:
  /// **'Blocked accounts cannot contact you'**
  String get settingsBlockedUsersInfo;

  /// No description provided for @settingsBlockedUsersError.
  ///
  /// In en, this message translates to:
  /// **'We could not load blocked users.'**
  String get settingsBlockedUsersError;

  /// No description provided for @settingsBlockedUsersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} blocked users'**
  String settingsBlockedUsersCount(int count);

  /// No description provided for @settingsNoBlockedUsers.
  ///
  /// In en, this message translates to:
  /// **'No blocked users'**
  String get settingsNoBlockedUsers;

  /// No description provided for @settingsNoBlockedUsersBody.
  ///
  /// In en, this message translates to:
  /// **'People you block will appear here.'**
  String get settingsNoBlockedUsersBody;

  /// No description provided for @settingsUnblockTitle.
  ///
  /// In en, this message translates to:
  /// **'Unblock {name}?'**
  String settingsUnblockTitle(String name);

  /// No description provided for @settingsUnblockBody.
  ///
  /// In en, this message translates to:
  /// **'{name} may be able to send you messages or contact requests again.'**
  String settingsUnblockBody(String name);

  /// No description provided for @settingsUnblockAction.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get settingsUnblockAction;

  /// No description provided for @settingsUnblockedSnack.
  ///
  /// In en, this message translates to:
  /// **'{name} was unblocked.'**
  String settingsUnblockedSnack(String name);

  /// No description provided for @settingsProtected.
  ///
  /// In en, this message translates to:
  /// **'Protected'**
  String get settingsProtected;

  /// No description provided for @settingsUseAppLock.
  ///
  /// In en, this message translates to:
  /// **'Use App Lock'**
  String get settingsUseAppLock;

  /// No description provided for @settingsTurnOffAppLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn off App Lock?'**
  String get settingsTurnOffAppLockTitle;

  /// No description provided for @settingsTurnOffAppLockBody.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki will no longer require your app PIN when opening the app.'**
  String get settingsTurnOffAppLockBody;

  /// No description provided for @settingsTurnOffAppLockAction.
  ///
  /// In en, this message translates to:
  /// **'Turn off'**
  String get settingsTurnOffAppLockAction;

  /// No description provided for @settingsUnlockMethods.
  ///
  /// In en, this message translates to:
  /// **'Unlock Methods'**
  String get settingsUnlockMethods;

  /// No description provided for @settingsChangeAppPin.
  ///
  /// In en, this message translates to:
  /// **'Change app PIN'**
  String get settingsChangeAppPin;

  /// No description provided for @settingsPinLength.
  ///
  /// In en, this message translates to:
  /// **'PIN length'**
  String get settingsPinLength;

  /// No description provided for @settingsPinLengthValue.
  ///
  /// In en, this message translates to:
  /// **'6 digits'**
  String get settingsPinLengthValue;

  /// No description provided for @settingsAutomaticLocking.
  ///
  /// In en, this message translates to:
  /// **'Automatic Locking'**
  String get settingsAutomaticLocking;

  /// No description provided for @settingsLockImmediately.
  ///
  /// In en, this message translates to:
  /// **'Immediately'**
  String get settingsLockImmediately;

  /// No description provided for @settingsLockAfter1Minute.
  ///
  /// In en, this message translates to:
  /// **'After 1 minute'**
  String get settingsLockAfter1Minute;

  /// No description provided for @settingsLockAfter5Minutes.
  ///
  /// In en, this message translates to:
  /// **'After 5 minutes'**
  String get settingsLockAfter5Minutes;

  /// No description provided for @settingsLockAfter30Minutes.
  ///
  /// In en, this message translates to:
  /// **'After 30 minutes'**
  String get settingsLockAfter30Minutes;

  /// No description provided for @settingsLockAfterRestart.
  ///
  /// In en, this message translates to:
  /// **'Require PIN after device restart'**
  String get settingsLockAfterRestart;

  /// No description provided for @settingsAlwaysRequired.
  ///
  /// In en, this message translates to:
  /// **'Always required'**
  String get settingsAlwaysRequired;

  /// No description provided for @settingsPrivacyWhileLocked.
  ///
  /// In en, this message translates to:
  /// **'Privacy While Locked'**
  String get settingsPrivacyWhileLocked;

  /// No description provided for @settingsHideContentInAppSwitcher.
  ///
  /// In en, this message translates to:
  /// **'Hide content in app switcher'**
  String get settingsHideContentInAppSwitcher;

  /// No description provided for @settingsPinNotPassword.
  ///
  /// In en, this message translates to:
  /// **'The app PIN is not your account password'**
  String get settingsPinNotPassword;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'Use device setting'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeSystemBody.
  ///
  /// In en, this message translates to:
  /// **'Matches system theme automatically'**
  String get settingsThemeSystemBody;

  /// No description provided for @settingsDarkActive.
  ///
  /// In en, this message translates to:
  /// **'Dark appearance is active'**
  String get settingsDarkActive;

  /// No description provided for @settingsDarkActiveBody.
  ///
  /// In en, this message translates to:
  /// **'Saves battery and reduces eye strain in low light.'**
  String get settingsDarkActiveBody;

  /// No description provided for @settingsLightActive.
  ///
  /// In en, this message translates to:
  /// **'Light appearance is active'**
  String get settingsLightActive;

  /// No description provided for @settingsLightActiveBody.
  ///
  /// In en, this message translates to:
  /// **'Uses a brighter surface palette for daytime use.'**
  String get settingsLightActiveBody;

  /// No description provided for @settingsSystemActive.
  ///
  /// In en, this message translates to:
  /// **'System appearance is active'**
  String get settingsSystemActive;

  /// No description provided for @settingsAppearanceSecurityNote.
  ///
  /// In en, this message translates to:
  /// **'Appearance does not change your security'**
  String get settingsAppearanceSecurityNote;

  /// No description provided for @settingsLanguageActive.
  ///
  /// In en, this message translates to:
  /// **'{name} is active'**
  String settingsLanguageActive(String name);

  /// No description provided for @settingsLanguageActiveBody.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki menus, settings, and system messages are displayed in {name}.'**
  String settingsLanguageActiveBody(String name);

  /// No description provided for @settingsAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get settingsAppLanguage;

  /// No description provided for @settingsLeftToRight.
  ///
  /// In en, this message translates to:
  /// **'Left to right'**
  String get settingsLeftToRight;

  /// No description provided for @settingsRightToLeft.
  ///
  /// In en, this message translates to:
  /// **'Right to left'**
  String get settingsRightToLeft;

  /// No description provided for @settingsLanguageMessagesNote.
  ///
  /// In en, this message translates to:
  /// **'Changing language does not translate messages'**
  String get settingsLanguageMessagesNote;

  /// No description provided for @settingsStorageError.
  ///
  /// In en, this message translates to:
  /// **'We could not calculate storage usage.'**
  String get settingsStorageError;

  /// No description provided for @settingsStorageUsedOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Used by Pokidoki on this device'**
  String get settingsStorageUsedOnDevice;

  /// No description provided for @settingsStorageSummarySemantic.
  ///
  /// In en, this message translates to:
  /// **'Total storage used: {total}'**
  String settingsStorageSummarySemantic(String total);

  /// No description provided for @settingsCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get settingsCategories;

  /// No description provided for @settingsStorageMedia.
  ///
  /// In en, this message translates to:
  /// **'Photos and videos'**
  String get settingsStorageMedia;

  /// No description provided for @settingsStorageFiles.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get settingsStorageFiles;

  /// No description provided for @settingsStorageVoice.
  ///
  /// In en, this message translates to:
  /// **'Voice messages'**
  String get settingsStorageVoice;

  /// No description provided for @settingsStorageCache.
  ///
  /// In en, this message translates to:
  /// **'Cache'**
  String get settingsStorageCache;

  /// No description provided for @settingsStorageOther.
  ///
  /// In en, this message translates to:
  /// **'Other local data'**
  String get settingsStorageOther;

  /// No description provided for @settingsClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get settingsClear;

  /// No description provided for @settingsClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get settingsClearCache;

  /// No description provided for @settingsClearCacheSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Safely remove temp data'**
  String get settingsClearCacheSubtitle;

  /// No description provided for @settingsClearCacheTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear cached files?'**
  String get settingsClearCacheTitle;

  /// No description provided for @settingsClearCacheBody.
  ///
  /// In en, this message translates to:
  /// **'Downloaded media can be retrieved again when needed.'**
  String get settingsClearCacheBody;

  /// No description provided for @settingsClearCacheAction.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get settingsClearCacheAction;

  /// No description provided for @settingsCacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared.'**
  String get settingsCacheCleared;

  /// No description provided for @accountChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get accountChangePassword;

  /// No description provided for @accountProtectAccount.
  ///
  /// In en, this message translates to:
  /// **'Protect your Pokidoki account'**
  String get accountProtectAccount;

  /// No description provided for @accountCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get accountCurrentPassword;

  /// No description provided for @accountForgotCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot current password?'**
  String get accountForgotCurrentPassword;

  /// No description provided for @accountNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get accountNewPassword;

  /// No description provided for @accountConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get accountConfirmNewPassword;

  /// No description provided for @accountPasswordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Requirements:'**
  String get accountPasswordRequirements;

  /// No description provided for @accountPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'At least 12 characters'**
  String get accountPasswordMinLength;

  /// No description provided for @accountPasswordUpperLower.
  ///
  /// In en, this message translates to:
  /// **'Upper and lowercase letters'**
  String get accountPasswordUpperLower;

  /// No description provided for @accountPasswordNumber.
  ///
  /// In en, this message translates to:
  /// **'At least one number'**
  String get accountPasswordNumber;

  /// No description provided for @accountPasswordSymbol.
  ///
  /// In en, this message translates to:
  /// **'At least one symbol (!@#\$%^&*)'**
  String get accountPasswordSymbol;

  /// No description provided for @accountPasswordDifferent.
  ///
  /// In en, this message translates to:
  /// **'Different from current password'**
  String get accountPasswordDifferent;

  /// No description provided for @accountPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get accountPasswordMismatch;

  /// No description provided for @accountSignOutOtherDevices.
  ///
  /// In en, this message translates to:
  /// **'Sign out other devices'**
  String get accountSignOutOtherDevices;

  /// No description provided for @accountSignOutOtherDevicesRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended for security'**
  String get accountSignOutOtherDevicesRecommended;

  /// No description provided for @accountPasswordPinDifferent.
  ///
  /// In en, this message translates to:
  /// **'Your password and app PIN are different'**
  String get accountPasswordPinDifferent;

  /// No description provided for @accountUpdatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get accountUpdatePassword;

  /// No description provided for @accountPasswordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated.'**
  String get accountPasswordUpdated;

  /// No description provided for @accountPasswordUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'We could not update your password. Check your current password and try again.'**
  String get accountPasswordUpdateFailed;

  /// No description provided for @accountSecurityGenericError.
  ///
  /// In en, this message translates to:
  /// **'We could not complete this action. Your account remains unchanged.'**
  String get accountSecurityGenericError;

  /// No description provided for @accountShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get accountShowPassword;

  /// No description provided for @accountHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get accountHidePassword;

  /// No description provided for @accountEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountEmailTitle;

  /// No description provided for @accountEmailVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your email is verified'**
  String get accountEmailVerifiedTitle;

  /// No description provided for @accountEmailRecoveryHelp.
  ///
  /// In en, this message translates to:
  /// **'This email can be used for account recovery and important security alerts.'**
  String get accountEmailRecoveryHelp;

  /// No description provided for @accountVerifiedOn.
  ///
  /// In en, this message translates to:
  /// **'Verified on {date}'**
  String accountVerifiedOn(String date);

  /// No description provided for @accountEmailSection.
  ///
  /// In en, this message translates to:
  /// **'Account email'**
  String get accountEmailSection;

  /// No description provided for @accountLastVerified.
  ///
  /// In en, this message translates to:
  /// **'Last verified'**
  String get accountLastVerified;

  /// No description provided for @accountRecoveryAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get accountRecoveryAvailable;

  /// No description provided for @accountChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email address'**
  String get accountChangeEmail;

  /// No description provided for @accountChangeEmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Replace the verified email associated with this account'**
  String get accountChangeEmailSubtitle;

  /// No description provided for @accountSecurityEmails.
  ///
  /// In en, this message translates to:
  /// **'Security emails'**
  String get accountSecurityEmails;

  /// No description provided for @accountSecurityAlerts.
  ///
  /// In en, this message translates to:
  /// **'Security alerts'**
  String get accountSecurityAlerts;

  /// No description provided for @accountSecurityAlertsBody.
  ///
  /// In en, this message translates to:
  /// **'Receive important account and device security notifications.'**
  String get accountSecurityAlertsBody;

  /// No description provided for @accountAlwaysOn.
  ///
  /// In en, this message translates to:
  /// **'Always on'**
  String get accountAlwaysOn;

  /// No description provided for @accountNewDeviceAlerts.
  ///
  /// In en, this message translates to:
  /// **'New device alerts'**
  String get accountNewDeviceAlerts;

  /// No description provided for @accountNewDeviceAlertsBody.
  ///
  /// In en, this message translates to:
  /// **'Receive an email when a new device is linked or signs in.'**
  String get accountNewDeviceAlertsBody;

  /// No description provided for @accountRecoveryAlerts.
  ///
  /// In en, this message translates to:
  /// **'Recovery alerts'**
  String get accountRecoveryAlerts;

  /// No description provided for @accountRecoveryAlertsBody.
  ///
  /// In en, this message translates to:
  /// **'Receive an email when account recovery is started.'**
  String get accountRecoveryAlertsBody;

  /// No description provided for @accountOptionalCommunications.
  ///
  /// In en, this message translates to:
  /// **'Optional communications'**
  String get accountOptionalCommunications;

  /// No description provided for @accountProductUpdates.
  ///
  /// In en, this message translates to:
  /// **'Product news and tips'**
  String get accountProductUpdates;

  /// No description provided for @accountResearchInvitations.
  ///
  /// In en, this message translates to:
  /// **'Research invitations'**
  String get accountResearchInvitations;

  /// No description provided for @accountEmailNotPublic.
  ///
  /// In en, this message translates to:
  /// **'Your verified email helps recover your account and is not shown to contacts.'**
  String get accountEmailNotPublic;

  /// No description provided for @accountReauthenticateTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get accountReauthenticateTitle;

  /// No description provided for @accountReauthenticateBody.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password to continue changing your email.'**
  String get accountReauthenticateBody;

  /// No description provided for @accountEnterNewEmailBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the new email address for this account.'**
  String get accountEnterNewEmailBody;

  /// No description provided for @accountEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get accountEmailInvalid;

  /// No description provided for @accountEmailConflict.
  ///
  /// In en, this message translates to:
  /// **'This email cannot be used for this account.'**
  String get accountEmailConflict;

  /// No description provided for @accountVerifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get accountVerifyEmailTitle;

  /// No description provided for @accountVerifyEmailBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the six-digit code sent to {email}.'**
  String accountVerifyEmailBody(String email);

  /// No description provided for @accountVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get accountVerificationCode;

  /// No description provided for @accountVerifyAction.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get accountVerifyAction;

  /// No description provided for @accountCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The verification code is incorrect or has expired.'**
  String get accountCodeInvalid;

  /// No description provided for @accountEmailUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your email address was updated.'**
  String get accountEmailUpdated;

  /// No description provided for @accountRecoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Recovery'**
  String get accountRecoveryTitle;

  /// No description provided for @accountRecoveryAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Account recovery is available'**
  String get accountRecoveryAvailableTitle;

  /// No description provided for @accountRecoveryMethod.
  ///
  /// In en, this message translates to:
  /// **'Recovery method'**
  String get accountRecoveryMethod;

  /// No description provided for @accountVerifiedEmail.
  ///
  /// In en, this message translates to:
  /// **'Verified email'**
  String get accountVerifiedEmail;

  /// No description provided for @accountThisPhone.
  ///
  /// In en, this message translates to:
  /// **'This phone'**
  String get accountThisPhone;

  /// No description provided for @accountRecognized.
  ///
  /// In en, this message translates to:
  /// **'Recognized'**
  String get accountRecognized;

  /// No description provided for @accountWhatHappensNext.
  ///
  /// In en, this message translates to:
  /// **'What happens next'**
  String get accountWhatHappensNext;

  /// No description provided for @accountRecoveryStep1.
  ///
  /// In en, this message translates to:
  /// **'Receive a verification code'**
  String get accountRecoveryStep1;

  /// No description provided for @accountRecoveryStep1Body.
  ///
  /// In en, this message translates to:
  /// **'Sent to your verified email address.'**
  String get accountRecoveryStep1Body;

  /// No description provided for @accountRecoveryStep2.
  ///
  /// In en, this message translates to:
  /// **'Confirm this device'**
  String get accountRecoveryStep2;

  /// No description provided for @accountRecoveryStep2Body.
  ///
  /// In en, this message translates to:
  /// **'Verify that you are using a recognized device.'**
  String get accountRecoveryStep2Body;

  /// No description provided for @accountRecoveryStep3.
  ///
  /// In en, this message translates to:
  /// **'Create a new password'**
  String get accountRecoveryStep3;

  /// No description provided for @accountRecoveryStep3Body.
  ///
  /// In en, this message translates to:
  /// **'Choose a strong account password.'**
  String get accountRecoveryStep3Body;

  /// No description provided for @accountRecoveryStep4.
  ///
  /// In en, this message translates to:
  /// **'Review account security'**
  String get accountRecoveryStep4;

  /// No description provided for @accountRecoveryStep4Body.
  ///
  /// In en, this message translates to:
  /// **'Review linked devices and recent activity.'**
  String get accountRecoveryStep4Body;

  /// No description provided for @accountLocalDataWarning.
  ///
  /// In en, this message translates to:
  /// **'Some protected local data may be unavailable. Recovery confirms account ownership and does not create a backdoor into encrypted conversations.'**
  String get accountLocalDataWarning;

  /// No description provided for @accountStartRecoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Start account recovery?'**
  String get accountStartRecoveryTitle;

  /// No description provided for @accountStartRecoveryBody.
  ///
  /// In en, this message translates to:
  /// **'A verification code will be sent to {email}.'**
  String accountStartRecoveryBody(String email);

  /// No description provided for @accountStartRecoveryAction.
  ///
  /// In en, this message translates to:
  /// **'Start Recovery'**
  String get accountStartRecoveryAction;

  /// No description provided for @accountCancelRecovery.
  ///
  /// In en, this message translates to:
  /// **'Cancel Recovery'**
  String get accountCancelRecovery;

  /// No description provided for @accountCannotAccessEmail.
  ///
  /// In en, this message translates to:
  /// **'I cannot access this email'**
  String get accountCannotAccessEmail;

  /// No description provided for @accountSupportNeverasks.
  ///
  /// In en, this message translates to:
  /// **'Support will never ask for your password, app PIN, or verification code.'**
  String get accountSupportNeverasks;

  /// No description provided for @accountRecoveryCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The verification code is incorrect or has expired.'**
  String get accountRecoveryCodeInvalid;

  /// No description provided for @accountCreateNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create a new password'**
  String get accountCreateNewPassword;

  /// No description provided for @accountRestoreAccess.
  ///
  /// In en, this message translates to:
  /// **'Restore access'**
  String get accountRestoreAccess;

  /// No description provided for @accountRecoveryCompleted.
  ///
  /// In en, this message translates to:
  /// **'Account access restored.'**
  String get accountRecoveryCompleted;

  /// No description provided for @accountRecoveryCompletedBody.
  ///
  /// In en, this message translates to:
  /// **'You can continue using Pokidoki with your new password. Your app PIN was not changed.'**
  String get accountRecoveryCompletedBody;

  /// No description provided for @reportUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Report user'**
  String get reportUserTitle;

  /// No description provided for @reportBlockedBadge.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get reportBlockedBadge;

  /// No description provided for @reportHelpReview.
  ///
  /// In en, this message translates to:
  /// **'Reports help Pokidoki review possible abuse'**
  String get reportHelpReview;

  /// No description provided for @reportWhyTitle.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this account?'**
  String get reportWhyTitle;

  /// No description provided for @reportReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get reportReasonSpam;

  /// No description provided for @reportReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get reportReasonHarassment;

  /// No description provided for @reportReasonImpersonation.
  ///
  /// In en, this message translates to:
  /// **'Impersonation'**
  String get reportReasonImpersonation;

  /// No description provided for @reportReasonThreats.
  ///
  /// In en, this message translates to:
  /// **'Threats or violence'**
  String get reportReasonThreats;

  /// No description provided for @reportReasonInappropriate.
  ///
  /// In en, this message translates to:
  /// **'Sexual or inappropriate content'**
  String get reportReasonInappropriate;

  /// No description provided for @reportReasonScam.
  ///
  /// In en, this message translates to:
  /// **'Scam or fraud'**
  String get reportReasonScam;

  /// No description provided for @reportReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reportReasonOther;

  /// No description provided for @reportAdditionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Additional details (Optional)'**
  String get reportAdditionalDetails;

  /// No description provided for @reportDetailsHelper.
  ///
  /// In en, this message translates to:
  /// **'Do not enter passwords, PINs, verification codes, or private keys.'**
  String get reportDetailsHelper;

  /// No description provided for @reportEvidence.
  ///
  /// In en, this message translates to:
  /// **'Evidence'**
  String get reportEvidence;

  /// No description provided for @reportIncludeEvidence.
  ///
  /// In en, this message translates to:
  /// **'Include selected conversation evidence'**
  String get reportIncludeEvidence;

  /// No description provided for @reportEvidenceDefaultOff.
  ///
  /// In en, this message translates to:
  /// **'Nothing is included by default. Select messages from the chat to include them as evidence.'**
  String get reportEvidenceDefaultOff;

  /// No description provided for @reportSelectedEvidenceCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String reportSelectedEvidenceCount(int count);

  /// No description provided for @reportSelectEvidence.
  ///
  /// In en, this message translates to:
  /// **'Select evidence'**
  String get reportSelectEvidence;

  /// No description provided for @reportNotBlocking.
  ///
  /// In en, this message translates to:
  /// **'Reporting is not blocking. Reporting sends information for review. Blocking prevents new contact requests or messages.'**
  String get reportNotBlocking;

  /// No description provided for @reportWhatWillBeSent.
  ///
  /// In en, this message translates to:
  /// **'What will be sent'**
  String get reportWhatWillBeSent;

  /// No description provided for @reportAccountIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Account identifier'**
  String get reportAccountIdentifier;

  /// No description provided for @reportReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reportReasonLabel;

  /// No description provided for @reportDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get reportDetailsLabel;

  /// No description provided for @reportNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get reportNotSelected;

  /// No description provided for @reportNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get reportNone;

  /// No description provided for @reportDetailsIncluded.
  ///
  /// In en, this message translates to:
  /// **'Included'**
  String get reportDetailsIncluded;

  /// No description provided for @reportNotIncluded.
  ///
  /// In en, this message translates to:
  /// **'Not included'**
  String get reportNotIncluded;

  /// No description provided for @reportReviewData.
  ///
  /// In en, this message translates to:
  /// **'Review report data'**
  String get reportReviewData;

  /// No description provided for @reportSubmitTitle.
  ///
  /// In en, this message translates to:
  /// **'Submit this report?'**
  String get reportSubmitTitle;

  /// No description provided for @reportSubmitBody.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki will receive the selected reason, your optional details, and only the evidence you reviewed.'**
  String get reportSubmitBody;

  /// No description provided for @reportRemainsBlocked.
  ///
  /// In en, this message translates to:
  /// **'{name} will remain blocked.'**
  String reportRemainsBlocked(String name);

  /// No description provided for @reportSubmitAction.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get reportSubmitAction;

  /// No description provided for @reportSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted.'**
  String get reportSubmitted;

  /// No description provided for @reportSubmitFailed.
  ///
  /// In en, this message translates to:
  /// **'Your report has not been sent.'**
  String get reportSubmitFailed;

  /// No description provided for @reportNotEmergency.
  ///
  /// In en, this message translates to:
  /// **'Pokidoki reports are not an emergency service.'**
  String get reportNotEmergency;

  /// No description provided for @contactsSelfNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'You cannot send a contact request to yourself.'**
  String get contactsSelfNotAllowed;

  /// No description provided for @contactsAlreadyPending.
  ///
  /// In en, this message translates to:
  /// **'A contact request is already pending.'**
  String get contactsAlreadyPending;

  /// No description provided for @contactsReversePending.
  ///
  /// In en, this message translates to:
  /// **'This person already sent you a request. Accept it from Contact requests.'**
  String get contactsReversePending;

  /// No description provided for @contactsRequestNotFound.
  ///
  /// In en, this message translates to:
  /// **'This contact request is no longer available.'**
  String get contactsRequestNotFound;

  /// No description provided for @contactsRequestNotPending.
  ///
  /// In en, this message translates to:
  /// **'This contact request is no longer pending.'**
  String get contactsRequestNotPending;

  /// No description provided for @contactsRequestForbidden.
  ///
  /// In en, this message translates to:
  /// **'You cannot perform this action on this request.'**
  String get contactsRequestForbidden;

  /// No description provided for @contactsAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'You are already connected with this person.'**
  String get contactsAlreadyExists;

  /// No description provided for @contactsNotFound.
  ///
  /// In en, this message translates to:
  /// **'This contact is no longer available.'**
  String get contactsNotFound;

  /// No description provided for @contactsUserUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This user is not available.'**
  String get contactsUserUnavailable;

  /// No description provided for @contactsAlreadyBlocked.
  ///
  /// In en, this message translates to:
  /// **'This user is already blocked.'**
  String get contactsAlreadyBlocked;

  /// No description provided for @contactsNotBlocked.
  ///
  /// In en, this message translates to:
  /// **'This user is not blocked.'**
  String get contactsNotBlocked;

  /// No description provided for @contactsRelationshipUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Relationship information is unavailable.'**
  String get contactsRelationshipUnavailable;

  /// No description provided for @messagingUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Messaging is temporarily unavailable. Try again.'**
  String get messagingUnavailable;

  /// No description provided for @conversationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This conversation is unavailable.'**
  String get conversationUnavailable;

  /// No description provided for @conversationContactRequired.
  ///
  /// In en, this message translates to:
  /// **'You can only message people in your contacts.'**
  String get conversationContactRequired;

  /// No description provided for @cannotMessageUser.
  ///
  /// In en, this message translates to:
  /// **'You cannot message this user.'**
  String get cannotMessageUser;

  /// No description provided for @messageInvalid.
  ///
  /// In en, this message translates to:
  /// **'This message could not be sent.'**
  String get messageInvalid;

  /// No description provided for @messageTooLong.
  ///
  /// In en, this message translates to:
  /// **'This message is too long.'**
  String get messageTooLong;

  /// No description provided for @messageFailed.
  ///
  /// In en, this message translates to:
  /// **'Message failed to send.'**
  String get messageFailed;

  /// No description provided for @messageTapToRetry.
  ///
  /// In en, this message translates to:
  /// **'Tap to retry'**
  String get messageTapToRetry;

  /// No description provided for @messagingReconnecting.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting…'**
  String get messagingReconnecting;

  /// No description provided for @messagingConnectionLost.
  ///
  /// In en, this message translates to:
  /// **'Connection lost. Messages may be delayed.'**
  String get messagingConnectionLost;

  /// No description provided for @messageSearchQueryTooShort.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 2 characters to search.'**
  String get messageSearchQueryTooShort;

  /// No description provided for @localDatabaseUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Local message storage is unavailable. Try again after signing in.'**
  String get localDatabaseUnavailable;

  /// No description provided for @localDatabaseKeyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Secure storage is unavailable. Local messages cannot be loaded.'**
  String get localDatabaseKeyUnavailable;

  /// No description provided for @localDatabaseCorrupt.
  ///
  /// In en, this message translates to:
  /// **'Local message storage was reset. Your conversations will resync.'**
  String get localDatabaseCorrupt;

  /// No description provided for @localDatabaseEncryptionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Encrypted storage is unavailable on this device.'**
  String get localDatabaseEncryptionUnavailable;

  /// No description provided for @syncTemporarilyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sync is temporarily unavailable. Cached messages remain available.'**
  String get syncTemporarilyUnavailable;

  /// No description provided for @messageQueuedOffline.
  ///
  /// In en, this message translates to:
  /// **'Message queued. It will send when you are back online.'**
  String get messageQueuedOffline;

  /// No description provided for @messageRetryScheduled.
  ///
  /// In en, this message translates to:
  /// **'Send failed. Retrying automatically.'**
  String get messageRetryScheduled;

  /// No description provided for @messageFailedPermanently.
  ///
  /// In en, this message translates to:
  /// **'This message could not be sent.'**
  String get messageFailedPermanently;

  /// No description provided for @messageDeliveryQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get messageDeliveryQueued;

  /// No description provided for @messageDeliverySending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get messageDeliverySending;

  /// No description provided for @messageDeliveryRetrying.
  ///
  /// In en, this message translates to:
  /// **'Retrying'**
  String get messageDeliveryRetrying;

  /// No description provided for @messageDeliveryFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send'**
  String get messageDeliveryFailed;

  /// No description provided for @messageDeliverySent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get messageDeliverySent;

  /// No description provided for @messageDeliveryDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get messageDeliveryDelivered;

  /// No description provided for @messageDeliveryRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get messageDeliveryRead;

  /// No description provided for @messageRetryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry send'**
  String get messageRetryAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
