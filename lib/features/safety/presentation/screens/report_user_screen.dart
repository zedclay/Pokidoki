import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../data/models/account_security.dart';
import '../../../../data/models/message.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/inputs/pokidoki_text_field.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../messaging/data/messaging_providers.dart';
import '../../../settings/presentation/widgets/settings_app_bar.dart';
import '../../../settings/presentation/widgets/settings_section_card.dart';
import '../../../social/presentation/controllers/social_graph_controller.dart';
import '../controllers/safety_reporting_controller.dart';

class ReportUserScreen extends ConsumerStatefulWidget {
  const ReportUserScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<ReportUserScreen> createState() => _ReportUserScreenState();
}

class _ReportUserScreenState extends ConsumerState<ReportUserScreen> {
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _detailsController.clear();
    _detailsController.dispose();
    super.dispose();
  }

  _ReportedIdentity _identity(WidgetRef ref) {
    final graph = ref.watch(socialGraphProvider);
    for (final contact in graph.contacts) {
      if (contact.id == widget.userId) {
        return _ReportedIdentity(
          displayName: contact.displayName,
          username: contact.username,
          pokidokiId: contact.pokidokiId,
          isBlocked: _isBlocked(graph, widget.userId),
        );
      }
    }
    final profile = graph.profiles[widget.userId];
    if (profile != null) {
      return _ReportedIdentity(
        displayName: profile.displayName,
        username: profile.username,
        pokidokiId: profile.pokidokiId,
        isBlocked: _isBlocked(graph, widget.userId),
      );
    }
    for (final conversation in graph.conversations) {
      if (conversation.peerId == widget.userId) {
        return _ReportedIdentity(
          displayName: conversation.peerDisplayName,
          username: conversation.peerUsername,
          pokidokiId: 'PKD-UNKNOWN',
          isBlocked: conversation.isBlocked,
        );
      }
    }
    for (final user in MockSampleData.directoryUsers) {
      if (user.id == widget.userId) {
        return _ReportedIdentity(
          displayName: user.displayName,
          username: user.username,
          pokidokiId: user.pokidokiId,
          isBlocked: _isBlocked(graph, widget.userId),
        );
      }
    }
    for (final blocked in graph.blockedUsers) {
      if (blocked.id == widget.userId) {
        return _ReportedIdentity(
          displayName: blocked.displayName,
          username: blocked.username,
          pokidokiId: blocked.pokidokiId,
          isBlocked: true,
        );
      }
    }
    return _ReportedIdentity(
      displayName: 'Riad B.',
      username: 'riad.b',
      pokidokiId: 'PKD-R8D4-72LX',
      isBlocked: _isBlocked(graph, widget.userId),
    );
  }

  bool _isBlocked(SocialGraphState graph, String userId) {
    return graph.blockedUsers.any((user) => user.id == userId);
  }

  String? _conversationId(WidgetRef ref) {
    for (final conversation in ref.read(socialGraphProvider).conversations) {
      if (conversation.peerId == widget.userId) {
        return conversation.id;
      }
    }
    return widget.userId == MockSampleData.amiraUserId ? 'conv-amira' : null;
  }

  Future<void> _pickEvidence() async {
    final conversationId = _conversationId(ref);
    if (conversationId == null) {
      return;
    }
    final messages = ref
        .read(messagingProvider)
        .messagesFor(conversationId)
        .where((message) => message.type != MessageContentType.system)
        .toList();
    final selected = Set<String>.from(
      ref
          .read(safetyReportingProvider(widget.userId))
          .draft
          .selectedEvidenceIds,
    );
    final result = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _EvidencePicker(messages: messages, initiallySelected: selected);
      },
    );
    if (result != null) {
      ref
          .read(safetyReportingProvider(widget.userId).notifier)
          .setSelectedEvidence(result.toList());
    }
  }

  Future<void> _submit(
    AppLocalizations l10n,
    _ReportedIdentity identity,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.reportSubmitTitle),
        content: Text(
          [
            l10n.reportSubmitBody,
            if (identity.isBlocked)
              l10n.reportRemainsBlocked(identity.displayName.split(' ').first),
          ].join('\n\n'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.reportSubmitAction),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }
    final ok = await ref
        .read(safetyReportingProvider(widget.userId).notifier)
        .submit();
    if (!mounted) {
      return;
    }
    if (ok) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.reportSubmitted)));
      ref
          .read(safetyReportingProvider(widget.userId).notifier)
          .clearSensitiveDraft();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final identity = _identity(ref);
    final report = ref.watch(safetyReportingProvider(widget.userId));
    final draft = report.draft;
    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.reportUserTitle),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  PokidokiSpacing.lg,
                  PokidokiSpacing.sm,
                  PokidokiSpacing.lg,
                  PokidokiSpacing.xl,
                ),
                children: [
                  SettingsSectionCard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.md),
                        child: Row(
                          children: [
                            PokidokiAvatar(
                              displayName: identity.displayName,
                              size: 48,
                            ),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          identity.displayName,
                                          style: typography.cardTitle,
                                        ),
                                      ),
                                      if (identity.isBlocked)
                                        Text(
                                          l10n.reportBlockedBadge,
                                          style: typography.caption.copyWith(
                                            color: colors.error,
                                          ),
                                        ),
                                    ],
                                  ),
                                  LtrText(
                                    '@${identity.username}',
                                    style: typography.supportingBody,
                                  ),
                                  LtrText(
                                    'ID: ${identity.pokidokiId}',
                                    style: typography.caption,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  Text(l10n.reportHelpReview, style: typography.supportingBody),
                  const SizedBox(height: PokidokiSpacing.lg),
                  Text(l10n.reportWhyTitle, style: typography.cardTitle),
                  const SizedBox(height: PokidokiSpacing.sm),
                  SettingsSectionCard(
                    children: [
                      for (final reason in ReportReason.values)
                        _ReasonRow(
                          reason: reason,
                          selected: draft.reason == reason,
                          label: _reasonLabel(l10n, reason),
                          onTap: () => ref
                              .read(
                                safetyReportingProvider(widget.userId).notifier,
                              )
                              .selectReason(reason),
                        ),
                    ],
                  ),
                  if (draft.reason == ReportReason.threatsOrViolence) ...[
                    const SizedBox(height: PokidokiSpacing.md),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.warning.withValues(alpha: 0.12),
                        borderRadius: PokidokiRadii.borderXl,
                        border: Border.all(
                          color: colors.warning.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.md),
                        child: Text(
                          l10n.reportNotEmergency,
                          style: typography.supportingBody,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: PokidokiSpacing.lg),
                  Text(
                    l10n.reportAdditionalDetails,
                    style: typography.cardTitle,
                  ),
                  Text(l10n.reportDetailsHelper, style: typography.caption),
                  const SizedBox(height: PokidokiSpacing.sm),
                  PokidokiTextField(
                    controller: _detailsController,
                    maxLines: 4,
                    onChanged: (value) => ref
                        .read(safetyReportingProvider(widget.userId).notifier)
                        .setDetails(value),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      '${draft.details.length} / 1000',
                      style: typography.caption,
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    title: l10n.reportEvidence,
                    children: [
                      SwitchListTile.adaptive(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: PokidokiSpacing.md,
                        ),
                        title: Text(l10n.reportIncludeEvidence),
                        subtitle: Text(
                          l10n.reportEvidenceDefaultOff,
                          style: typography.supportingBody,
                        ),
                        value: draft.includeEvidence,
                        onChanged: (value) async {
                          ref
                              .read(
                                safetyReportingProvider(widget.userId).notifier,
                              )
                              .setIncludeEvidence(value);
                          if (value) {
                            await _pickEvidence();
                          }
                        },
                      ),
                      if (draft.includeEvidence)
                        ListTile(
                          title: Text(
                            l10n.reportSelectedEvidenceCount(
                              draft.selectedEvidenceIds.length,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: _pickEvidence,
                        ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  Text(
                    l10n.reportNotBlocking,
                    style: typography.supportingBody,
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  SettingsSectionCard(
                    title: l10n.reportWhatWillBeSent,
                    children: [
                      _SummaryRow(
                        label: l10n.reportAccountIdentifier,
                        value: identity.displayName,
                      ),
                      _SummaryRow(
                        label: l10n.reportReasonLabel,
                        value: draft.reason == null
                            ? l10n.reportNotSelected
                            : _reasonLabel(l10n, draft.reason!),
                      ),
                      _SummaryRow(
                        label: l10n.reportDetailsLabel,
                        value: draft.details.isEmpty
                            ? l10n.reportNone
                            : l10n.reportDetailsIncluded,
                      ),
                      _SummaryRow(
                        label: l10n.reportEvidence,
                        value:
                            draft.includeEvidence &&
                                draft.selectedEvidenceIds.isNotEmpty
                            ? l10n.reportSelectedEvidenceCount(
                                draft.selectedEvidenceIds.length,
                              )
                            : l10n.reportNotIncluded,
                      ),
                    ],
                  ),
                  if (report.errorKey != null) ...[
                    const SizedBox(height: PokidokiSpacing.md),
                    Text(
                      l10n.reportSubmitFailed,
                      style: typography.supportingBody.copyWith(
                        color: colors.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: PokidokiSpacing.xl),
                  PokidokiButton.primary(
                    label: l10n.reportSubmitAction,
                    isLoading:
                        report.status == ReportSubmissionStatus.submitting,
                    onPressed:
                        draft.reason == null ||
                            report.status == ReportSubmissionStatus.submitting
                        ? null
                        : () => _submit(l10n, identity),
                  ),
                  const SizedBox(height: PokidokiSpacing.xs),
                  Text(
                    l10n.reportReviewData,
                    style: typography.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _reasonLabel(AppLocalizations l10n, ReportReason reason) {
    return switch (reason) {
      ReportReason.spam => l10n.reportReasonSpam,
      ReportReason.harassment => l10n.reportReasonHarassment,
      ReportReason.impersonation => l10n.reportReasonImpersonation,
      ReportReason.threatsOrViolence => l10n.reportReasonThreats,
      ReportReason.inappropriateContent => l10n.reportReasonInappropriate,
      ReportReason.scamOrFraud => l10n.reportReasonScam,
      ReportReason.other => l10n.reportReasonOther,
    };
  }
}

class _ReportedIdentity {
  const _ReportedIdentity({
    required this.displayName,
    required this.username,
    required this.pokidokiId,
    required this.isBlocked,
  });

  final String displayName;
  final String username;
  final String pokidokiId;
  final bool isBlocked;
}

class _ReasonRow extends StatelessWidget {
  const _ReasonRow({
    required this.reason,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final ReportReason reason;
  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final icon = switch (reason) {
      ReportReason.spam => Icons.campaign_rounded,
      ReportReason.harassment => Icons.person_off_rounded,
      ReportReason.impersonation => Icons.theater_comedy_rounded,
      ReportReason.threatsOrViolence => Icons.warning_amber_rounded,
      ReportReason.inappropriateContent => Icons.visibility_off_rounded,
      ReportReason.scamOrFraud => Icons.money_off_rounded,
      ReportReason.other => Icons.more_horiz_rounded,
    };

    return Semantics(
      selected: selected,
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.md),
          child: Row(
            children: [
              Icon(icon, color: colors.textSecondary),
              const SizedBox(width: PokidokiSpacing.sm),
              Expanded(child: Text(label, style: typography.body)),
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: selected ? colors.primary : colors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Padding(
      padding: const EdgeInsets.all(PokidokiSpacing.md),
      child: Row(
        children: [
          Expanded(child: Text(label, style: typography.supportingBody)),
          Flexible(child: Text(value, style: typography.body)),
        ],
      ),
    );
  }
}

class _EvidencePicker extends StatefulWidget {
  const _EvidencePicker({
    required this.messages,
    required this.initiallySelected,
  });

  final List<ChatMessage> messages;
  final Set<String> initiallySelected;

  @override
  State<_EvidencePicker> createState() => _EvidencePickerState();
}

class _EvidencePickerState extends State<_EvidencePicker> {
  late final Set<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Set<String>.from(widget.initiallySelected);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(PokidokiSpacing.md),
              child: Text(
                l10n.reportSelectEvidence,
                style: typography.cardTitle,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.messages.length,
                itemBuilder: (context, index) {
                  final message = widget.messages[index];
                  final selected = _selected.contains(message.id);
                  return CheckboxListTile(
                    value: selected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selected.add(message.id);
                        } else {
                          _selected.remove(message.id);
                        }
                      });
                    },
                    title: Text(
                      message.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(PokidokiSpacing.md),
              child: PokidokiButton.primary(
                label: l10n.actionContinue,
                onPressed: () => Navigator.pop(context, _selected),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
