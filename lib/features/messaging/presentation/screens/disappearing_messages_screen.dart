import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/messaging_providers.dart';

class DisappearingMessagesScreen extends ConsumerWidget {
  const DisappearingMessagesScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    ref.watch(socialGraphProvider);
    ref.watch(messagingProvider);
    final conversation = ref
        .read(messagingProvider.notifier)
        .conversation(conversationId);
    final selected = conversation?.disappearingDurationHours;
    final displayName = conversation?.peerDisplayName ?? '';
    final verified = conversation == null
        ? false
        : ref
              .read(socialGraphProvider.notifier)
              .isContactVerified(conversation.peerId);

    final options = <(int?, String, String)>[
      (null, l10n.chatDisappearingOff, l10n.chatDisappearingOffHelp),
      (1, l10n.chatDisappearingOneHour, l10n.chatDisappearingOneHourHelp),
      (24, l10n.chatDisappearingOneDay, l10n.chatDisappearingOneDayHelp),
      (168, l10n.chatDisappearingOneWeek, l10n.chatDisappearingOneWeekHelp),
    ];

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
                      l10n.chatDisappearingMessages,
                      textAlign: TextAlign.center,
                      style: typography.sectionTitle,
                    ),
                  ),
                  const SizedBox(width: PokidokiSpacing.minTouchTarget),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(PokidokiSpacing.lg),
                children: [
                  Center(
                    child: PokidokiAvatar(displayName: displayName, size: 64),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  Text(
                    displayName,
                    style: typography.cardTitle,
                    textAlign: TextAlign.center,
                  ),
                  if (verified)
                    Center(
                      child: PokidokiContactStatusBadge(
                        label: l10n.semanticVerified,
                        tone: PokidokiBadgeTone.secure,
                      ),
                    ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  Text(
                    l10n.chatDisappearingAppliesFuture,
                    style: typography.supportingBody,
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  ...options.map((option) {
                    final hours = option.$1;
                    final selectedOption = selected == hours;
                    return ListTile(
                      title: Text(option.$2),
                      subtitle: Text(option.$3),
                      trailing: Icon(
                        selectedOption
                            ? Icons.check_circle_rounded
                            : Icons.circle_outlined,
                        color: selectedOption
                            ? colors.primary
                            : colors.textTertiary,
                      ),
                      onTap: () {
                        ref
                            .read(messagingProvider.notifier)
                            .setDisappearingHours(conversationId, hours);
                      },
                    );
                  }),
                  const SizedBox(height: PokidokiSpacing.md),
                  Text(
                    l10n.chatDisappearingScreenshotWarning,
                    style: typography.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
