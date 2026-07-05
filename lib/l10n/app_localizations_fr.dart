// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Pokidoki';

  @override
  String get splashTagline => 'Des conversations privées, protégées.';

  @override
  String get splashPreparing => 'Sécurisation de votre espace';

  @override
  String get splashLoadingSemantic => 'Pokidoki démarre';

  @override
  String get splashReadySemantic => 'Pokidoki est prêt';

  @override
  String get actionContinue => 'Continuer';

  @override
  String get actionContinueUpper => 'CONTINUER';

  @override
  String get actionGetStarted => 'COMMENCER';

  @override
  String get actionSkip => 'Passer';

  @override
  String get actionRetry => 'Réessayer';

  @override
  String get actionCreateAccount => 'CRÉER UN COMPTE';

  @override
  String get actionSignIn => 'Se connecter';

  @override
  String onboardingPageSemantic(int current, int total) {
    return 'Page d’accueil $current sur $total';
  }

  @override
  String get onboarding1Title => 'Vos conversations restent privées';

  @override
  String get onboarding1Body =>
      'Les messages sont protégés sur votre appareil et ne peuvent être lus que par les participants à la conversation.';

  @override
  String get onboarding1IllustrationSemantic =>
      'Illustration d’une conversation privée entre deux personnes';

  @override
  String get onboarding2Title => 'Sachez à qui vous parlez';

  @override
  String get onboarding2Body =>
      'Vérifiez les contacts de confiance à l’aide d’un code QR ou d’un numéro de sécurité avant de partager des informations sensibles.';

  @override
  String get onboarding2IllustrationSemantic =>
      'Illustration de la vérification d’un contact avec un code QR et une coche';

  @override
  String get onboarding3Title => 'Votre espace privé reste verrouillé';

  @override
  String get onboarding3Body =>
      'Protégez Pokidoki avec un code PIN et les données biométriques de votre appareil, pour que vous seul puissiez accéder à vos conversations.';

  @override
  String get onboarding3IllustrationSemantic =>
      'Illustration du verrouillage de l’application avec PIN et biométrie';

  @override
  String get welcomeTitle => 'Bienvenue dans votre espace privé';

  @override
  String get welcomeBody =>
      'Connectez-vous aux personnes de confiance et gardez vos conversations protégées.';

  @override
  String get welcomeFeaturePrivate => 'Conversations privées';

  @override
  String get welcomeFeatureVerification => 'Vérification des contacts';

  @override
  String get welcomeFeatureAppLock => 'Protection par verrouillage';

  @override
  String get welcomeTermsPrefix => 'En continuant, vous acceptez les ';

  @override
  String get welcomeTermsOfService => 'Conditions d’utilisation';

  @override
  String get welcomeTermsMiddle => ' et la ';

  @override
  String get welcomePrivacyPolicy => 'Politique de confidentialité';

  @override
  String get welcomeTermsSuffix => '.';

  @override
  String get welcomePrivacyNote =>
      'Pokidoki ne peut pas lire vos messages privés.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageFrench => 'Français';

  @override
  String languageSelectorSemantic(String language) {
    return 'Langue, actuellement $language';
  }

  @override
  String get devPlaceholderTitle => 'Écran pas encore implémenté';

  @override
  String get devPlaceholderBody =>
      'Cette destination est réservée à un prochain lot d’implémentation.';

  @override
  String get devPlaceholderBadge => 'Écran de développement temporaire';

  @override
  String get devScreenCreateAccount =>
      'L’écran Créer un compte n’est pas encore implémenté.';

  @override
  String get devScreenSignIn =>
      'L’écran Se connecter n’est pas encore implémenté.';

  @override
  String get devConversationsHome =>
      'L’accueil des discussions sera implémenté dans un prochain lot.';

  @override
  String get devAccountRecovery =>
      'La récupération de compte sera implémentée dans le prochain lot.';

  @override
  String get devAccountRecoveryNextBatch =>
      'La récupération de compte sera implémentée dans le prochain lot.';

  @override
  String get devPinRecovery =>
      'La récupération du code PIN sera implémentée dans un prochain lot.';

  @override
  String get devSettings =>
      'Les réglages seront implémentés dans un prochain lot.';

  @override
  String get devOneToOneChat =>
      'La discussion individuelle sera implémentée dans un prochain lot.';

  @override
  String get devQrScanner =>
      'Le scanner QR sera implémenté dans un prochain lot.';

  @override
  String get devReportUser =>
      'Le signalement d’utilisateur sera implémenté dans le prochain lot.';

  @override
  String get devChangePassword =>
      'Le changement de mot de passe sera implémenté dans le prochain lot.';

  @override
  String get devEmailManagement =>
      'La gestion de l’e-mail sera implémentée dans le prochain lot.';

  @override
  String get actionTryAgain => 'Réessayer';

  @override
  String get routeNotFoundTitle => 'Page introuvable';

  @override
  String get routeNotFoundBody =>
      'Ce lien n’est pas disponible dans l’application.';

  @override
  String get routeNotFoundAction => 'Aller à l’accueil';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get chatsYouPrefix => 'Vous : ';

  @override
  String get chatsYesterday => 'Hier';

  @override
  String chatsUnreadCount(int count) {
    return '$count messages non lus';
  }

  @override
  String get chatsSearchHint => 'Rechercher des discussions';

  @override
  String get chatsProtectedBanner =>
      'Vos conversations sont protégées par un chiffrement de bout en bout.';

  @override
  String get chatsPinned => 'Épinglées';

  @override
  String get chatsRecent => 'Récentes';

  @override
  String get chatsRecentContacts => 'Contacts récents';

  @override
  String get chatsNewConversation => 'Nouvelle conversation';

  @override
  String get chatsEmptyTitle => 'Aucune conversation pour le moment';

  @override
  String get chatsEmptyBody =>
      'Démarrez une conversation privée avec l’un de vos contacts.';

  @override
  String get contactsSearchHint => 'Rechercher des contacts';

  @override
  String get contactsRequestsTitle => 'Demandes de contact';

  @override
  String contactsRequestsWaiting(int count) {
    return '$count demandes attendent votre examen.';
  }

  @override
  String get contactsVerifiedSection => 'Contacts vérifiés';

  @override
  String get contactsAllContacts => 'Tous les contacts';

  @override
  String get contactsEmptyTitle => 'Aucun contact pour le moment';

  @override
  String get contactsEmptyBody =>
      'Recherchez quelqu’un ou acceptez une demande de contact.';

  @override
  String get contactsReviewRequests => 'Examiner les demandes';

  @override
  String get contactsRequestsInfo =>
      'Accepter une demande ajoute le compte à vos contacts. Cela ne vérifie pas l’identité de la personne. Vérifiez le contact avant de partager des informations sensibles.';

  @override
  String get contactsReceived => 'Reçues';

  @override
  String get contactsSent => 'Envoyées';

  @override
  String get contactsAccept => 'ACCEPTER';

  @override
  String get contactsDecline => 'REFUSER';

  @override
  String get contactsCancelRequest => 'Annuler';

  @override
  String get contactsRequestAccepted => 'Demande de contact acceptée.';

  @override
  String get contactsRequestDeclined => 'Demande de contact refusée.';

  @override
  String get contactsNoReceivedRequests => 'Aucune demande reçue.';

  @override
  String get contactsNoSentRequests => 'Aucune demande envoyée.';

  @override
  String get usersFindSomeone => 'Trouver quelqu’un';

  @override
  String get usersFindPeople => 'Trouver des personnes';

  @override
  String get usersSearchByUsernameOrId =>
      'Rechercher par nom d’utilisateur ou identifiant Pokidoki';

  @override
  String get usersSearchInitial =>
      'Recherchez par nom d’utilisateur ou identifiant Pokidoki.';

  @override
  String get usersNoResultsTitle => 'Aucun utilisateur trouvé';

  @override
  String get usersNoResultsBody =>
      'Essayez un autre nom d’utilisateur ou identifiant Pokidoki.';

  @override
  String get usersScanQr => 'Scanner un code QR';

  @override
  String get usersScanQrSubtitle => 'Ajouter ou vérifier quelqu’un à proximité';

  @override
  String get usersNewGroup => 'Nouveau groupe';

  @override
  String get usersNewGroupSubtitle => 'Créer une conversation privée...';

  @override
  String get usersComingLater => 'Bientôt';

  @override
  String get usersProfileTitle => 'Profil';

  @override
  String get usersSendRequest => 'Envoyer une demande de contact';

  @override
  String get usersRequestSent => 'Demande de contact envoyée.';

  @override
  String get usersRequestPending => 'Demande envoyée';

  @override
  String get usersMessage => 'Message';

  @override
  String get usersNotInContacts => 'Pas dans vos contacts';

  @override
  String get usersInContacts => 'Dans vos contacts';

  @override
  String get usersNotVerified => 'Non vérifié';

  @override
  String get usersVerifyBeforeSensitive =>
      'Vérifiez cette personne avant de partager des informations sensibles.';

  @override
  String get usersAbout => 'À propos';

  @override
  String get usersSharedContext => 'Contexte partagé';

  @override
  String get usersCopyId => 'Copier l’identifiant Pokidoki';

  @override
  String get usersBlockAction => 'Bloquer';

  @override
  String get usersReportAction => 'Signaler';

  @override
  String usersBlockTitle(String name) {
    return 'Bloquer $name ?';
  }

  @override
  String usersBlockBody(String name) {
    return '$name ne pourra plus vous envoyer de nouvelles demandes de contact ni de messages.';
  }

  @override
  String get usersBlocked => 'Utilisateur bloqué.';

  @override
  String get qrScanTitle => 'Scanner le code QR';

  @override
  String get qrScanHeading => 'Scannez un code QR Pokidoki';

  @override
  String get qrScanBody =>
      'Placez le code dans le cadre pour ajouter ou vérifier quelqu’un';

  @override
  String get qrLookingForCode => 'Recherche d’un code Pokidoki...';

  @override
  String get qrFrameSemantic => 'Cadre de scan QR';

  @override
  String get qrSimulateScan => 'Simuler le scan';

  @override
  String get qrInvalidCode =>
      'Ce code QR n’est pas un code de contact Pokidoki valide.';

  @override
  String get qrFlash => 'Flash';

  @override
  String get qrGallery => 'Galerie';

  @override
  String get qrMyCodeAction => 'Mon code QR';

  @override
  String get qrMyCodeTitle => 'Mon code QR Pokidoki';

  @override
  String get qrHelp => 'Aide';

  @override
  String get qrBrightness => 'Luminosité';

  @override
  String get qrCodeSemantic => 'Votre code QR de contact Pokidoki';

  @override
  String get qrPublicIdentity => 'Votre identité publique Pokidoki';

  @override
  String get qrPublicIdHelp =>
      'Les personnes peuvent utiliser cet identifiant pour trouver votre compte.';

  @override
  String get qrShareExplanation =>
      'Votre code QR Pokidoki aide les personnes à trouver ou vérifier votre compte sans saisir votre nom d’utilisateur ou identifiant.';

  @override
  String get qrShareAction => 'Partager';

  @override
  String get qrShareReady =>
      'Votre code de contact Pokidoki est prêt à être partagé.';

  @override
  String get qrRefreshAction => 'Actualiser';

  @override
  String get qrRefreshTitle => 'Créer un nouveau code QR ?';

  @override
  String get qrRefreshBody =>
      'L’ancien code de contact ne sera plus utilisé pour les nouveaux scans.';

  @override
  String get verifyContactTitle => 'Vérifier le contact';

  @override
  String get verifyNotVerified => 'Non vérifié';

  @override
  String get verifyQrRecognized => 'Code QR reconnu';

  @override
  String verifyQrRecognizedBody(String name) {
    return 'Ce code appartient au profil Pokidoki de $name.';
  }

  @override
  String get verifyConfirmInPerson =>
      'Confirmez que vous parlez à la bonne personne';

  @override
  String get verifyScanQrMethod => 'Scanner le code QR';

  @override
  String get verifyScanQrMethodBody => 'Recommandé lorsque vous êtes ensemble';

  @override
  String get verifyCompareSafetyNumber => 'Comparer le numéro de sécurité';

  @override
  String get verifyCompareSafetyNumberBody =>
      'Utile lorsque vous n’êtes pas au même endroit';

  @override
  String get verifyWhatItConfirms => 'Ce que confirme la vérification';

  @override
  String get verifyBulletSameIdentity =>
      'Vous comparez la même identité de contact';

  @override
  String get verifyBulletNotReplaced =>
      'L’identité de sécurité du contact n’a pas été remplacée de façon inattendue';

  @override
  String get verifyBulletMarkedOnDevice =>
      'Pokidoki peut marquer ce contact comme vérifié sur votre appareil';

  @override
  String verifyMarkTitle(String name) {
    return 'Vérifier $name ?';
  }

  @override
  String verifyMarkBody(String name) {
    return 'Continuez uniquement si vous avez confirmé ce profil avec $name en personne ou via un autre canal de confiance.';
  }

  @override
  String get verifyMarkAction => 'Marquer comme vérifié';

  @override
  String get verifySafetyConfirmed => 'Numéro de sécurité confirmé.';

  @override
  String get verifyResetTitle => 'Réinitialiser la vérification ?';

  @override
  String verifyResetBody(String name) {
    return '$name apparaîtra comme non vérifié jusqu’à ce que vous compariez à nouveau l’identité.';
  }

  @override
  String get verifyResetAction => 'Réinitialiser';

  @override
  String get safetyNumberTitle => 'Numéro de sécurité';

  @override
  String safetyCompareHeading(String name) {
    return 'Comparez ce numéro avec $name';
  }

  @override
  String get safetyCompareBody =>
      'Les deux appareils doivent afficher le même numéro de sécurité. Comparez-le en personne ou via un autre moyen de communication déjà fiable.';

  @override
  String get safetyNumberSemantic =>
      'Groupes de chiffres du numéro de sécurité';

  @override
  String get safetyNumberCopied => 'Numéro de sécurité copié.';

  @override
  String get safetyDoNotCompareOnlyInChat =>
      'Ne comparez pas ce numéro uniquement dans la conversation que vous vérifiez.';

  @override
  String get chatTypeMessage => 'Écrire un message';

  @override
  String get chatSend => 'Envoyer';

  @override
  String get chatAttach => 'Pièce jointe';

  @override
  String get chatReply => 'Répondre';

  @override
  String get chatCopy => 'Copier';

  @override
  String get chatDelete => 'Supprimer';

  @override
  String get chatDeleteForMe => 'Supprimer pour moi';

  @override
  String get chatDeleteTitle => 'Supprimer ce message ?';

  @override
  String get chatDeleteBody => 'Cela retire le message de cet appareil.';

  @override
  String get chatMessageInfo => 'Infos du message';

  @override
  String get chatMessageCopied => 'Message copié.';

  @override
  String get chatSearchInConversation => 'Rechercher';

  @override
  String get chatConversationInfo => 'Infos de la conversation';

  @override
  String get chatProtectedBanner =>
      'Les messages de cette conversation sont protégés par un chiffrement de bout en bout.';

  @override
  String get chatToday => 'Aujourd’hui';

  @override
  String get chatAttachmentLater =>
      'La sélection de pièces jointes sera connectée plus tard.';

  @override
  String chatBlockedNotice(String name) {
    return 'Vous avez bloqué $name.';
  }

  @override
  String get chatSent => 'Envoyé';

  @override
  String get chatDelivered => 'Distribué';

  @override
  String get chatRead => 'Lu';

  @override
  String get chatMuteNotifications => 'Notifications';

  @override
  String get chatDisappearingMessages => 'Messages éphémères';

  @override
  String get chatDisappearingOff => 'Désactivé';

  @override
  String get chatDisappearingOffHelp =>
      'Les messages restent jusqu’à suppression';

  @override
  String get chatDisappearingOneHour => '1 heure';

  @override
  String get chatDisappearingOneHourHelp => 'Discussion temporaire standard';

  @override
  String get chatDisappearingOneDay => '1 jour';

  @override
  String get chatDisappearingOneDayHelp =>
      'Réglage de confidentialité par défaut';

  @override
  String get chatDisappearingOneWeek => '1 semaine';

  @override
  String get chatDisappearingOneWeekHelp =>
      'Historique de conversation prolongé';

  @override
  String get chatDisappearingAppliesFuture =>
      'Le nouveau minuteur s’applique aux messages futurs. Les messages précédents conservent leur minuteur d’origine.';

  @override
  String get chatDisappearingScreenshotWarning =>
      'La disparition n’empêche pas la copie. Les destinataires peuvent encore capturer l’écran, copier le texte ou transférer les messages avant leur disparition.';

  @override
  String get chatSharedContent => 'Contenu partagé';

  @override
  String chatSharedWith(String name) {
    return 'Partagé avec $name';
  }

  @override
  String get chatPhotosAndVideos => 'Photos et vidéos';

  @override
  String get chatFiles => 'Fichiers';

  @override
  String get chatLinks => 'Liens';

  @override
  String get chatMedia => 'Médias';

  @override
  String get chatNoMedia => 'Aucun média pour le moment';

  @override
  String get chatNoFiles => 'Aucun fichier pour le moment';

  @override
  String get chatNoLinks => 'Aucun lien pour le moment';

  @override
  String get chatFilePreviewLater =>
      'L’aperçu des fichiers sera connecté plus tard.';

  @override
  String get chatSearchHint => 'Rechercher des messages';

  @override
  String get chatSearchInitial =>
      'Recherchez des messages dans cette conversation.';

  @override
  String chatSearchResultCount(int count) {
    return '$count résultats';
  }

  @override
  String get chatNoMessagesFound => 'Aucun message trouvé';

  @override
  String get chatNoMessagesFoundBody =>
      'Essayez un autre mot ou une autre expression.';

  @override
  String get chatDeleteConversation => 'Supprimer la conversation';

  @override
  String get chatDeleteConversationTitle => 'Supprimer cette conversation ?';

  @override
  String get chatDeleteConversationBody =>
      'Cela retire l’historique local de conversation de cet appareil.';

  @override
  String get authCreateAccountTitle => 'Créer un compte';

  @override
  String get authCreateAccountHeading => 'Créez votre compte privé';

  @override
  String get authCreateAccountBody =>
      'Configurez votre compte Pokidoki pour commencer à vous connecter aux personnes de confiance.';

  @override
  String get authCreateAccountAction => 'Créer un compte';

  @override
  String get authCreateAccountLink => 'Créer un compte';

  @override
  String get authEmailLabel => 'Adresse e-mail';

  @override
  String get authEmailOrUsernameLabel => 'E-mail ou nom d’utilisateur';

  @override
  String get authPasswordLabel => 'Mot de passe';

  @override
  String get authConfirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get authPasswordRequirements => 'Votre mot de passe doit inclure :';

  @override
  String get authPasswordMinLength => 'Au moins 12 caractères';

  @override
  String get authPasswordUppercase => 'Une lettre majuscule';

  @override
  String get authPasswordLowercase => 'Une lettre minuscule';

  @override
  String get authPasswordNumber => 'Un chiffre';

  @override
  String get authPasswordSymbol => 'Un symbole';

  @override
  String get authAgreePrefix => 'J’accepte les ';

  @override
  String get authPasswordPrivacyNote =>
      'Votre mot de passe protège votre compte. Vos clés de messages privés restent sur votre appareil.';

  @override
  String get authAlreadyHaveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get authInvalidEmail => 'Saisissez une adresse e-mail valide.';

  @override
  String get authPasswordMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get authGenericError => 'Une erreur s’est produite. Réessayez.';

  @override
  String get authEmailUnavailable =>
      'Cette adresse e-mail ne peut pas être utilisée. Essayez-en une autre.';

  @override
  String get authInvalidCredentials =>
      'Connexion impossible. Vérifiez vos informations et réessayez.';

  @override
  String get authEmailNotVerified =>
      'Vérifiez votre e-mail avant de vous connecter.';

  @override
  String get authAccountSuspended =>
      'Ce compte est temporairement indisponible.';

  @override
  String get authAccountDisabled => 'Ce compte est désactivé.';

  @override
  String get authVerificationInvalid => 'Ce code n’est pas valide. Réessayez.';

  @override
  String get authVerificationExpired =>
      'Ce code a expiré. Demandez-en un nouveau.';

  @override
  String get authVerificationAttemptsExceeded =>
      'Trop de tentatives. Demandez un nouveau code.';

  @override
  String get authVerificationResendTooSoon =>
      'Veuillez patienter avant de demander un autre code.';

  @override
  String get authSessionExpired => 'Votre session a expiré. Reconnectez-vous.';

  @override
  String get authRateLimited => 'Trop de tentatives. Patientez puis réessayez.';

  @override
  String get authNoInternet =>
      'Pas de connexion Internet. Vérifiez votre réseau et réessayez.';

  @override
  String get authRequestTimedOut => 'La requête a expiré. Réessayez.';

  @override
  String get authServerUnavailable =>
      'Le serveur est indisponible. Réessayez plus tard.';

  @override
  String get authUnexpectedError => 'Une erreur s’est produite. Réessayez.';

  @override
  String get authSignedOut => 'Vous avez été déconnecté.';

  @override
  String get authSignInTitle => 'Se connecter';

  @override
  String get authSignInHeading => 'Bon retour';

  @override
  String get authSignInBody =>
      'Connectez-vous pour accéder à vos conversations privées.';

  @override
  String get authSignInAction => 'SE CONNECTER';

  @override
  String get authRememberDevice => 'Se souvenir de cet appareil';

  @override
  String get authForgotPassword => 'Mot de passe oublié ?';

  @override
  String get authOrContinueSecurely => 'Ou continuer en toute sécurité';

  @override
  String get authUseFingerprint => 'Utiliser l’empreinte';

  @override
  String get authFingerprintAfterSignIn =>
      'Le déverrouillage par empreinte est disponible après la connexion.';

  @override
  String get authNewToPokidoki => 'Nouveau sur Pokidoki ? ';

  @override
  String get authSignInError =>
      'Impossible de vous connecter. Vérifiez vos informations et réessayez.';

  @override
  String get authInvalidCredentialsForm =>
      'Saisissez votre e-mail ou nom d’utilisateur et votre mot de passe.';

  @override
  String get authVerifyEmailTitle => 'Vérifier l’e-mail';

  @override
  String get authCheckYourEmail => 'Vérifiez votre e-mail';

  @override
  String get authVerificationBody =>
      'Saisissez le code de vérification à six chiffres envoyé à votre adresse e-mail.';

  @override
  String get authVerificationCodeSemantic => 'Code de vérification';

  @override
  String get authVerifyEmailAction => 'VÉRIFIER L’E-MAIL';

  @override
  String get authResendCode => 'Renvoyer le code';

  @override
  String get authResendReady => 'Vous pouvez renvoyer un code maintenant.';

  @override
  String authResendCountdown(String seconds) {
    return 'Renvoi disponible dans 00:$seconds';
  }

  @override
  String get authChangeEmail => 'Modifier l’e-mail';

  @override
  String get authCodeResent => 'Un nouveau code de vérification a été envoyé.';

  @override
  String get authVerificationError => 'Ce code n’est pas valide. Réessayez.';

  @override
  String get authProfileStep1 => 'Profil · Étape 1 sur 2';

  @override
  String get authProfileStep2 => 'Profil · Étape 2 sur 2';

  @override
  String get authUsernameHeading => 'Créez votre nom d’utilisateur Pokidoki';

  @override
  String get authUsernameBody =>
      'Les personnes peuvent utiliser votre nom d’utilisateur pour vous trouver et envoyer une demande de contact.';

  @override
  String authUsernameAvailable(String username) {
    return '@$username est disponible';
  }

  @override
  String get authUsernameUnavailable =>
      'Ce nom d’utilisateur n’est pas disponible.';

  @override
  String get authUsernameRequirements => 'Exigences du nom d’utilisateur';

  @override
  String get authUsernameLength => '3 à 24 caractères';

  @override
  String get authUsernameCharset =>
      'Lettres minuscules, chiffres, points et underscores';

  @override
  String get authUsernameStartsWithLetter => 'Doit commencer par une lettre';

  @override
  String get authUsernameNoSpaces => 'Sans espaces';

  @override
  String get authUsernameUnique => 'Doit être unique';

  @override
  String get authCreateProfileTitle => 'Créer un profil';

  @override
  String get authProfileHeading => 'Personnalisez Pokidoki';

  @override
  String get authProfileBody =>
      'Ajoutez le nom et la photo que vos contacts de confiance reconnaîtront.';

  @override
  String get authDisplayNameLabel => 'Nom affiché';

  @override
  String get authAboutYouLabel => 'À propos de vous (facultatif)';

  @override
  String get authSkipOptionalDetails => 'Ignorer les détails facultatifs';

  @override
  String get authChoosePhoto => 'Choisir une photo';

  @override
  String get authTakePhoto => 'Prendre une photo';

  @override
  String get authRemovePhoto => 'Supprimer la photo';

  @override
  String get authCreatePinTitle => 'Créer un code PIN';

  @override
  String get authCreatePinHeading => 'Créez un code PIN d’application';

  @override
  String get authCreatePinBody =>
      'Choisissez un code PIN à six chiffres pour protéger l’accès à Pokidoki sur cet appareil.';

  @override
  String get authPinDifferentFromPassword =>
      'Ce code PIN est différent de votre mot de passe de compte.';

  @override
  String get authPinLocalProtectionNote =>
      'Votre code PIN protège l’accès local. Ce n’est pas votre clé de chiffrement des messages.';

  @override
  String authPinDigitsEntered(int count) {
    return '$count chiffres sur 6 saisis';
  }

  @override
  String get authConfirmPinTitle => 'Confirmer le code PIN';

  @override
  String get authConfirmPinHeading => 'Confirmez votre code PIN';

  @override
  String get authConfirmPinBody =>
      'Saisissez à nouveau le même code PIN à six chiffres pour vous assurer de le mémoriser.';

  @override
  String get authConfirmPinAction => 'Confirmer le code PIN';

  @override
  String get authChooseDifferentPin => 'Choisir un autre code PIN';

  @override
  String get authEnterAllSixDigits =>
      'Saisissez les six chiffres pour continuer';

  @override
  String get authPinMismatch =>
      'Les codes PIN ne correspondent pas. Réessayez.';

  @override
  String get authBiometricsHeading => 'Déverrouillez Pokidoki plus rapidement';

  @override
  String get authBiometricsBody =>
      'Votre code PIN restera disponible comme solution de secours.';

  @override
  String get authBiometricsFasterTitle => 'Accès plus rapide';

  @override
  String get authBiometricsFasterBody =>
      'Ouvrez Pokidoki sans saisir votre code PIN à chaque fois.';

  @override
  String get authBiometricsDeviceTitle => 'Protégé par votre appareil';

  @override
  String get authBiometricsDeviceBody =>
      'L’authentification est gérée par le système de sécurité de votre téléphone.';

  @override
  String get authBiometricsPinTitle => 'Le code PIN reste disponible';

  @override
  String get authBiometricsPinBody =>
      'Vous pouvez toujours déverrouiller Pokidoki avec votre code PIN à six chiffres.';

  @override
  String get authBiometricsPrivacyNote =>
      'Vos données biométriques sont gérées par votre appareil et ne sont pas stockées par Pokidoki.';

  @override
  String get authEnableBiometricsAction =>
      'Activer le déverrouillage biométrique';

  @override
  String get authNotNow => 'Pas maintenant';

  @override
  String get authAppLockHeading => 'Pokidoki est verrouillé';

  @override
  String get authAppLockBody =>
      'Saisissez votre code PIN à six chiffres ou utilisez la biométrie pour accéder à vos conversations.';

  @override
  String get authEnterAppPin => 'Saisissez votre code PIN';

  @override
  String get authAppLockError => 'Ce code PIN est incorrect. Réessayez.';

  @override
  String get authForgotPin => 'Code PIN oublié ?';

  @override
  String get authUseBiometrics => 'Utiliser la biométrie';

  @override
  String get authDeleteDigit => 'Supprimer le chiffre';

  @override
  String get authBiometricsUnavailable =>
      'Le déverrouillage biométrique n’est pas activé pour cette session.';

  @override
  String get stateLoading => 'Chargement';

  @override
  String get stateEmpty => 'Rien ici pour le moment';

  @override
  String get stateError => 'Une erreur s’est produite';

  @override
  String get stateOffline => 'Vous semblez hors ligne';

  @override
  String get navChats => 'Discussions';

  @override
  String get navContacts => 'Contacts';

  @override
  String get navSettings => 'Réglages';

  @override
  String get semanticVerified => 'Vérifié';

  @override
  String get semanticClose => 'Fermer';

  @override
  String get semanticBack => 'Retour';

  @override
  String get semanticSearch => 'Rechercher';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsAccount => 'Compte';

  @override
  String get settingsAccountProtected => 'Compte protégé';

  @override
  String get settingsPrivacySecurity => 'Confidentialité et sécurité';

  @override
  String get settingsPreferences => 'Préférences';

  @override
  String get settingsAppLock => 'Verrouillage de l’app';

  @override
  String get settingsAppLockSubtitle => 'Code PIN et biométrie';

  @override
  String get settingsBiometricUnlock => 'Déverrouillage biométrique';

  @override
  String get settingsAutomaticallyLock => 'Verrouillage automatique';

  @override
  String get settingsScreenPrivacy => 'Confidentialité de l’écran';

  @override
  String get settingsScreenPrivacySubtitle =>
      'Masquer le contenu dans le sélecteur d’apps';

  @override
  String get settingsReadReceipts => 'Accusés de lecture';

  @override
  String get settingsTypingIndicators => 'Indicateurs de saisie';

  @override
  String get settingsBlockedUsers => 'Utilisateurs bloqués';

  @override
  String get settingsLinkedDevices => 'Appareils liés';

  @override
  String settingsActiveDevices(int count) {
    return '$count actif(s)';
  }

  @override
  String get settingsSecurityActivity => 'Activité de sécurité';

  @override
  String get settingsSecurityActivitySubtitle =>
      'Examiner les changements importants';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsStorageUsage => 'Utilisation du stockage';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsMessageNotifications => 'Notifications de messages';

  @override
  String get settingsNotificationPreviews => 'Aperçus des notifications';

  @override
  String get settingsNotificationPreviewsSubtitle =>
      'Afficher le texte du message';

  @override
  String get settingsNotificationSound => 'Son de notification';

  @override
  String get settingsNotificationSoundDefault => 'Pokidoki par défaut';

  @override
  String get settingsVibration => 'Vibration';

  @override
  String get settingsHelpInformation => 'Aide et informations';

  @override
  String get settingsHelpCenter => 'Centre d’aide';

  @override
  String get settingsHelpPlaceholder =>
      'Le contenu d’aide sera disponible dans une version ultérieure.';

  @override
  String get settingsPokidokiVersion => 'Version de Pokidoki';

  @override
  String get settingsSignOutTitle => 'Se déconnecter de Pokidoki ?';

  @override
  String get settingsSignOutBody =>
      'Vous devrez vous reconnecter pour accéder à ce compte.';

  @override
  String get settingsSignOutAction => 'Se déconnecter';

  @override
  String get settingsPublicIdentity => 'Identité publique';

  @override
  String get settingsDisplayName => 'Nom affiché';

  @override
  String get settingsUsername => 'Nom d’utilisateur';

  @override
  String get settingsPokidokiId => 'Identifiant Pokidoki';

  @override
  String get settingsCopyId => 'Copier l’identifiant Pokidoki';

  @override
  String get settingsIdCopied => 'Identifiant Pokidoki copié.';

  @override
  String get settingsSharePublicIdentity =>
      'Partagez votre identité publique Pokidoki';

  @override
  String get settingsPreviewPublicProfile => 'Aperçu du profil public';

  @override
  String get settingsPreviewPublicProfileBody =>
      'Voir ce que les autres utilisateurs Pokidoki peuvent consulter';

  @override
  String get settingsSignInRecovery => 'Connexion et récupération';

  @override
  String get settingsEmailAddress => 'Adresse e-mail';

  @override
  String get settingsVerified => 'Vérifié';

  @override
  String get settingsPassword => 'Mot de passe';

  @override
  String get settingsPasswordChangedAgo => 'Modifié il y a 3 mois';

  @override
  String get settingsAccountRecovery => 'Récupération de compte';

  @override
  String get settingsAccountRecoverySubtitle =>
      'Examiner les options de récupération et de vérification';

  @override
  String get settingsDeleteAccount => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountUnavailable =>
      'La suppression de compte n’est pas disponible dans ce lot d’interface.';

  @override
  String get settingsLinkedDevicesInfo =>
      'Examinez régulièrement cette liste et retirez tout appareil que vous ne reconnaissez pas.';

  @override
  String get settingsLinkedDevicesError =>
      'Impossible de charger les appareils liés.';

  @override
  String get settingsDeviceLinkedRecently => 'Un appareil a été lié récemment';

  @override
  String get settingsDeviceLinkedRecentlyBody =>
      'Examinez l’appareil ci-dessous et retirez-le si vous ne le reconnaissez pas.';

  @override
  String get settingsThisDevice => 'Cet appareil';

  @override
  String get settingsOtherDevices => 'Autres appareils';

  @override
  String get settingsCurrentDevice => 'Actuel';

  @override
  String get settingsNeedsReview => 'À examiner';

  @override
  String get settingsActiveNow => 'Actif maintenant';

  @override
  String get settingsLastActiveRecently => 'Actif récemment';

  @override
  String get settingsNoOtherDevices => 'Aucun autre appareil lié';

  @override
  String get settingsNoOtherDevicesBody =>
      'Seul ce téléphone est actuellement lié à votre compte.';

  @override
  String settingsRemoveDeviceTitle(String name) {
    return 'Retirer $name ?';
  }

  @override
  String get settingsRemoveDeviceBody => 'Cet appareil devra se reconnecter.';

  @override
  String get settingsRemoveDeviceAction => 'Retirer l’appareil';

  @override
  String get settingsDeviceRemoved => 'Appareil retiré.';

  @override
  String get settingsSecurityActivityError =>
      'Impossible de charger l’activité de sécurité.';

  @override
  String get settingsSecurityHistoryTitle =>
      'Historique de sécurité de votre compte';

  @override
  String get settingsSecurityHistoryBody =>
      'Examinez les événements de sécurité récents comme les nouvelles connexions, les changements de mot de passe et les ajouts d’appareils.';

  @override
  String settingsEventsNeedReview(int count) {
    return '$count événement nécessite votre attention';
  }

  @override
  String get settingsFilterAll => 'Tout';

  @override
  String get settingsFilterDevices => 'Appareils';

  @override
  String get settingsFilterIdentity => 'Identité';

  @override
  String get settingsFilterSignIn => 'Connexion';

  @override
  String get settingsNoSecurityEvents =>
      'Aucun événement de sécurité à afficher.';

  @override
  String get settingsReviewLinkedDevices => 'Examiner les appareils liés';

  @override
  String get settingsReviewLinkedDevicesHint =>
      'Si vous ne reconnaissez pas cet appareil, examinez vos appareils liés.';

  @override
  String get settingsBlockedUsersInfo =>
      'Les comptes bloqués ne peuvent pas vous contacter';

  @override
  String get settingsBlockedUsersError =>
      'Impossible de charger les utilisateurs bloqués.';

  @override
  String settingsBlockedUsersCount(int count) {
    return '$count utilisateurs bloqués';
  }

  @override
  String get settingsNoBlockedUsers => 'Aucun utilisateur bloqué';

  @override
  String get settingsNoBlockedUsersBody =>
      'Les personnes que vous bloquez apparaîtront ici.';

  @override
  String settingsUnblockTitle(String name) {
    return 'Débloquer $name ?';
  }

  @override
  String settingsUnblockBody(String name) {
    return '$name pourra peut-être vous envoyer des messages ou des demandes de contact à nouveau.';
  }

  @override
  String get settingsUnblockAction => 'Débloquer';

  @override
  String settingsUnblockedSnack(String name) {
    return '$name a été débloqué.';
  }

  @override
  String get settingsProtected => 'Protégé';

  @override
  String get settingsUseAppLock => 'Utiliser le verrouillage de l’app';

  @override
  String get settingsTurnOffAppLockTitle =>
      'Désactiver le verrouillage de l’app ?';

  @override
  String get settingsTurnOffAppLockBody =>
      'Pokidoki ne demandera plus votre code PIN à l’ouverture de l’application.';

  @override
  String get settingsTurnOffAppLockAction => 'Désactiver';

  @override
  String get settingsUnlockMethods => 'Méthodes de déverrouillage';

  @override
  String get settingsChangeAppPin => 'Changer le code PIN de l’app';

  @override
  String get settingsPinLength => 'Longueur du code PIN';

  @override
  String get settingsPinLengthValue => '6 chiffres';

  @override
  String get settingsAutomaticLocking => 'Verrouillage automatique';

  @override
  String get settingsLockImmediately => 'Immédiatement';

  @override
  String get settingsLockAfter1Minute => 'Après 1 minute';

  @override
  String get settingsLockAfter5Minutes => 'Après 5 minutes';

  @override
  String get settingsLockAfter30Minutes => 'Après 30 minutes';

  @override
  String get settingsLockAfterRestart =>
      'Demander le code PIN après le redémarrage de l’appareil';

  @override
  String get settingsAlwaysRequired => 'Toujours requis';

  @override
  String get settingsPrivacyWhileLocked => 'Confidentialité lorsque verrouillé';

  @override
  String get settingsHideContentInAppSwitcher =>
      'Masquer le contenu dans le sélecteur d’apps';

  @override
  String get settingsPinNotPassword =>
      'Le code PIN de l’app n’est pas le mot de passe de votre compte';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeSystem => 'Utiliser le réglage de l’appareil';

  @override
  String get settingsThemeSystemBody => 'Suit automatiquement le thème système';

  @override
  String get settingsDarkActive => 'L’apparence sombre est active';

  @override
  String get settingsDarkActiveBody =>
      'Économise la batterie et réduit la fatigue oculaire en faible luminosité.';

  @override
  String get settingsLightActive => 'L’apparence claire est active';

  @override
  String get settingsLightActiveBody =>
      'Utilise une palette plus claire pour un usage diurne.';

  @override
  String get settingsSystemActive => 'L’apparence système est active';

  @override
  String get settingsAppearanceSecurityNote =>
      'L’apparence ne modifie pas votre sécurité';

  @override
  String settingsLanguageActive(String name) {
    return '$name est active';
  }

  @override
  String settingsLanguageActiveBody(String name) {
    return 'Les menus, réglages et messages système de Pokidoki s’affichent en $name.';
  }

  @override
  String get settingsAppLanguage => 'Langue de l’application';

  @override
  String get settingsLeftToRight => 'De gauche à droite';

  @override
  String get settingsRightToLeft => 'De droite à gauche';

  @override
  String get settingsLanguageMessagesNote =>
      'Changer de langue ne traduit pas les messages';

  @override
  String get settingsStorageError =>
      'Impossible de calculer l’utilisation du stockage.';

  @override
  String get settingsStorageUsedOnDevice =>
      'Utilisé par Pokidoki sur cet appareil';

  @override
  String settingsStorageSummarySemantic(String total) {
    return 'Stockage total utilisé : $total';
  }

  @override
  String get settingsCategories => 'Catégories';

  @override
  String get settingsStorageMedia => 'Photos et vidéos';

  @override
  String get settingsStorageFiles => 'Fichiers';

  @override
  String get settingsStorageVoice => 'Messages vocaux';

  @override
  String get settingsStorageCache => 'Cache';

  @override
  String get settingsStorageOther => 'Autres données locales';

  @override
  String get settingsClear => 'Effacer';

  @override
  String get settingsClearCache => 'Effacer le cache';

  @override
  String get settingsClearCacheSubtitle =>
      'Supprimer les données temporaires en toute sécurité';

  @override
  String get settingsClearCacheTitle => 'Effacer les fichiers en cache ?';

  @override
  String get settingsClearCacheBody =>
      'Les médias téléchargés peuvent être récupérés à nouveau si nécessaire.';

  @override
  String get settingsClearCacheAction => 'Effacer le cache';

  @override
  String get settingsCacheCleared => 'Cache effacé.';

  @override
  String get accountChangePassword => 'Changer le mot de passe';

  @override
  String get accountProtectAccount => 'Protégez votre compte Pokidoki';

  @override
  String get accountCurrentPassword => 'Mot de passe actuel';

  @override
  String get accountForgotCurrentPassword => 'Mot de passe actuel oublié ?';

  @override
  String get accountNewPassword => 'Nouveau mot de passe';

  @override
  String get accountConfirmNewPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get accountPasswordRequirements => 'Exigences :';

  @override
  String get accountPasswordMinLength => 'Au moins 12 caractères';

  @override
  String get accountPasswordUpperLower => 'Majuscules et minuscules';

  @override
  String get accountPasswordNumber => 'Au moins un chiffre';

  @override
  String get accountPasswordSymbol => 'Au moins un symbole (!@#\$%^&*)';

  @override
  String get accountPasswordDifferent => 'Différent du mot de passe actuel';

  @override
  String get accountPasswordMismatch =>
      'Les mots de passe ne correspondent pas.';

  @override
  String get accountSignOutOtherDevices => 'Déconnecter les autres appareils';

  @override
  String get accountSignOutOtherDevicesRecommended =>
      'Recommandé pour la sécurité';

  @override
  String get accountPasswordPinDifferent =>
      'Votre mot de passe et le code PIN de l’app sont différents';

  @override
  String get accountUpdatePassword => 'Mettre à jour le mot de passe';

  @override
  String get accountPasswordUpdated => 'Mot de passe mis à jour.';

  @override
  String get accountPasswordUpdateFailed =>
      'Impossible de mettre à jour votre mot de passe. Vérifiez votre mot de passe actuel et réessayez.';

  @override
  String get accountSecurityGenericError =>
      'Impossible de terminer cette action. Votre compte reste inchangé.';

  @override
  String get accountShowPassword => 'Afficher le mot de passe';

  @override
  String get accountHidePassword => 'Masquer le mot de passe';

  @override
  String get accountEmailTitle => 'E-mail';

  @override
  String get accountEmailVerifiedTitle => 'Votre e-mail est vérifié';

  @override
  String get accountEmailRecoveryHelp =>
      'Cet e-mail peut servir à la récupération de compte et aux alertes de sécurité importantes.';

  @override
  String accountVerifiedOn(String date) {
    return 'Vérifié le $date';
  }

  @override
  String get accountEmailSection => 'E-mail du compte';

  @override
  String get accountLastVerified => 'Dernière vérification';

  @override
  String get accountRecoveryAvailable => 'Disponible';

  @override
  String get accountChangeEmail => 'Changer l’adresse e-mail';

  @override
  String get accountChangeEmailSubtitle =>
      'Remplacer l’e-mail vérifié associé à ce compte';

  @override
  String get accountSecurityEmails => 'E-mails de sécurité';

  @override
  String get accountSecurityAlerts => 'Alertes de sécurité';

  @override
  String get accountSecurityAlertsBody =>
      'Recevez des notifications importantes sur la sécurité du compte et de l’appareil.';

  @override
  String get accountAlwaysOn => 'Toujours activé';

  @override
  String get accountNewDeviceAlerts => 'Alertes de nouvel appareil';

  @override
  String get accountNewDeviceAlertsBody =>
      'Recevez un e-mail lorsqu’un nouvel appareil est lié ou se connecte.';

  @override
  String get accountRecoveryAlerts => 'Alertes de récupération';

  @override
  String get accountRecoveryAlertsBody =>
      'Recevez un e-mail lorsque la récupération de compte est démarrée.';

  @override
  String get accountOptionalCommunications => 'Communications facultatives';

  @override
  String get accountProductUpdates => 'Actualités et conseils produit';

  @override
  String get accountResearchInvitations => 'Invitations à la recherche';

  @override
  String get accountEmailNotPublic =>
      'Votre e-mail vérifié aide à récupérer votre compte et n’est pas montré aux contacts.';

  @override
  String get accountReauthenticateTitle => 'Confirmez votre mot de passe';

  @override
  String get accountReauthenticateBody =>
      'Saisissez votre mot de passe actuel pour continuer le changement d’e-mail.';

  @override
  String get accountEnterNewEmailBody =>
      'Saisissez la nouvelle adresse e-mail pour ce compte.';

  @override
  String get accountEmailInvalid => 'Saisissez une adresse e-mail valide.';

  @override
  String get accountEmailConflict =>
      'Cet e-mail ne peut pas être utilisé pour ce compte.';

  @override
  String get accountVerifyEmailTitle => 'Vérifiez votre e-mail';

  @override
  String accountVerifyEmailBody(String email) {
    return 'Saisissez le code à six chiffres envoyé à $email.';
  }

  @override
  String get accountVerificationCode => 'Code de vérification';

  @override
  String get accountVerifyAction => 'Vérifier';

  @override
  String get accountCodeInvalid =>
      'Le code de vérification est incorrect ou a expiré.';

  @override
  String get accountEmailUpdated => 'Votre adresse e-mail a été mise à jour.';

  @override
  String get accountRecoveryTitle => 'Récupération de compte';

  @override
  String get accountRecoveryAvailableTitle =>
      'La récupération de compte est disponible';

  @override
  String get accountRecoveryMethod => 'Méthode de récupération';

  @override
  String get accountVerifiedEmail => 'E-mail vérifié';

  @override
  String get accountThisPhone => 'Ce téléphone';

  @override
  String get accountRecognized => 'Reconnu';

  @override
  String get accountWhatHappensNext => 'Que se passe-t-il ensuite';

  @override
  String get accountRecoveryStep1 => 'Recevoir un code de vérification';

  @override
  String get accountRecoveryStep1Body =>
      'Envoyé à votre adresse e-mail vérifiée.';

  @override
  String get accountRecoveryStep2 => 'Confirmer cet appareil';

  @override
  String get accountRecoveryStep2Body =>
      'Vérifiez que vous utilisez un appareil reconnu.';

  @override
  String get accountRecoveryStep3 => 'Créer un nouveau mot de passe';

  @override
  String get accountRecoveryStep3Body =>
      'Choisissez un mot de passe de compte fort.';

  @override
  String get accountRecoveryStep4 => 'Examiner la sécurité du compte';

  @override
  String get accountRecoveryStep4Body =>
      'Examinez les appareils liés et l’activité récente.';

  @override
  String get accountLocalDataWarning =>
      'Certaines données locales protégées peuvent être indisponibles. La récupération confirme la propriété du compte et ne crée pas de porte dérobée vers les conversations chiffrées.';

  @override
  String get accountStartRecoveryTitle =>
      'Démarrer la récupération de compte ?';

  @override
  String accountStartRecoveryBody(String email) {
    return 'Un code de vérification sera envoyé à $email.';
  }

  @override
  String get accountStartRecoveryAction => 'Démarrer la récupération';

  @override
  String get accountCancelRecovery => 'Annuler la récupération';

  @override
  String get accountCannotAccessEmail => 'Je ne peux pas accéder à cet e-mail';

  @override
  String get accountSupportNeverasks =>
      'Le support ne demandera jamais votre mot de passe, code PIN ou code de vérification.';

  @override
  String get accountRecoveryCodeInvalid =>
      'Le code de vérification est incorrect ou a expiré.';

  @override
  String get accountCreateNewPassword => 'Créer un nouveau mot de passe';

  @override
  String get accountRestoreAccess => 'Restaurer l’accès';

  @override
  String get accountRecoveryCompleted => 'Accès au compte restauré.';

  @override
  String get accountRecoveryCompletedBody =>
      'Vous pouvez continuer à utiliser Pokidoki avec votre nouveau mot de passe. Votre code PIN d’app n’a pas été modifié.';

  @override
  String get reportUserTitle => 'Signaler un utilisateur';

  @override
  String get reportBlockedBadge => 'Bloqué';

  @override
  String get reportHelpReview =>
      'Les signalements aident Pokidoki à examiner d’éventuels abus';

  @override
  String get reportWhyTitle => 'Pourquoi signalez-vous ce compte ?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Harcèlement';

  @override
  String get reportReasonImpersonation => 'Usurpation d’identité';

  @override
  String get reportReasonThreats => 'Menaces ou violence';

  @override
  String get reportReasonInappropriate => 'Contenu sexuel ou inapproprié';

  @override
  String get reportReasonScam => 'Arnaque ou fraude';

  @override
  String get reportReasonOther => 'Autre';

  @override
  String get reportAdditionalDetails => 'Détails supplémentaires (facultatif)';

  @override
  String get reportDetailsHelper =>
      'N’entrez pas de mots de passe, codes PIN, codes de vérification ou clés privées.';

  @override
  String get reportEvidence => 'Preuves';

  @override
  String get reportIncludeEvidence =>
      'Inclure des preuves de conversation sélectionnées';

  @override
  String get reportEvidenceDefaultOff =>
      'Rien n’est inclus par défaut. Sélectionnez des messages du chat pour les inclure comme preuves.';

  @override
  String reportSelectedEvidenceCount(int count) {
    return '$count sélectionné(s)';
  }

  @override
  String get reportSelectEvidence => 'Sélectionner des preuves';

  @override
  String get reportNotBlocking =>
      'Signaler n’est pas bloquer. Le signalement envoie des informations pour examen. Le blocage empêche les nouvelles demandes de contact ou messages.';

  @override
  String get reportWhatWillBeSent => 'Ce qui sera envoyé';

  @override
  String get reportAccountIdentifier => 'Identifiant du compte';

  @override
  String get reportReasonLabel => 'Raison';

  @override
  String get reportDetailsLabel => 'Détails';

  @override
  String get reportNotSelected => 'Non sélectionné';

  @override
  String get reportNone => 'Aucun';

  @override
  String get reportDetailsIncluded => 'Inclus';

  @override
  String get reportNotIncluded => 'Non inclus';

  @override
  String get reportReviewData => 'Examiner les données du signalement';

  @override
  String get reportSubmitTitle => 'Envoyer ce signalement ?';

  @override
  String get reportSubmitBody =>
      'Pokidoki recevra la raison sélectionnée, vos détails facultatifs et uniquement les preuves que vous avez examinées.';

  @override
  String reportRemainsBlocked(String name) {
    return '$name restera bloqué.';
  }

  @override
  String get reportSubmitAction => 'Envoyer le signalement';

  @override
  String get reportSubmitted => 'Signalement envoyé.';

  @override
  String get reportSubmitFailed => 'Votre signalement n’a pas été envoyé.';

  @override
  String get reportNotEmergency =>
      'Les signalements Pokidoki ne sont pas un service d’urgence.';

  @override
  String get contactsSelfNotAllowed =>
      'Vous ne pouvez pas vous envoyer une demande de contact.';

  @override
  String get contactsAlreadyPending =>
      'Une demande de contact est déjà en attente.';

  @override
  String get contactsReversePending =>
      'Cette personne vous a déjà envoyé une demande. Acceptez-la dans Demandes de contact.';

  @override
  String get contactsRequestNotFound =>
      'Cette demande de contact n’est plus disponible.';

  @override
  String get contactsRequestNotPending =>
      'Cette demande de contact n’est plus en attente.';

  @override
  String get contactsRequestForbidden =>
      'Vous ne pouvez pas effectuer cette action sur cette demande.';

  @override
  String get contactsAlreadyExists =>
      'Vous êtes déjà connecté avec cette personne.';

  @override
  String get contactsNotFound => 'Ce contact n’est plus disponible.';

  @override
  String get contactsUserUnavailable => 'Cet utilisateur n’est pas disponible.';

  @override
  String get contactsAlreadyBlocked => 'Cet utilisateur est déjà bloqué.';

  @override
  String get contactsNotBlocked => 'Cet utilisateur n’est pas bloqué.';

  @override
  String get contactsRelationshipUnavailable =>
      'Les informations de relation ne sont pas disponibles.';
}
