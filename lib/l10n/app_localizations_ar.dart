// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Pokidoki';

  @override
  String get splashTagline => 'محادثات خاصة، ومحمية.';

  @override
  String get splashPreparing => 'جارٍ تأمين مساحتك';

  @override
  String get splashLoadingSemantic => 'Pokidoki قيد التشغيل';

  @override
  String get splashReadySemantic => 'Pokidoki جاهز';

  @override
  String get actionContinue => 'متابعة';

  @override
  String get actionContinueUpper => 'متابعة';

  @override
  String get actionGetStarted => 'ابدأ الآن';

  @override
  String get actionSkip => 'تخطّي';

  @override
  String get actionRetry => 'إعادة المحاولة';

  @override
  String get actionCreateAccount => 'إنشاء حساب';

  @override
  String get actionSignIn => 'تسجيل الدخول';

  @override
  String onboardingPageSemantic(int current, int total) {
    return 'صفحة التعريف $current من $total';
  }

  @override
  String get onboarding1Title => 'محادثاتك تبقى خاصة';

  @override
  String get onboarding1Body =>
      'تُحمى الرسائل على جهازك ولا يمكن قراءتها إلا من المشاركين في المحادثة.';

  @override
  String get onboarding1IllustrationSemantic =>
      'رسم يوضح محادثة خاصة بين شخصين';

  @override
  String get onboarding2Title => 'اعرف من تتحدث إليه';

  @override
  String get onboarding2Body =>
      'تحقق من جهات الاتصال الموثوقة باستخدام رمز QR أو رقم الأمان قبل مشاركة معلومات حساسة.';

  @override
  String get onboarding2IllustrationSemantic =>
      'رسم يوضح التحقق من جهة الاتصال برمز QR وعلامة صح';

  @override
  String get onboarding3Title => 'مساحتك الخاصة تبقى مقفلة';

  @override
  String get onboarding3Body =>
      'احمِ Pokidoki برمز PIN للتطبيق وبالمقاييس الحيوية لجهازك، حتى لا يصل أحد سواك إلى محادثاتك.';

  @override
  String get onboarding3IllustrationSemantic =>
      'رسم يوضح قفل التطبيق برمز PIN والمقاييس الحيوية';

  @override
  String get welcomeTitle => 'مرحبًا بك في مساحتك الخاصة';

  @override
  String get welcomeBody => 'تواصل مع من تثق بهم واحرص على حماية محادثاتك.';

  @override
  String get welcomeFeaturePrivate => 'محادثات خاصة';

  @override
  String get welcomeFeatureVerification => 'التحقق من جهات الاتصال';

  @override
  String get welcomeFeatureAppLock => 'حماية بقفل التطبيق';

  @override
  String get welcomeTermsPrefix => 'بالمتابعة، فإنك توافق على ';

  @override
  String get welcomeTermsOfService => 'شروط الخدمة';

  @override
  String get welcomeTermsMiddle => ' و';

  @override
  String get welcomePrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get welcomeTermsSuffix => '.';

  @override
  String get welcomePrivacyNote => 'لا يمكن لـ Pokidoki قراءة رسائلك الخاصة.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageFrench => 'Français';

  @override
  String languageSelectorSemantic(String language) {
    return 'اللغة، الحالية $language';
  }

  @override
  String get devPlaceholderTitle => 'الشاشة غير منفّذة بعد';

  @override
  String get devPlaceholderBody => 'هذه الوجهة محفوظة لدفعة تنفيذ لاحقة.';

  @override
  String get devPlaceholderBadge => 'شاشة تطوير مؤقتة';

  @override
  String get devScreenCreateAccount => 'شاشة إنشاء الحساب غير منفّذة بعد.';

  @override
  String get devScreenSignIn => 'شاشة تسجيل الدخول غير منفّذة بعد.';

  @override
  String get devConversationsHome =>
      'سيتم تنفيذ الشاشة الرئيسية للمحادثات في دفعة لاحقة.';

  @override
  String get devAccountRecovery =>
      'سيتم تنفيذ استعادة الحساب في الدفعة التالية.';

  @override
  String get devAccountRecoveryNextBatch =>
      'سيتم تنفيذ استعادة الحساب في الدفعة التالية.';

  @override
  String get devPinRecovery =>
      'سيتم تنفيذ استعادة رمز PIN للتطبيق في دفعة لاحقة.';

  @override
  String get devSettings => 'سيتم تنفيذ الإعدادات في دفعة لاحقة.';

  @override
  String get devOneToOneChat => 'سيتم تنفيذ المحادثة الفردية في دفعة لاحقة.';

  @override
  String get devQrScanner => 'سيتم تنفيذ ماسح QR في دفعة لاحقة.';

  @override
  String get devReportUser => 'سيتم تنفيذ الإبلاغ عن مستخدم في الدفعة التالية.';

  @override
  String get devChangePassword =>
      'سيتم تنفيذ تغيير كلمة المرور في الدفعة التالية.';

  @override
  String get devEmailManagement =>
      'سيتم تنفيذ إدارة البريد الإلكتروني في الدفعة التالية.';

  @override
  String get actionTryAgain => 'حاول مرة أخرى';

  @override
  String get routeNotFoundTitle => 'الصفحة غير موجودة';

  @override
  String get routeNotFoundBody => 'هذا الرابط غير متاح في التطبيق.';

  @override
  String get routeNotFoundAction => 'الانتقال إلى الترحيب';

  @override
  String get actionCancel => 'إلغاء';

  @override
  String get chatsYouPrefix => 'أنت: ';

  @override
  String get chatsYesterday => 'أمس';

  @override
  String chatsUnreadCount(int count) {
    return '$count رسائل غير مقروءة';
  }

  @override
  String get chatsSearchHint => 'البحث في المحادثات';

  @override
  String get chatsProtectedBanner => 'محادثاتك محمية بالتشفير من طرف إلى طرف.';

  @override
  String get chatsPinned => 'مثبّتة';

  @override
  String get chatsRecent => 'الأخيرة';

  @override
  String get chatsRecentContacts => 'جهات اتصال حديثة';

  @override
  String get chatsNewConversation => 'محادثة جديدة';

  @override
  String get chatsEmptyTitle => 'لا محادثات بعد';

  @override
  String get chatsEmptyBody => 'ابدأ محادثة خاصة مع أحد جهات اتصالك.';

  @override
  String get contactsSearchHint => 'البحث في جهات الاتصال';

  @override
  String get contactsRequestsTitle => 'طلبات الاتصال';

  @override
  String contactsRequestsWaiting(int count) {
    return '$count طلبات بانتظار مراجعتك.';
  }

  @override
  String get contactsVerifiedSection => 'جهات اتصال موثّقة';

  @override
  String get contactsAllContacts => 'كل جهات الاتصال';

  @override
  String get contactsEmptyTitle => 'لا جهات اتصال بعد';

  @override
  String get contactsEmptyBody => 'ابحث عن شخص أو اقبل طلب اتصال.';

  @override
  String get contactsReviewRequests => 'مراجعة الطلبات';

  @override
  String get contactsRequestsInfo =>
      'قبول الطلب يضيف الحساب إلى جهات اتصالك. ولا يتحقق من هوية الشخص. تحقق من جهة الاتصال قبل مشاركة معلومات حساسة.';

  @override
  String get contactsReceived => 'الواردة';

  @override
  String get contactsSent => 'المرسلة';

  @override
  String get contactsAccept => 'قبول';

  @override
  String get contactsDecline => 'رفض';

  @override
  String get contactsCancelRequest => 'إلغاء';

  @override
  String get contactsRequestAccepted => 'تم قبول طلب الاتصال.';

  @override
  String get contactsRequestDeclined => 'تم رفض طلب الاتصال.';

  @override
  String get contactsNoReceivedRequests => 'لا طلبات واردة.';

  @override
  String get contactsNoSentRequests => 'لا طلبات مرسلة.';

  @override
  String get usersFindSomeone => 'ابحث عن شخص';

  @override
  String get usersFindPeople => 'ابحث عن أشخاص';

  @override
  String get usersSearchByUsernameOrId =>
      'ابحث باسم المستخدم أو معرّف Pokidoki';

  @override
  String get usersSearchInitial => 'ابحث باسم المستخدم أو معرّف Pokidoki.';

  @override
  String get usersNoResultsTitle => 'لم يُعثر على مستخدمين';

  @override
  String get usersNoResultsBody => 'جرّب اسم مستخدم أو معرّف Pokidoki آخر.';

  @override
  String get usersScanQr => 'مسح رمز QR';

  @override
  String get usersScanQrSubtitle => 'أضف أو تحقق من شخص قريب';

  @override
  String get usersNewGroup => 'مجموعة جديدة';

  @override
  String get usersNewGroupSubtitle => 'أنشئ محادثة خاصة...';

  @override
  String get usersComingLater => 'قريبًا';

  @override
  String get usersProfileTitle => 'الملف الشخصي';

  @override
  String get usersSendRequest => 'إرسال طلب اتصال';

  @override
  String get usersRequestSent => 'تم إرسال طلب الاتصال.';

  @override
  String get usersRequestPending => 'تم إرسال الطلب';

  @override
  String get usersMessage => 'رسالة';

  @override
  String get usersNotInContacts => 'ليس ضمن جهات اتصالك';

  @override
  String get usersInContacts => 'ضمن جهات اتصالك';

  @override
  String get usersNotVerified => 'غير موثّق';

  @override
  String get usersVerifyBeforeSensitive =>
      'تحقق من هذا الشخص قبل مشاركة معلومات حساسة.';

  @override
  String get usersAbout => 'نبذة';

  @override
  String get usersSharedContext => 'سياق مشترك';

  @override
  String get usersCopyId => 'نسخ معرّف Pokidoki';

  @override
  String get usersBlockAction => 'حظر';

  @override
  String get usersReportAction => 'إبلاغ';

  @override
  String usersBlockTitle(String name) {
    return 'حظر $name؟';
  }

  @override
  String usersBlockBody(String name) {
    return 'لن يتمكن $name من إرسال طلبات اتصال أو رسائل جديدة إليك.';
  }

  @override
  String get usersBlocked => 'تم حظر المستخدم.';

  @override
  String get qrScanTitle => 'مسح رمز QR';

  @override
  String get qrScanHeading => 'امسح رمز Pokidoki QR';

  @override
  String get qrScanBody => 'ضع الرمز داخل الإطار لإضافة شخص أو التحقق منه';

  @override
  String get qrLookingForCode => 'جارٍ البحث عن رمز Pokidoki...';

  @override
  String get qrFrameSemantic => 'إطار مسح رمز QR';

  @override
  String get qrSimulateScan => 'محاكاة المسح';

  @override
  String get qrInvalidCode => 'رمز QR هذا ليس رمز جهة اتصال Pokidoki صالحًا.';

  @override
  String get qrFlash => 'الفلاش';

  @override
  String get qrGallery => 'المعرض';

  @override
  String get qrMyCodeAction => 'رمزي QR';

  @override
  String get qrMyCodeTitle => 'رمز Pokidoki QR الخاص بي';

  @override
  String get qrHelp => 'مساعدة';

  @override
  String get qrBrightness => 'السطوع';

  @override
  String get qrCodeSemantic => 'رمز QR لجهة اتصال Pokidoki الخاصة بك';

  @override
  String get qrPublicIdentity => 'هويتك العامة في Pokidoki';

  @override
  String get qrPublicIdHelp =>
      'يمكن للأشخاص استخدام هذا المعرّف للعثور على حسابك.';

  @override
  String get qrShareExplanation =>
      'يساعد رمز Pokidoki QR الأشخاص على العثور على حسابك أو التحقق منه دون كتابة اسم المستخدم أو المعرّف.';

  @override
  String get qrShareAction => 'مشاركة';

  @override
  String get qrShareReady => 'رمز جهة اتصال Pokidoki جاهز للمشاركة.';

  @override
  String get qrRefreshAction => 'تحديث';

  @override
  String get qrRefreshTitle => 'إنشاء رمز QR جديد؟';

  @override
  String get qrRefreshBody => 'لن يُستخدم رمز الاتصال السابق للمسح الجديد.';

  @override
  String get verifyContactTitle => 'التحقق من جهة الاتصال';

  @override
  String get verifyNotVerified => 'غير موثّق';

  @override
  String get verifyQrRecognized => 'تم التعرّف على رمز QR';

  @override
  String verifyQrRecognizedBody(String name) {
    return 'ينتمي هذا الرمز إلى ملف $name في Pokidoki.';
  }

  @override
  String get verifyConfirmInPerson => 'تأكد أنك تتحدث إلى الشخص الصحيح';

  @override
  String get verifyScanQrMethod => 'مسح رمز QR';

  @override
  String get verifyScanQrMethodBody => 'يُفضَّل عندما تكونان معًا';

  @override
  String get verifyCompareSafetyNumber => 'مقارنة رقم الأمان';

  @override
  String get verifyCompareSafetyNumberBody =>
      'مفيد عندما لا تكونان في المكان نفسه';

  @override
  String get verifyWhatItConfirms => 'ما يؤكده التحقق';

  @override
  String get verifyBulletSameIdentity => 'أنكما تقارنان هوية جهة الاتصال نفسها';

  @override
  String get verifyBulletNotReplaced =>
      'أن هوية الأمان لجهة الاتصال لم تُستبدل بشكل غير متوقع';

  @override
  String get verifyBulletMarkedOnDevice =>
      'يمكن لـ Pokidoki تعليم جهة الاتصال كموثّقة على جهازك';

  @override
  String verifyMarkTitle(String name) {
    return 'توثيق $name؟';
  }

  @override
  String verifyMarkBody(String name) {
    return 'تابع فقط إذا أكدت هذا الملف مع $name شخصيًا أو عبر قناة موثوقة أخرى.';
  }

  @override
  String get verifyMarkAction => 'تعليم كموثّق';

  @override
  String get verifySafetyConfirmed => 'تم تأكيد رقم الأمان.';

  @override
  String get verifyResetTitle => 'إعادة تعيين التحقق؟';

  @override
  String verifyResetBody(String name) {
    return 'سيظهر $name غير موثّق حتى تقارن الهوية مرة أخرى.';
  }

  @override
  String get verifyResetAction => 'إعادة تعيين';

  @override
  String get safetyNumberTitle => 'رقم الأمان';

  @override
  String safetyCompareHeading(String name) {
    return 'قارن هذا الرقم مع $name';
  }

  @override
  String get safetyCompareBody =>
      'يجب أن يعرض الجهازان رقم الأمان نفسه. قارنه شخصيًا أو عبر وسيلة تواصل موثوقة أخرى.';

  @override
  String get safetyNumberSemantic => 'مجموعات أرقام الأمان';

  @override
  String get safetyNumberCopied => 'تم نسخ رقم الأمان.';

  @override
  String get safetyDoNotCompareOnlyInChat =>
      'لا تقارن هذا الرقم داخل المحادثة التي تتحقق منها فقط.';

  @override
  String get chatTypeMessage => 'اكتب رسالة';

  @override
  String get chatSend => 'إرسال';

  @override
  String get chatAttach => 'مرفق';

  @override
  String get chatReply => 'رد';

  @override
  String get chatCopy => 'نسخ';

  @override
  String get chatDelete => 'حذف';

  @override
  String get chatDeleteForMe => 'حذف لدي';

  @override
  String get chatDeleteTitle => 'حذف هذه الرسالة؟';

  @override
  String get chatDeleteBody => 'سيؤدي هذا إلى إزالة الرسالة من هذا الجهاز.';

  @override
  String get chatMessageInfo => 'معلومات الرسالة';

  @override
  String get chatMessageCopied => 'تم نسخ الرسالة.';

  @override
  String get chatSearchInConversation => 'بحث';

  @override
  String get chatConversationInfo => 'معلومات المحادثة';

  @override
  String get chatProtectedBanner =>
      'الرسائل في هذه المحادثة محمية بالتشفير من طرف إلى طرف.';

  @override
  String get chatToday => 'اليوم';

  @override
  String get chatAttachmentLater => 'سيتم ربط اختيار المرفقات في مرحلة لاحقة.';

  @override
  String chatBlockedNotice(String name) {
    return 'لقد حظرت $name.';
  }

  @override
  String get chatSent => 'أُرسلت';

  @override
  String get chatDelivered => 'وُصلت';

  @override
  String get chatRead => 'قُرئت';

  @override
  String get chatMuteNotifications => 'الإشعارات';

  @override
  String get chatDisappearingMessages => 'الرسائل المختفية';

  @override
  String get chatDisappearingOff => 'إيقاف';

  @override
  String get chatDisappearingOffHelp => 'تبقى الرسائل حتى تُحذف';

  @override
  String get chatDisappearingOneHour => 'ساعة واحدة';

  @override
  String get chatDisappearingOneHourHelp => 'محادثة مؤقتة قياسية';

  @override
  String get chatDisappearingOneDay => 'يوم واحد';

  @override
  String get chatDisappearingOneDayHelp => 'إعداد الخصوصية الافتراضي';

  @override
  String get chatDisappearingOneWeek => 'أسبوع واحد';

  @override
  String get chatDisappearingOneWeekHelp => 'سجل محادثة ممتد';

  @override
  String get chatDisappearingAppliesFuture =>
      'ينطبق المؤقت الجديد على الرسائل المستقبلية. تحتفظ الرسائل السابقة بمؤقتها الأصلي.';

  @override
  String get chatDisappearingScreenshotWarning =>
      'الاختفاء لا يمنع النسخ. يمكن للمستلمين التقاط لقطات شاشة أو نسخ النص أو إعادة التوجيه قبل الاختفاء.';

  @override
  String get chatSharedContent => 'المحتوى المشترك';

  @override
  String chatSharedWith(String name) {
    return 'مشترك مع $name';
  }

  @override
  String get chatPhotosAndVideos => 'الصور ومقاطع الفيديو';

  @override
  String get chatFiles => 'الملفات';

  @override
  String get chatLinks => 'الروابط';

  @override
  String get chatMedia => 'الوسائط';

  @override
  String get chatNoMedia => 'لا وسائط بعد';

  @override
  String get chatNoFiles => 'لا ملفات بعد';

  @override
  String get chatNoLinks => 'لا روابط بعد';

  @override
  String get chatFilePreviewLater => 'سيتم ربط معاينة الملفات في مرحلة لاحقة.';

  @override
  String get chatSearchHint => 'البحث في الرسائل';

  @override
  String get chatSearchInitial => 'ابحث في رسائل هذه المحادثة.';

  @override
  String chatSearchResultCount(int count) {
    return '$count نتائج';
  }

  @override
  String get chatNoMessagesFound => 'لم يُعثر على رسائل';

  @override
  String get chatNoMessagesFoundBody => 'جرّب كلمة أو عبارة أخرى.';

  @override
  String get chatDeleteConversation => 'حذف المحادثة';

  @override
  String get chatDeleteConversationTitle => 'حذف هذه المحادثة؟';

  @override
  String get chatDeleteConversationBody =>
      'سيؤدي هذا إلى إزالة سجل المحادثة المحلي من هذا الجهاز.';

  @override
  String get authCreateAccountTitle => 'إنشاء حساب';

  @override
  String get authCreateAccountHeading => 'أنشئ حسابك الخاص';

  @override
  String get authCreateAccountBody =>
      'جهّز حساب Pokidoki لبدء التواصل مع من تثق بهم.';

  @override
  String get authCreateAccountAction => 'إنشاء حساب';

  @override
  String get authCreateAccountLink => 'إنشاء حساب';

  @override
  String get authEmailLabel => 'البريد الإلكتروني';

  @override
  String get authEmailOrUsernameLabel => 'البريد الإلكتروني أو اسم المستخدم';

  @override
  String get authPasswordLabel => 'كلمة المرور';

  @override
  String get authConfirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get authPasswordRequirements => 'يجب أن تتضمن كلمة المرور:';

  @override
  String get authPasswordMinLength => '12 حرفًا على الأقل';

  @override
  String get authPasswordUppercase => 'حرفًا كبيرًا واحدًا';

  @override
  String get authPasswordLowercase => 'حرفًا صغيرًا واحدًا';

  @override
  String get authPasswordNumber => 'رقمًا واحدًا';

  @override
  String get authPasswordSymbol => 'رمزًا واحدًا';

  @override
  String get authAgreePrefix => 'أوافق على ';

  @override
  String get authPasswordPrivacyNote =>
      'تحمي كلمة مرور تسجيل الدخول حسابك. تبقى مفاتيح رسائلك الخاصة على جهازك.';

  @override
  String get authAlreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get authInvalidEmail => 'أدخل بريدًا إلكترونيًا صالحًا.';

  @override
  String get authPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get authGenericError => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get authEmailUnavailable =>
      'لا يمكن استخدام هذا البريد. جرّب عنوانًا آخر.';

  @override
  String get authInvalidCredentials =>
      'تعذّر تسجيل الدخول. تحقق من معلوماتك وحاول مرة أخرى.';

  @override
  String get authEmailNotVerified => 'تحقق من بريدك قبل تسجيل الدخول.';

  @override
  String get authAccountSuspended => 'هذا الحساب غير متاح مؤقتًا.';

  @override
  String get authAccountDisabled => 'تم تعطيل هذا الحساب.';

  @override
  String get authVerificationInvalid => 'رمز غير صالح. حاول مرة أخرى.';

  @override
  String get authVerificationExpired =>
      'انتهت صلاحية الرمز. اطلب رمزًا جديدًا.';

  @override
  String get authVerificationAttemptsExceeded =>
      'محاولات كثيرة. اطلب رمزًا جديدًا.';

  @override
  String get authVerificationResendTooSoon => 'يرجى الانتظار قبل طلب رمز آخر.';

  @override
  String get authSessionExpired => 'انتهت جلستك. سجّل الدخول مرة أخرى.';

  @override
  String get authRateLimited => 'محاولات كثيرة. انتظر ثم حاول مرة أخرى.';

  @override
  String get authNoInternet =>
      'لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مرة أخرى.';

  @override
  String get authRequestTimedOut => 'انتهت مهلة الطلب. حاول مرة أخرى.';

  @override
  String get authServerUnavailable => 'الخادم غير متاح. حاول لاحقًا.';

  @override
  String get authUnexpectedError => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get profileNotCreated => 'لم يتم إعداد ملفك الشخصي بعد.';

  @override
  String get profileAlreadyExists => 'يوجد ملف شخصي لهذا الحساب بالفعل.';

  @override
  String get profileNotFound => 'الملف الشخصي غير موجود.';

  @override
  String get profileNotDiscoverable => 'هذا الملف الشخصي غير متاح.';

  @override
  String get usernameInvalid => 'اسم المستخدم غير صالح.';

  @override
  String get usernameChangeTooSoon => 'غيّرت اسم المستخدم مؤخراً. حاول لاحقاً.';

  @override
  String get userSearchQueryTooShort => 'أدخل حرفين على الأقل للبحث.';

  @override
  String get userNotFound => 'المستخدم غير موجود.';

  @override
  String get userUnexpectedError => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get authSignedOut => 'تم تسجيل خروجك.';

  @override
  String get authSignInTitle => 'تسجيل الدخول';

  @override
  String get authSignInHeading => 'مرحبًا بعودتك';

  @override
  String get authSignInBody => 'سجّل الدخول للوصول إلى محادثاتك الخاصة.';

  @override
  String get authSignInAction => 'تسجيل الدخول';

  @override
  String get authRememberDevice => 'تذكّر هذا الجهاز';

  @override
  String get authForgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get authOrContinueSecurely => 'أو تابع بأمان';

  @override
  String get authUseFingerprint => 'استخدم بصمة الإصبع';

  @override
  String get authFingerprintAfterSignIn =>
      'فتح القفل بالبصمة متاح بعد تسجيل الدخول.';

  @override
  String get authNewToPokidoki => 'جديد على Pokidoki؟ ';

  @override
  String get authSignInError =>
      'تعذّر تسجيل الدخول. تحقق من معلوماتك وحاول مرة أخرى.';

  @override
  String get authInvalidCredentialsForm =>
      'أدخل بريدك أو اسم المستخدم وكلمة المرور.';

  @override
  String get authVerifyEmailTitle => 'تأكيد البريد';

  @override
  String get authCheckYourEmail => 'تحقق من بريدك';

  @override
  String get authVerificationBody =>
      'أدخل رمز التحقق المكوّن من ستة أرقام الذي أرسلناه إلى بريدك الإلكتروني.';

  @override
  String get authVerificationCodeSemantic => 'رمز التحقق';

  @override
  String get authVerifyEmailAction => 'تأكيد البريد';

  @override
  String get authResendCode => 'إعادة إرسال الرمز';

  @override
  String get authResendReady => 'يمكنك إعادة إرسال الرمز الآن.';

  @override
  String authResendCountdown(String seconds) {
    return 'إعادة الإرسال متاحة خلال 00:$seconds';
  }

  @override
  String get authChangeEmail => 'تغيير البريد';

  @override
  String get authCodeResent => 'تم إرسال رمز تحقق جديد.';

  @override
  String get authVerificationError => 'هذا الرمز غير صالح. حاول مرة أخرى.';

  @override
  String get authProfileStep1 => 'إعداد الملف · الخطوة 1 من 2';

  @override
  String get authProfileStep2 => 'إعداد الملف · الخطوة 2 من 2';

  @override
  String get authUsernameHeading => 'أنشئ اسم مستخدم Pokidoki';

  @override
  String get authUsernameBody =>
      'يمكن للأشخاص استخدام اسم المستخدم للعثور عليك وإرسال طلب اتصال.';

  @override
  String authUsernameAvailable(String username) {
    return '@$username متاح';
  }

  @override
  String get authUsernameUnavailable => 'اسم المستخدم هذا غير متاح.';

  @override
  String get authUsernameRequirements => 'متطلبات اسم المستخدم';

  @override
  String get authUsernameLength => 'من 3 إلى 24 حرفًا';

  @override
  String get authUsernameCharset => 'أحرف صغيرة وأرقام ونقاط وشرطات سفلية';

  @override
  String get authUsernameStartsWithLetter => 'يجب أن يبدأ بحرف';

  @override
  String get authUsernameNoSpaces => 'بدون مسافات';

  @override
  String get authUsernameUnique => 'يجب أن يكون فريدًا';

  @override
  String get authCreateProfileTitle => 'إنشاء ملف شخصي';

  @override
  String get authProfileHeading => 'اجعل Pokidoki يبدو كأنه لك';

  @override
  String get authProfileBody =>
      'أضف الاسم والصورة التي سيتعرّف عليها جهات الاتصال الموثوقة.';

  @override
  String get authDisplayNameLabel => 'الاسم الظاهر';

  @override
  String get authAboutYouLabel => 'نبذة عنك (اختياري)';

  @override
  String get authSkipOptionalDetails => 'تخطّي التفاصيل الاختيارية';

  @override
  String get authChoosePhoto => 'اختيار صورة';

  @override
  String get authTakePhoto => 'التقاط صورة';

  @override
  String get authRemovePhoto => 'إزالة الصورة';

  @override
  String get authCreatePinTitle => 'إنشاء رمز PIN للتطبيق';

  @override
  String get authCreatePinHeading => 'أنشئ رمز PIN للتطبيق';

  @override
  String get authCreatePinBody =>
      'اختر رمز PIN مكوّنًا من ستة أرقام لحماية الوصول إلى Pokidoki على هذا الجهاز.';

  @override
  String get authPinDifferentFromPassword =>
      'هذا الرمز مختلف عن كلمة مرور حسابك.';

  @override
  String get authPinLocalProtectionNote =>
      'يحمي رمز PIN للتطبيق الوصول المحلي. وهو ليس مفتاح تشفير رسائلك.';

  @override
  String authPinDigitsEntered(int count) {
    return 'تم إدخال $count من 6 أرقام';
  }

  @override
  String get authConfirmPinTitle => 'تأكيد رمز PIN';

  @override
  String get authConfirmPinHeading => 'أكّد رمز PIN للتطبيق';

  @override
  String get authConfirmPinBody =>
      'أدخل الرمز نفسه المكوّن من ستة أرقام مرة أخرى للتأكد من تذكّره.';

  @override
  String get authConfirmPinAction => 'تأكيد الرمز';

  @override
  String get authChooseDifferentPin => 'اختر رمزًا مختلفًا';

  @override
  String get authEnterAllSixDigits => 'أدخل الأرقام الستة كلها للمتابعة';

  @override
  String get authPinMismatch => 'رمزا PIN غير متطابقين. حاول مرة أخرى.';

  @override
  String get authBiometricsHeading => 'افتح Pokidoki بسرعة أكبر';

  @override
  String get authBiometricsBody =>
      'سيبقى رمز PIN للتطبيق متاحًا كخيار احتياطي.';

  @override
  String get authBiometricsFasterTitle => 'وصول أسرع';

  @override
  String get authBiometricsFasterBody =>
      'افتح Pokidoki دون كتابة رمز PIN في كل مرة.';

  @override
  String get authBiometricsDeviceTitle => 'محمي بواسطة جهازك';

  @override
  String get authBiometricsDeviceBody => 'تتم المصادقة عبر نظام أمان هاتفك.';

  @override
  String get authBiometricsPinTitle => 'رمز PIN يبقى متاحًا';

  @override
  String get authBiometricsPinBody =>
      'يمكنك فتح Pokidoki برمز PIN المكوّن من ستة أرقام.';

  @override
  String get authBiometricsPrivacyNote =>
      'تُدار بياناتك الحيوية بواسطة جهازك ولا يخزّنها Pokidoki.';

  @override
  String get authEnableBiometricsAction => 'تفعيل الفتح الحيوي';

  @override
  String get authNotNow => 'ليس الآن';

  @override
  String get authAppLockHeading => 'Pokidoki مقفل';

  @override
  String get authAppLockBody =>
      'أدخل رمز PIN المكوّن من ستة أرقام أو استخدم المقاييس الحيوية للوصول إلى محادثاتك.';

  @override
  String get authEnterAppPin => 'أدخل رمز PIN للتطبيق';

  @override
  String get authAppLockError => 'رمز PIN غير صحيح. حاول مرة أخرى.';

  @override
  String get authForgotPin => 'هل نسيت رمز PIN للتطبيق؟';

  @override
  String get authUseBiometrics => 'استخدم المقاييس الحيوية';

  @override
  String get authDeleteDigit => 'حذف رقم';

  @override
  String get authBiometricsUnavailable => 'الفتح الحيوي غير مفعّل لهذه الجلسة.';

  @override
  String get stateLoading => 'جارٍ التحميل';

  @override
  String get stateEmpty => 'لا يوجد شيء هنا بعد';

  @override
  String get stateError => 'حدث خطأ ما';

  @override
  String get stateOffline => 'يبدو أنك غير متصل';

  @override
  String get navChats => 'المحادثات';

  @override
  String get navContacts => 'جهات الاتصال';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get semanticVerified => 'موثّق';

  @override
  String get semanticClose => 'إغلاق';

  @override
  String get semanticBack => 'رجوع';

  @override
  String get semanticSearch => 'بحث';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsAccount => 'الحساب';

  @override
  String get settingsAccountProtected => 'الحساب محمي';

  @override
  String get settingsPrivacySecurity => 'الخصوصية والأمان';

  @override
  String get settingsPreferences => 'التفضيلات';

  @override
  String get settingsAppLock => 'قفل التطبيق';

  @override
  String get settingsAppLockSubtitle => 'رمز PIN والمقاييس الحيوية';

  @override
  String get settingsBiometricUnlock => 'الفتح الحيوي';

  @override
  String get settingsAutomaticallyLock => 'القفل التلقائي';

  @override
  String get settingsScreenPrivacy => 'خصوصية الشاشة';

  @override
  String get settingsScreenPrivacySubtitle =>
      'إخفاء المحتوى في مبدّل التطبيقات';

  @override
  String get settingsReadReceipts => 'إيصالات القراءة';

  @override
  String get settingsTypingIndicators => 'مؤشرات الكتابة';

  @override
  String get settingsBlockedUsers => 'المستخدمون المحظورون';

  @override
  String get settingsLinkedDevices => 'الأجهزة المرتبطة';

  @override
  String settingsActiveDevices(int count) {
    return '$count نشط';
  }

  @override
  String get settingsSecurityActivity => 'نشاط الأمان';

  @override
  String get settingsSecurityActivitySubtitle => 'راجع التغييرات المهمة';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsStorageUsage => 'استخدام التخزين';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsMessageNotifications => 'إشعارات الرسائل';

  @override
  String get settingsNotificationPreviews => 'معاينات الإشعارات';

  @override
  String get settingsNotificationPreviewsSubtitle => 'إظهار نص الرسالة';

  @override
  String get settingsNotificationSound => 'صوت الإشعار';

  @override
  String get settingsNotificationSoundDefault => 'Pokidoki الافتراضي';

  @override
  String get settingsVibration => 'الاهتزاز';

  @override
  String get settingsHelpInformation => 'المساعدة والمعلومات';

  @override
  String get settingsHelpCenter => 'مركز المساعدة';

  @override
  String get settingsHelpPlaceholder => 'سيتوفر محتوى المساعدة في إصدار لاحق.';

  @override
  String get settingsPokidokiVersion => 'إصدار Pokidoki';

  @override
  String get settingsSignOutTitle => 'تسجيل الخروج من Pokidoki؟';

  @override
  String get settingsSignOutBody =>
      'ستحتاج إلى تسجيل الدخول مرة أخرى للوصول إلى هذا الحساب.';

  @override
  String get settingsSignOutAction => 'تسجيل الخروج';

  @override
  String get settingsPublicIdentity => 'الهوية العامة';

  @override
  String get settingsDisplayName => 'الاسم المعروض';

  @override
  String get settingsUsername => 'اسم المستخدم';

  @override
  String get settingsPokidokiId => 'معرّف Pokidoki';

  @override
  String get settingsCopyId => 'نسخ معرّف Pokidoki';

  @override
  String get settingsIdCopied => 'تم نسخ معرّف Pokidoki.';

  @override
  String get settingsSharePublicIdentity => 'شارك هويتك العامة في Pokidoki';

  @override
  String get settingsPreviewPublicProfile => 'معاينة الملف العام';

  @override
  String get settingsPreviewPublicProfileBody =>
      'اطّلع على ما يمكن لمستخدمي Pokidoki الآخرين رؤيته';

  @override
  String get settingsSignInRecovery => 'تسجيل الدخول والاستعادة';

  @override
  String get settingsEmailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get settingsVerified => 'موثّق';

  @override
  String get settingsPassword => 'كلمة المرور';

  @override
  String get settingsPasswordChangedAgo => 'تم التغيير منذ 3 أشهر';

  @override
  String get settingsAccountRecovery => 'استعادة الحساب';

  @override
  String get settingsAccountRecoverySubtitle => 'راجع خيارات الاستعادة والتحقق';

  @override
  String get settingsDeleteAccount => 'حذف الحساب';

  @override
  String get settingsDeleteAccountUnavailable =>
      'حذف الحساب غير متاح في هذه الدفعة.';

  @override
  String get settingsLinkedDevicesInfo =>
      'راجع هذه القائمة بانتظام وأزل أي جهاز لا تتعرف عليه.';

  @override
  String get settingsLinkedDevicesError => 'تعذّر تحميل الأجهزة المرتبطة.';

  @override
  String get settingsDeviceLinkedRecently => 'تم ربط جهاز مؤخرًا';

  @override
  String get settingsDeviceLinkedRecentlyBody =>
      'راجع الجهاز أدناه وأزله إذا لم تتعرف عليه.';

  @override
  String get settingsThisDevice => 'هذا الجهاز';

  @override
  String get settingsOtherDevices => 'أجهزة أخرى';

  @override
  String get settingsCurrentDevice => 'الحالي';

  @override
  String get settingsNeedsReview => 'يحتاج مراجعة';

  @override
  String get settingsActiveNow => 'نشط الآن';

  @override
  String get settingsLastActiveRecently => 'آخر نشاط مؤخرًا';

  @override
  String get settingsNoOtherDevices => 'لا توجد أجهزة مرتبطة أخرى';

  @override
  String get settingsNoOtherDevicesBody =>
      'هذا الهاتف فقط مرتبط بحسابك حاليًا.';

  @override
  String settingsRemoveDeviceTitle(String name) {
    return 'إزالة $name؟';
  }

  @override
  String get settingsRemoveDeviceBody =>
      'سيحتاج هذا الجهاز إلى تسجيل الدخول مرة أخرى.';

  @override
  String get settingsRemoveDeviceAction => 'إزالة الجهاز';

  @override
  String get settingsDeviceRemoved => 'تمت إزالة الجهاز.';

  @override
  String get settingsSecurityActivityError => 'تعذّر تحميل نشاط الأمان.';

  @override
  String get settingsSecurityHistoryTitle => 'سجل أمان حسابك';

  @override
  String get settingsSecurityHistoryBody =>
      'راجع أحداث الأمان الأخيرة مثل عمليات تسجيل الدخول وتغييرات كلمة المرور وإضافة الأجهزة.';

  @override
  String settingsEventsNeedReview(int count) {
    return '$count حدث يحتاج إلى مراجعتك';
  }

  @override
  String get settingsFilterAll => 'الكل';

  @override
  String get settingsFilterDevices => 'الأجهزة';

  @override
  String get settingsFilterIdentity => 'الهوية';

  @override
  String get settingsFilterSignIn => 'تسجيل الدخول';

  @override
  String get settingsNoSecurityEvents => 'لا توجد أحداث أمان لعرضها.';

  @override
  String get settingsReviewLinkedDevices => 'مراجعة الأجهزة المرتبطة';

  @override
  String get settingsReviewLinkedDevicesHint =>
      'إذا لم تتعرف على هذا الجهاز، راجع أجهزتك المرتبطة.';

  @override
  String get settingsBlockedUsersInfo =>
      'لا يمكن للحسابات المحظورة التواصل معك';

  @override
  String get settingsBlockedUsersError => 'تعذّر تحميل المستخدمين المحظورين.';

  @override
  String settingsBlockedUsersCount(int count) {
    return '$count مستخدمون محظورون';
  }

  @override
  String get settingsNoBlockedUsers => 'لا يوجد مستخدمون محظورون';

  @override
  String get settingsNoBlockedUsersBody => 'سيظهر هنا الأشخاص الذين تحظرهم.';

  @override
  String settingsUnblockTitle(String name) {
    return 'إلغاء حظر $name؟';
  }

  @override
  String settingsUnblockBody(String name) {
    return 'قد يتمكن $name من إرسال رسائل أو طلبات اتصال إليك مرة أخرى.';
  }

  @override
  String get settingsUnblockAction => 'إلغاء الحظر';

  @override
  String settingsUnblockedSnack(String name) {
    return 'تم إلغاء حظر $name.';
  }

  @override
  String get settingsProtected => 'محمي';

  @override
  String get settingsUseAppLock => 'استخدام قفل التطبيق';

  @override
  String get settingsTurnOffAppLockTitle => 'إيقاف قفل التطبيق؟';

  @override
  String get settingsTurnOffAppLockBody =>
      'لن يطلب Pokidoki رمز PIN عند فتح التطبيق.';

  @override
  String get settingsTurnOffAppLockAction => 'إيقاف';

  @override
  String get settingsUnlockMethods => 'طرق الفتح';

  @override
  String get settingsChangeAppPin => 'تغيير رمز PIN للتطبيق';

  @override
  String get settingsPinLength => 'طول رمز PIN';

  @override
  String get settingsPinLengthValue => '6 أرقام';

  @override
  String get settingsAutomaticLocking => 'القفل التلقائي';

  @override
  String get settingsLockImmediately => 'فورًا';

  @override
  String get settingsLockAfter1Minute => 'بعد دقيقة واحدة';

  @override
  String get settingsLockAfter5Minutes => 'بعد 5 دقائق';

  @override
  String get settingsLockAfter30Minutes => 'بعد 30 دقيقة';

  @override
  String get settingsLockAfterRestart => 'طلب رمز PIN بعد إعادة تشغيل الجهاز';

  @override
  String get settingsAlwaysRequired => 'مطلوب دائمًا';

  @override
  String get settingsPrivacyWhileLocked => 'الخصوصية أثناء القفل';

  @override
  String get settingsHideContentInAppSwitcher =>
      'إخفاء المحتوى في مبدّل التطبيقات';

  @override
  String get settingsPinNotPassword => 'رمز PIN للتطبيق ليس كلمة مرور حسابك';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeSystem => 'استخدام إعداد الجهاز';

  @override
  String get settingsThemeSystemBody => 'يطابق مظهر النظام تلقائيًا';

  @override
  String get settingsDarkActive => 'المظهر الداكن مفعّل';

  @override
  String get settingsDarkActiveBody =>
      'يوفر البطارية ويقلل إجهاد العين في الإضاءة المنخفضة.';

  @override
  String get settingsLightActive => 'المظهر الفاتح مفعّل';

  @override
  String get settingsLightActiveBody =>
      'يستخدم ألوانًا أفتح للاستخدام النهاري.';

  @override
  String get settingsSystemActive => 'مظهر النظام مفعّل';

  @override
  String get settingsAppearanceSecurityNote => 'المظهر لا يغيّر أمانك';

  @override
  String settingsLanguageActive(String name) {
    return '$name مفعّلة';
  }

  @override
  String settingsLanguageActiveBody(String name) {
    return 'تُعرض قوائم Pokidoki والإعدادات ورسائل النظام باللغة $name.';
  }

  @override
  String get settingsAppLanguage => 'لغة التطبيق';

  @override
  String get settingsLeftToRight => 'من اليسار إلى اليمين';

  @override
  String get settingsRightToLeft => 'من اليمين إلى اليسار';

  @override
  String get settingsLanguageMessagesNote => 'تغيير اللغة لا يترجم الرسائل';

  @override
  String get settingsStorageError => 'تعذّر حساب استخدام التخزين.';

  @override
  String get settingsStorageUsedOnDevice => 'يستخدمه Pokidoki على هذا الجهاز';

  @override
  String settingsStorageSummarySemantic(String total) {
    return 'إجمالي التخزين المستخدم: $total';
  }

  @override
  String get settingsCategories => 'الفئات';

  @override
  String get settingsStorageMedia => 'الصور ومقاطع الفيديو';

  @override
  String get settingsStorageFiles => 'الملفات';

  @override
  String get settingsStorageVoice => 'الرسائل الصوتية';

  @override
  String get settingsStorageCache => 'الذاكرة المؤقتة';

  @override
  String get settingsStorageOther => 'بيانات محلية أخرى';

  @override
  String get settingsClear => 'مسح';

  @override
  String get settingsClearCache => 'مسح الذاكرة المؤقتة';

  @override
  String get settingsClearCacheSubtitle => 'إزالة البيانات المؤقتة بأمان';

  @override
  String get settingsClearCacheTitle => 'مسح الملفات المؤقتة؟';

  @override
  String get settingsClearCacheBody =>
      'يمكن استرجاع الوسائط التي تم تنزيلها عند الحاجة.';

  @override
  String get settingsClearCacheAction => 'مسح الذاكرة المؤقتة';

  @override
  String get settingsCacheCleared => 'تم مسح الذاكرة المؤقتة.';

  @override
  String get accountChangePassword => 'تغيير كلمة المرور';

  @override
  String get accountProtectAccount => 'احمِ حساب Pokidoki الخاص بك';

  @override
  String get accountCurrentPassword => 'كلمة المرور الحالية';

  @override
  String get accountForgotCurrentPassword => 'هل نسيت كلمة المرور الحالية؟';

  @override
  String get accountNewPassword => 'كلمة المرور الجديدة';

  @override
  String get accountConfirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get accountPasswordRequirements => 'المتطلبات:';

  @override
  String get accountPasswordMinLength => '12 حرفًا على الأقل';

  @override
  String get accountPasswordUpperLower => 'أحرف كبيرة وصغيرة';

  @override
  String get accountPasswordNumber => 'رقم واحد على الأقل';

  @override
  String get accountPasswordSymbol => 'رمز واحد على الأقل (!@#\$%^&*)';

  @override
  String get accountPasswordDifferent => 'مختلفة عن كلمة المرور الحالية';

  @override
  String get accountPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get accountSignOutOtherDevices => 'تسجيل الخروج من الأجهزة الأخرى';

  @override
  String get accountSignOutOtherDevicesRecommended => 'موصى به للأمان';

  @override
  String get accountPasswordPinDifferent =>
      'كلمة المرور ورمز PIN للتطبيق مختلفان';

  @override
  String get accountUpdatePassword => 'تحديث كلمة المرور';

  @override
  String get accountPasswordUpdated => 'تم تحديث كلمة المرور.';

  @override
  String get accountPasswordUpdateFailed =>
      'تعذّر تحديث كلمة المرور. تحقق من كلمة المرور الحالية وحاول مرة أخرى.';

  @override
  String get accountSecurityGenericError =>
      'تعذّر إكمال هذا الإجراء. يبقى حسابك دون تغيير.';

  @override
  String get accountShowPassword => 'إظهار كلمة المرور';

  @override
  String get accountHidePassword => 'إخفاء كلمة المرور';

  @override
  String get accountEmailTitle => 'البريد الإلكتروني';

  @override
  String get accountEmailVerifiedTitle => 'تم التحقق من بريدك الإلكتروني';

  @override
  String get accountEmailRecoveryHelp =>
      'يمكن استخدام هذا البريد لاستعادة الحساب وتنبيهات الأمان المهمة.';

  @override
  String accountVerifiedOn(String date) {
    return 'تم التحقق في $date';
  }

  @override
  String get accountEmailSection => 'بريد الحساب';

  @override
  String get accountLastVerified => 'آخر تحقق';

  @override
  String get accountRecoveryAvailable => 'متاح';

  @override
  String get accountChangeEmail => 'تغيير عنوان البريد الإلكتروني';

  @override
  String get accountChangeEmailSubtitle =>
      'استبدل البريد الموثّق المرتبط بهذا الحساب';

  @override
  String get accountSecurityEmails => 'رسائل الأمان';

  @override
  String get accountSecurityAlerts => 'تنبيهات الأمان';

  @override
  String get accountSecurityAlertsBody =>
      'استلم إشعارات مهمة عن أمان الحساب والجهاز.';

  @override
  String get accountAlwaysOn => 'دائمًا مفعّل';

  @override
  String get accountNewDeviceAlerts => 'تنبيهات الأجهزة الجديدة';

  @override
  String get accountNewDeviceAlertsBody =>
      'استلم بريدًا عند ربط جهاز جديد أو تسجيل الدخول منه.';

  @override
  String get accountRecoveryAlerts => 'تنبيهات الاستعادة';

  @override
  String get accountRecoveryAlertsBody =>
      'استلم بريدًا عند بدء استعادة الحساب.';

  @override
  String get accountOptionalCommunications => 'اتصالات اختيارية';

  @override
  String get accountProductUpdates => 'أخبار ونصائح المنتج';

  @override
  String get accountResearchInvitations => 'دعوات البحث';

  @override
  String get accountEmailNotPublic =>
      'يساعد بريدك الموثّق على استعادة حسابك ولا يظهر لجهات الاتصال.';

  @override
  String get accountReauthenticateTitle => 'أكد كلمة المرور';

  @override
  String get accountReauthenticateBody =>
      'أدخل كلمة المرور الحالية لمتابعة تغيير بريدك الإلكتروني.';

  @override
  String get accountEnterNewEmailBody =>
      'أدخل عنوان البريد الإلكتروني الجديد لهذا الحساب.';

  @override
  String get accountEmailInvalid => 'أدخل عنوان بريد إلكتروني صالحًا.';

  @override
  String get accountEmailConflict => 'لا يمكن استخدام هذا البريد لهذا الحساب.';

  @override
  String get accountVerifyEmailTitle => 'تحقق من بريدك الإلكتروني';

  @override
  String accountVerifyEmailBody(String email) {
    return 'أدخل الرمز المكوّن من ستة أرقام المرسل إلى $email.';
  }

  @override
  String get accountVerificationCode => 'رمز التحقق';

  @override
  String get accountVerifyAction => 'تحقق';

  @override
  String get accountCodeInvalid => 'رمز التحقق غير صحيح أو منتهٍ.';

  @override
  String get accountEmailUpdated => 'تم تحديث عنوان بريدك الإلكتروني.';

  @override
  String get accountRecoveryTitle => 'استعادة الحساب';

  @override
  String get accountRecoveryAvailableTitle => 'استعادة الحساب متاحة';

  @override
  String get accountRecoveryMethod => 'طريقة الاستعادة';

  @override
  String get accountVerifiedEmail => 'بريد موثّق';

  @override
  String get accountThisPhone => 'هذا الهاتف';

  @override
  String get accountRecognized => 'معروف';

  @override
  String get accountWhatHappensNext => 'ما الذي يحدث بعد ذلك';

  @override
  String get accountRecoveryStep1 => 'استلام رمز تحقق';

  @override
  String get accountRecoveryStep1Body => 'يُرسل إلى بريدك الموثّق.';

  @override
  String get accountRecoveryStep2 => 'تأكيد هذا الجهاز';

  @override
  String get accountRecoveryStep2Body => 'تحقق من أنك تستخدم جهازًا معروفًا.';

  @override
  String get accountRecoveryStep3 => 'إنشاء كلمة مرور جديدة';

  @override
  String get accountRecoveryStep3Body => 'اختر كلمة مرور قوية للحساب.';

  @override
  String get accountRecoveryStep4 => 'مراجعة أمان الحساب';

  @override
  String get accountRecoveryStep4Body =>
      'راجع الأجهزة المرتبطة والنشاط الأخير.';

  @override
  String get accountLocalDataWarning =>
      'قد تكون بعض البيانات المحلية المحمية غير متاحة. تؤكد الاستعادة ملكية الحساب ولا تنشئ بابًا خلفيًا للمحادثات المشفّرة.';

  @override
  String get accountStartRecoveryTitle => 'بدء استعادة الحساب؟';

  @override
  String accountStartRecoveryBody(String email) {
    return 'سيتم إرسال رمز تحقق إلى $email.';
  }

  @override
  String get accountStartRecoveryAction => 'بدء الاستعادة';

  @override
  String get accountCancelRecovery => 'إلغاء الاستعادة';

  @override
  String get accountCannotAccessEmail => 'لا يمكنني الوصول إلى هذا البريد';

  @override
  String get accountSupportNeverasks =>
      'لن يطلب الدعم أبدًا كلمة المرور أو رمز PIN أو رمز التحقق.';

  @override
  String get accountRecoveryCodeInvalid => 'رمز التحقق غير صحيح أو منتهٍ.';

  @override
  String get accountCreateNewPassword => 'إنشاء كلمة مرور جديدة';

  @override
  String get accountRestoreAccess => 'استعادة الوصول';

  @override
  String get accountRecoveryCompleted => 'تمت استعادة الوصول إلى الحساب.';

  @override
  String get accountRecoveryCompletedBody =>
      'يمكنك متابعة استخدام Pokidoki بكلمة المرور الجديدة. لم يتغير رمز PIN للتطبيق.';

  @override
  String get reportUserTitle => 'الإبلاغ عن مستخدم';

  @override
  String get reportBlockedBadge => 'محظور';

  @override
  String get reportHelpReview =>
      'تساعد البلاغات Pokidoki على مراجعة إساءة الاستخدام المحتملة';

  @override
  String get reportWhyTitle => 'لماذا تُبلغ عن هذا الحساب؟';

  @override
  String get reportReasonSpam => 'رسائل غير مرغوب فيها';

  @override
  String get reportReasonHarassment => 'مضايقة';

  @override
  String get reportReasonImpersonation => 'انتحال شخصية';

  @override
  String get reportReasonThreats => 'تهديدات أو عنف';

  @override
  String get reportReasonInappropriate => 'محتوى جنسي أو غير لائق';

  @override
  String get reportReasonScam => 'احتيال أو نصب';

  @override
  String get reportReasonOther => 'أخرى';

  @override
  String get reportAdditionalDetails => 'تفاصيل إضافية (اختياري)';

  @override
  String get reportDetailsHelper =>
      'لا تُدخل كلمات المرور أو رموز PIN أو رموز التحقق أو المفاتيح الخاصة.';

  @override
  String get reportEvidence => 'الأدلة';

  @override
  String get reportIncludeEvidence => 'تضمين أدلة محادثة محددة';

  @override
  String get reportEvidenceDefaultOff =>
      'لا يُضمَّن شيء افتراضيًا. اختر رسائل من المحادثة لتضمينها كأدلة.';

  @override
  String reportSelectedEvidenceCount(int count) {
    return '$count محددة';
  }

  @override
  String get reportSelectEvidence => 'اختر الأدلة';

  @override
  String get reportNotBlocking =>
      'الإبلاغ ليس حظرًا. الإبلاغ يرسل معلومات للمراجعة. الحظر يمنع طلبات الاتصال أو الرسائل الجديدة.';

  @override
  String get reportWhatWillBeSent => 'ما الذي سيُرسل';

  @override
  String get reportAccountIdentifier => 'معرّف الحساب';

  @override
  String get reportReasonLabel => 'السبب';

  @override
  String get reportDetailsLabel => 'التفاصيل';

  @override
  String get reportNotSelected => 'غير محدد';

  @override
  String get reportNone => 'لا شيء';

  @override
  String get reportDetailsIncluded => 'مضمّنة';

  @override
  String get reportNotIncluded => 'غير مضمّنة';

  @override
  String get reportReviewData => 'راجع بيانات البلاغ';

  @override
  String get reportSubmitTitle => 'إرسال هذا البلاغ؟';

  @override
  String get reportSubmitBody =>
      'سيتلقى Pokidoki السبب المحدد وتفاصيلك الاختيارية والأدلة التي راجعتها فقط.';

  @override
  String reportRemainsBlocked(String name) {
    return 'سيبقى $name محظورًا.';
  }

  @override
  String get reportSubmitAction => 'إرسال البلاغ';

  @override
  String get reportSubmitted => 'تم إرسال البلاغ.';

  @override
  String get reportSubmitFailed => 'لم يُرسل بلاغك.';

  @override
  String get reportNotEmergency => 'بلاغات Pokidoki ليست خدمة طوارئ.';

  @override
  String get contactsSelfNotAllowed => 'لا يمكنك إرسال طلب اتصال إلى نفسك.';

  @override
  String get contactsAlreadyPending => 'يوجد بالفعل طلب اتصال قيد الانتظار.';

  @override
  String get contactsReversePending =>
      'أرسل لك هذا الشخص طلبًا بالفعل. اقبله من طلبات الاتصال.';

  @override
  String get contactsRequestNotFound => 'طلب الاتصال هذا لم يعد متاحًا.';

  @override
  String get contactsRequestNotPending =>
      'طلب الاتصال هذا لم يعد قيد الانتظار.';

  @override
  String get contactsRequestForbidden =>
      'لا يمكنك تنفيذ هذا الإجراء على هذا الطلب.';

  @override
  String get contactsAlreadyExists => 'أنت متصل بالفعل بهذا الشخص.';

  @override
  String get contactsNotFound => 'جهة الاتصال هذه لم تعد متاحة.';

  @override
  String get contactsUserUnavailable => 'هذا المستخدم غير متاح.';

  @override
  String get contactsAlreadyBlocked => 'هذا المستخدم محظور بالفعل.';

  @override
  String get contactsNotBlocked => 'هذا المستخدم غير محظور.';

  @override
  String get contactsRelationshipUnavailable => 'معلومات العلاقة غير متاحة.';
}
