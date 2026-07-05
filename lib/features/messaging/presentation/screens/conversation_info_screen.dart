import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/messaging_providers.dart';
import '../utils/disappearing_duration_label.dart';

class ConversationInfoScreen extends ConsumerWidget {
  const ConversationInfoScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    ref.watch(socialGraphProvider);
    ref.watch(messagingProvider);
    ref.watch(conversationsProvider);
    final conversation = ref
        .read(conversationsProvider.notifier)
        .conversationById(conversationId);
    final displayName = conversation?.peerDisplayName ?? 'Chat';
    final username = conversation?.peerUsername ?? '';
    final peerId = conversation?.peerId ?? '';
    final verified = peerId.isEmpty
        ? false
        : ref.read(socialGraphProvider.notifier).isContactVerified(peerId);
    final muted = conversation?.isMuted ?? false;
    final disappearing = conversation?.disappearingDurationHours;
    final blockedByMe = peerId.isEmpty
        ? false
        : ref.read(socialGraphProvider.notifier).isUserBlocked(peerId);
    final messagingDisabled = !(conversation?.canSend ?? true);
    final mediaCount = ref
        .read(messagingProvider.notifier)
        .sharedMedia(conversationId)
        .length;

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
                      l10n.chatConversationInfo,
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
                    child: PokidokiAvatar(displayName: displayName, size: 96),
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  Text(
                    displayName,
                    style: typography.screenTitle,
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
                  _Row(
                    icon: Icons.search_rounded,
                    title: l10n.chatSearchInConversation,
                    onTap: () => context.push(
                      AppRoutes.conversationSearchPath(conversationId),
                    ),
                  ),
                  _Row(
                    icon: Icons.verified_user_rounded,
                    title: l10n.verifyContactTitle,
                    value: verified
                        ? l10n.semanticVerified
                        : l10n.verifyNotVerified,
                    onTap: () =>
                        context.push(AppRoutes.contactVerificationPath(peerId)),
                  ),
                  _Row(
                    icon: Icons.timer_outlined,
                    title: l10n.chatDisappearingMessages,
                    value: disappearingDurationLabel(l10n, disappearing),
                    onTap: () => context.push(
                      AppRoutes.disappearingMessagesPath(conversationId),
                    ),
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    secondary: Icon(
                      Icons.notifications_rounded,
                      color: colors.primary,
                    ),
                    title: Text(l10n.chatMuteNotifications),
                    value: muted,
                    onChanged: (value) {
                      ref
                          .read(messagingProvider.notifier)
                          .setMuted(conversationId, value);
                    },
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  Text(l10n.chatSharedContent, style: typography.inputLabel),
                  _Row(
                    icon: Icons.photo_library_rounded,
                    title: l10n.chatPhotosAndVideos,
                    value: '$mediaCount',
                    onTap: () => context.push(
                      AppRoutes.sharedContentPath(conversationId),
                    ),
                  ),
                  _Row(
                    icon: Icons.description_rounded,
                    title: l10n.chatFiles,
                    onTap: () => context.push(
                      AppRoutes.sharedContentPath(conversationId),
                    ),
                  ),
                  _Row(
                    icon: Icons.link_rounded,
                    title: l10n.chatLinks,
                    onTap: () => context.push(
                      AppRoutes.sharedContentPath(conversationId),
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  if (messagingDisabled)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: PokidokiSpacing.md),
                      padding: const EdgeInsets.all(PokidokiSpacing.md),
                      decoration: BoxDecoration(
                        color: colors.surfaceElevated,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.block_rounded, color: colors.warning),
                          const SizedBox(width: PokidokiSpacing.sm),
                          Expanded(
                            child: Text(
                              blockedByMe
                                  ? l10n.chatBlockedNotice(
                                      displayName.split(' ').first,
                                    )
                                  : l10n.cannotMessageUser,
                              style: typography.supportingBody,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (blockedByMe)
                    PokidokiButton.primary(
                      label: l10n.settingsUnblockAction,
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              l10n.settingsUnblockTitle(
                                displayName.split(' ').first,
                              ),
                            ),
                            content: Text(
                              l10n.settingsUnblockBody(
                                displayName.split(' ').first,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(l10n.actionCancel),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(l10n.settingsUnblockAction),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true && context.mounted) {
                          try {
                            await ref
                                .read(messagingProvider.notifier)
                                .setBlocked(conversationId, false);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    l10n.settingsUnblockedSnack(
                                      displayName.split(' ').first,
                                    ),
                                  ),
                                ),
                              );
                            }
                          } on Object {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.messagingUnavailable),
                                ),
                              );
                            }
                          }
                        }
                      },
                    )
                  else
                    PokidokiButton.secondary(
                      label: l10n.usersBlockAction,
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              l10n.usersBlockTitle(
                                displayName.split(' ').first,
                              ),
                            ),
                            content: Text(
                              l10n.usersBlockBody(displayName.split(' ').first),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(l10n.actionCancel),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(l10n.usersBlockAction),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true && context.mounted) {
                          try {
                            await ref
                                .read(messagingProvider.notifier)
                                .setBlocked(conversationId, true);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.usersBlocked)),
                              );
                            }
                          } on Object {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.messagingUnavailable),
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  PokidokiButton.secondary(
                    label: l10n.usersReportAction,
                    onPressed: peerId.isEmpty
                        ? null
                        : () => context.push(AppRoutes.reportUserPath(peerId)),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  PokidokiButton.destructive(
                    label: l10n.chatDeleteConversation,
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(l10n.chatDeleteConversationTitle),
                          content: Text(l10n.chatDeleteConversationBody),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(l10n.actionCancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(l10n.chatDelete),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true && context.mounted) {
                        ref
                            .read(messagingProvider.notifier)
                            .deleteConversation(conversationId);
                        context.go(AppRoutes.appChats);
                      }
                    },
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

class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.title,
    required this.onTap,
    this.value,
  });

  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: colors.primary),
      title: Text(title, style: typography.body),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null) Text(value!, style: typography.supportingBody),
          Icon(Icons.chevron_right_rounded, color: colors.textTertiary),
        ],
      ),
      onTap: onTap,
    );
  }
}
