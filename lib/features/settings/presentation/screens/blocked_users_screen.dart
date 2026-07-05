import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/models/blocked_user.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../social/presentation/controllers/social_graph_controller.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_section_card.dart';

class BlockedUsersScreen extends ConsumerStatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  ConsumerState<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends ConsumerState<BlockedUsersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(socialGraphProvider.notifier).loadBlockedUsers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final graph = ref.watch(socialGraphProvider);
    final blocked = graph.blockedUsers;

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsBlockedUsers),
            Expanded(
              child: graph.isLoadingBlocked
                  ? const Center(child: CircularProgressIndicator())
                  : graph.blockedError
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l10n.settingsBlockedUsersError),
                          TextButton(
                            onPressed: () => ref
                                .read(socialGraphProvider.notifier)
                                .loadBlockedUsers(),
                            child: Text(l10n.actionTryAgain),
                          ),
                        ],
                      ),
                    )
                  : ListView(
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
                                  Icon(
                                    Icons.block_rounded,
                                    color: colors.textSecondary,
                                  ),
                                  const SizedBox(width: PokidokiSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      l10n.settingsBlockedUsersInfo,
                                      style: typography.supportingBody,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: PokidokiSpacing.md),
                        Text(
                          l10n.settingsBlockedUsersCount(blocked.length),
                          style: typography.caption.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: PokidokiSpacing.sm),
                        if (blocked.isEmpty)
                          SettingsSectionCard(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                  PokidokiSpacing.md,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.settingsNoBlockedUsers,
                                      style: typography.cardTitle,
                                    ),
                                    Text(
                                      l10n.settingsNoBlockedUsersBody,
                                      style: typography.supportingBody,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          SettingsSectionCard(
                            children: [
                              for (final user in blocked)
                                BlockedUserRow(
                                  user: user,
                                  onUnblock: () => _confirmUnblock(user),
                                ),
                            ],
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmUnblock(BlockedUser user) async {
    final l10n = AppLocalizations.of(context);
    final firstName = user.displayName.split(' ').first;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsUnblockTitle(firstName)),
        content: Text(l10n.settingsUnblockBody(firstName)),
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
    if (confirmed == true && mounted) {
      await ref.read(socialGraphProvider.notifier).unblockUser(user.id);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsUnblockedSnack(firstName))),
      );
    }
  }
}

class BlockedUserRow extends StatelessWidget {
  const BlockedUserRow({
    super.key,
    required this.user,
    required this.onUnblock,
  });

  final BlockedUser user;
  final VoidCallback onUnblock;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return Semantics(
      label: '${user.displayName}, @${user.username}',
      child: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.md),
        child: Row(
          children: [
            PokidokiAvatar(displayName: user.displayName, size: 48),
            const SizedBox(width: PokidokiSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.displayName, style: typography.cardTitle),
                  LtrText(
                    '@${user.username}',
                    style: typography.supportingBody,
                  ),
                  LtrText(user.pokidokiId, style: typography.caption),
                ],
              ),
            ),
            TextButton(
              onPressed: onUnblock,
              child: Text(
                l10n.settingsUnblockAction,
                style: typography.button.copyWith(color: colors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
