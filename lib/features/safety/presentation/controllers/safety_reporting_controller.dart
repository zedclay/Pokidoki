import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/account_security.dart';
import '../../../../data/models/security_event.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../data/safety_reporting_repository.dart';

enum ReportSubmissionStatus { editing, submitting, success, failure }

class SafetyReportingState {
  const SafetyReportingState({
    required this.draft,
    this.status = ReportSubmissionStatus.editing,
    this.errorKey,
    this.successKey,
  });

  final ReportDraft draft;
  final ReportSubmissionStatus status;
  final String? errorKey;
  final String? successKey;

  SafetyReportingState copyWith({
    ReportDraft? draft,
    ReportSubmissionStatus? status,
    String? errorKey,
    String? successKey,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return SafetyReportingState(
      draft: draft ?? this.draft,
      status: status ?? this.status,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      successKey: clearSuccess ? null : (successKey ?? this.successKey),
    );
  }
}

class SafetyReportingController extends StateNotifier<SafetyReportingState> {
  SafetyReportingController(this._ref, this._repository, String reportedUserId)
    : super(
        SafetyReportingState(
          draft: ReportDraft(reportedUserId: reportedUserId),
        ),
      );

  final Ref _ref;
  final SafetyReportingRepository _repository;
  int _eventCounter = 0;

  void selectReason(ReportReason reason) {
    state = state.copyWith(
      draft: state.draft.copyWith(reason: reason),
      status: ReportSubmissionStatus.editing,
      clearError: true,
    );
  }

  void setDetails(String details) {
    final clipped = details.length > 1000
        ? details.substring(0, 1000)
        : details;
    state = state.copyWith(draft: state.draft.copyWith(details: clipped));
  }

  void setIncludeEvidence(bool value) {
    state = state.copyWith(
      draft: state.draft.copyWith(
        includeEvidence: value,
        selectedEvidenceIds: value ? state.draft.selectedEvidenceIds : const [],
      ),
    );
  }

  void setSelectedEvidence(List<String> ids) {
    state = state.copyWith(
      draft: state.draft.copyWith(
        includeEvidence: ids.isNotEmpty,
        selectedEvidenceIds: ids,
      ),
    );
  }

  void clearSensitiveDraft() {
    state = SafetyReportingState(
      draft: ReportDraft(reportedUserId: state.draft.reportedUserId),
    );
  }

  Future<bool> submit() async {
    if (state.draft.reason == null) {
      return false;
    }
    state = state.copyWith(
      status: ReportSubmissionStatus.submitting,
      clearError: true,
    );
    try {
      await _repository.submitReport(state.draft);
      _ref
          .read(settingsProvider.notifier)
          .addSecurityEvent(
            SecurityEvent(
              id: 'sec-report-${_eventCounter++}',
              type: SecurityEventType.reportSubmitted,
              occurredAt: DateTime.now().toUtc(),
              title: 'Report submitted',
              summary: 'A safety report was submitted for review.',
            ),
          );
      state = state.copyWith(
        status: ReportSubmissionStatus.success,
        successKey: 'reportSubmitted',
      );
      return true;
    } on SafetyReportingFailure {
      state = state.copyWith(
        status: ReportSubmissionStatus.failure,
        errorKey: 'reportSubmitFailed',
      );
      return false;
    }
  }
}

final safetyReportingRepositoryProvider = Provider<SafetyReportingRepository>((
  ref,
) {
  return const MockSafetyReportingRepository();
});

final safetyReportingProvider = StateNotifierProvider.autoDispose
    .family<SafetyReportingController, SafetyReportingState, String>((
      ref,
      userId,
    ) {
      return SafetyReportingController(
        ref,
        ref.watch(safetyReportingRepositoryProvider),
        userId,
      );
    });
