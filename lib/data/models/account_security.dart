// Account-security presentation models for Batch 7 UI flows.

enum PasswordChangeStatus { idle, submitting, success, failure }

enum EmailVerificationStatus { verified, unverified, changePending }

enum EmailManagementStep { overview, reauthenticate, enterEmail, verifyCode }

enum RecoveryStep { introduction, codeVerification, newPassword, completed }

class AccountEmailState {
  const AccountEmailState({
    required this.maskedEmail,
    required this.status,
    this.verifiedAt,
    this.securityAlertsEnabled = true,
    this.newDeviceAlertsEnabled = true,
    this.recoveryAlertsEnabled = true,
    this.productUpdatesEnabled = false,
    this.researchInvitationsEnabled = false,
    this.pendingMaskedEmail,
  });

  final String maskedEmail;
  final EmailVerificationStatus status;
  final DateTime? verifiedAt;
  final bool securityAlertsEnabled;
  final bool newDeviceAlertsEnabled;
  final bool recoveryAlertsEnabled;
  final bool productUpdatesEnabled;
  final bool researchInvitationsEnabled;
  final String? pendingMaskedEmail;

  AccountEmailState copyWith({
    String? maskedEmail,
    EmailVerificationStatus? status,
    DateTime? verifiedAt,
    bool? securityAlertsEnabled,
    bool? newDeviceAlertsEnabled,
    bool? recoveryAlertsEnabled,
    bool? productUpdatesEnabled,
    bool? researchInvitationsEnabled,
    String? pendingMaskedEmail,
    bool clearPending = false,
  }) {
    return AccountEmailState(
      maskedEmail: maskedEmail ?? this.maskedEmail,
      status: status ?? this.status,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      securityAlertsEnabled:
          securityAlertsEnabled ?? this.securityAlertsEnabled,
      newDeviceAlertsEnabled:
          newDeviceAlertsEnabled ?? this.newDeviceAlertsEnabled,
      recoveryAlertsEnabled:
          recoveryAlertsEnabled ?? this.recoveryAlertsEnabled,
      productUpdatesEnabled:
          productUpdatesEnabled ?? this.productUpdatesEnabled,
      researchInvitationsEnabled:
          researchInvitationsEnabled ?? this.researchInvitationsEnabled,
      pendingMaskedEmail: clearPending
          ? null
          : (pendingMaskedEmail ?? this.pendingMaskedEmail),
    );
  }
}

enum ReportReason {
  spam,
  harassment,
  impersonation,
  threatsOrViolence,
  inappropriateContent,
  scamOrFraud,
  other,
}

class ReportDraft {
  const ReportDraft({
    required this.reportedUserId,
    this.reason,
    this.details = '',
    this.includeEvidence = false,
    this.selectedEvidenceIds = const [],
  });

  final String reportedUserId;
  final ReportReason? reason;
  final String details;
  final bool includeEvidence;
  final List<String> selectedEvidenceIds;

  ReportDraft copyWith({
    ReportReason? reason,
    String? details,
    bool? includeEvidence,
    List<String>? selectedEvidenceIds,
    bool clearReason = false,
  }) {
    return ReportDraft(
      reportedUserId: reportedUserId,
      reason: clearReason ? null : (reason ?? this.reason),
      details: details ?? this.details,
      includeEvidence: includeEvidence ?? this.includeEvidence,
      selectedEvidenceIds: selectedEvidenceIds ?? this.selectedEvidenceIds,
    );
  }
}

/// Password policy for account password (not app PIN).
abstract final class AccountPasswordPolicy {
  static const minLength = 12;

  static bool hasMinLength(String value) => value.length >= minLength;
  static bool hasUpper(String value) => RegExp(r'[A-Z]').hasMatch(value);
  static bool hasLower(String value) => RegExp(r'[a-z]').hasMatch(value);
  static bool hasNumber(String value) => RegExp(r'[0-9]').hasMatch(value);
  static bool hasSymbol(String value) =>
      RegExp(r'[^A-Za-z0-9]').hasMatch(value);

  static bool isStrong(String value) =>
      hasMinLength(value) &&
      hasUpper(value) &&
      hasLower(value) &&
      hasNumber(value) &&
      hasSymbol(value);

  static String maskEmail(String email) {
    final parts = email.trim().split('@');
    if (parts.length != 2 || parts[0].isEmpty) {
      return 'z••••••@example.com';
    }
    final local = parts[0];
    final visible = local.substring(0, 1);
    return '$visible••••••@${parts[1]}';
  }
}
