import '../../../data/models/account_security.dart';

abstract interface class SafetyReportingRepository {
  Future<void> submitReport(ReportDraft draft);
}

class SafetyReportingFailure implements Exception {
  const SafetyReportingFailure();
}

class MockSafetyReportingRepository implements SafetyReportingRepository {
  const MockSafetyReportingRepository();

  static final List<ReportDraft> submittedReports = <ReportDraft>[];

  @override
  Future<void> submitReport(ReportDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (draft.reason == null) {
      throw const SafetyReportingFailure();
    }
    submittedReports.add(
      ReportDraft(
        reportedUserId: draft.reportedUserId,
        reason: draft.reason,
        details: draft.details,
        includeEvidence: draft.includeEvidence,
        selectedEvidenceIds: List.of(draft.selectedEvidenceIds),
      ),
    );
  }

  static void resetForTests() {
    submittedReports.clear();
  }
}
