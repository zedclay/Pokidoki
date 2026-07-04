import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/safety_number_block.dart';
import 'qr_scanner_screen.dart';

class SafetyNumberScreen extends ConsumerStatefulWidget {
  const SafetyNumberScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<SafetyNumberScreen> createState() => _SafetyNumberScreenState();
}

class _SafetyNumberScreenState extends ConsumerState<SafetyNumberScreen> {
  List<String> _groups = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final groups = await ref
        .read(contactVerificationRepositoryProvider)
        .getSafetyNumberGroups(widget.userId);
    if (!mounted) {
      return;
    }
    setState(() {
      _groups = groups;
      _loading = false;
    });
  }

  Future<void> _markVerified() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.verifyMarkTitle('Amira')),
        content: Text(l10n.verifyMarkBody('Amira')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.verifyMarkAction),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    await ref.read(socialGraphProvider.notifier).markVerified(widget.userId);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.verifySafetyConfirmed)));
  }

  Future<void> _reset() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.verifyResetTitle),
        content: Text(l10n.verifyResetBody('Amira')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.verifyResetAction),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    await ref
        .read(socialGraphProvider.notifier)
        .resetVerification(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    ref.watch(socialGraphProvider);
    final verified = ref
        .read(socialGraphProvider.notifier)
        .isContactVerified(widget.userId);
    final displayName = widget.userId == MockSampleData.amiraUserId
        ? 'Amira Mansouri'
        : 'Contact';
    final username = widget.userId == MockSampleData.amiraUserId
        ? 'amira'
        : widget.userId;

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  PokidokiIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: l10n.semanticBack,
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      l10n.safetyNumberTitle,
                      textAlign: TextAlign.center,
                      style: typography.sectionTitle,
                    ),
                  ),
                  PokidokiIconButton(
                    icon: Icons.help_outline_rounded,
                    tooltip: l10n.qrHelp,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      padding: const EdgeInsets.all(PokidokiSpacing.lg),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const PokidokiAvatar(
                              displayName: 'Zed Clay',
                              size: 40,
                            ),
                            const SizedBox(width: PokidokiSpacing.md),
                            Icon(Icons.lock_rounded, color: colors.primary),
                            const SizedBox(width: PokidokiSpacing.md),
                            PokidokiAvatar(displayName: displayName, size: 40),
                          ],
                        ),
                        const SizedBox(height: PokidokiSpacing.md),
                        Text(
                          displayName,
                          style: typography.cardTitle,
                          textAlign: TextAlign.center,
                        ),
                        LtrText(
                          '@$username',
                          style: typography.supportingBody,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: PokidokiSpacing.sm),
                        Center(
                          child: PokidokiContactStatusBadge(
                            label: verified
                                ? l10n.semanticVerified
                                : l10n.verifyNotVerified,
                            tone: verified
                                ? PokidokiBadgeTone.secure
                                : PokidokiBadgeTone.warning,
                          ),
                        ),
                        const SizedBox(height: PokidokiSpacing.xl),
                        Text(
                          l10n.safetyCompareHeading(
                            displayName.split(' ').first,
                          ),
                          style: typography.sectionTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: PokidokiSpacing.xs),
                        Text(
                          l10n.safetyCompareBody,
                          style: typography.supportingBody,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: PokidokiSpacing.lg),
                        SafetyNumberBlock(
                          groups: _groups,
                          semanticLabel: l10n.safetyNumberSemantic,
                        ),
                        const SizedBox(height: PokidokiSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: _groups.join(' ')),
                                );
                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n.safetyNumberCopied),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.copy_rounded),
                              label: Text(l10n.usersCopyId),
                            ),
                          ],
                        ),
                        const SizedBox(height: PokidokiSpacing.md),
                        Text(
                          l10n.safetyDoNotCompareOnlyInChat,
                          style: typography.caption,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(PokidokiSpacing.lg),
              child: Column(
                children: [
                  PokidokiButton.primary(
                    label: verified
                        ? l10n.semanticVerified
                        : l10n.verifyMarkAction,
                    onPressed: verified ? null : _markVerified,
                  ),
                  if (verified) ...[
                    const SizedBox(height: PokidokiSpacing.sm),
                    PokidokiButton.secondary(
                      label: l10n.verifyResetAction,
                      onPressed: _reset,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
