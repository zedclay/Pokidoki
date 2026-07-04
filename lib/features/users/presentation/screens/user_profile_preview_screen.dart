import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/models/user_profile_preview.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';

class UserProfilePreviewScreen extends ConsumerStatefulWidget {
  const UserProfilePreviewScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<UserProfilePreviewScreen> createState() =>
      _UserProfilePreviewScreenState();
}

class _UserProfilePreviewScreenState
    extends ConsumerState<UserProfilePreviewScreen> {
  bool _sending = false;

  Future<void> _sendRequest() async {
    setState(() => _sending = true);
    final ok = await ref
        .read(socialGraphProvider.notifier)
        .sendContactRequest(widget.userId);
    if (!mounted) {
      return;
    }
    setState(() => _sending = false);
    if (ok) {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.usersRequestSent)));
    }
  }

  Future<void> _block(UserProfilePreview profile) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.usersBlockTitle(profile.displayName)),
        content: Text(l10n.usersBlockBody(profile.displayName)),
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
    if (confirmed == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.usersBlocked)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    ref.watch(socialGraphProvider);
    final profile = ref
        .read(socialGraphProvider.notifier)
        .profileFor(widget.userId);

    if (profile == null) {
      return PokidokiScaffold(
        body: Center(child: Text(l10n.usersNoResultsTitle)),
      );
    }

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
                      l10n.usersProfileTitle,
                      textAlign: TextAlign.center,
                      style: typography.sectionTitle,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'report') {
                        context.push(AppRoutes.reportUserPath(widget.userId));
                      } else if (value == 'block') {
                        _block(profile);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'block',
                        child: Text(l10n.usersBlockAction),
                      ),
                      PopupMenuItem(
                        value: 'report',
                        child: Text(l10n.usersReportAction),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(PokidokiSpacing.lg),
                children: [
                  Center(
                    child: PokidokiAvatar(
                      displayName: profile.displayName,
                      size: 96,
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  Text(
                    profile.displayName,
                    style: typography.screenTitle,
                    textAlign: TextAlign.center,
                  ),
                  LtrText(
                    '@${profile.username}',
                    style: typography.supportingBody,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LtrText(profile.pokidokiId, style: typography.caption),
                      IconButton(
                        tooltip: l10n.usersCopyId,
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: profile.pokidokiId),
                          );
                        },
                        icon: const Icon(Icons.copy_rounded, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  _InfoCard(
                    icon: Icons.person_off_outlined,
                    title: profile.relationship == ProfileRelationship.contact
                        ? l10n.usersInContacts
                        : profile.relationship ==
                              ProfileRelationship.pendingOutgoing
                        ? l10n.usersRequestPending
                        : l10n.usersNotInContacts,
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  _InfoCard(
                    icon: Icons.shield_outlined,
                    title: profile.isVerified
                        ? l10n.semanticVerified
                        : l10n.usersNotVerified,
                    subtitle: profile.isVerified
                        ? null
                        : l10n.usersVerifyBeforeSensitive,
                  ),
                  if (profile.bio != null) ...[
                    const SizedBox(height: PokidokiSpacing.lg),
                    Text(l10n.usersAbout, style: typography.inputLabel),
                    const SizedBox(height: PokidokiSpacing.xs),
                    Text(profile.bio!, style: typography.body),
                  ],
                  if (profile.sharedContext != null) ...[
                    const SizedBox(height: PokidokiSpacing.lg),
                    Text(l10n.usersSharedContext, style: typography.inputLabel),
                    const SizedBox(height: PokidokiSpacing.xs),
                    Text(
                      profile.sharedContext!,
                      style: typography.supportingBody,
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(PokidokiSpacing.lg),
              child: profile.relationship == ProfileRelationship.contact
                  ? PokidokiButton.primary(
                      label: l10n.usersMessage,
                      onPressed: () =>
                          context.push(AppRoutes.chatPath('conv-amira')),
                    )
                  : PokidokiButton.primary(
                      label:
                          profile.relationship ==
                              ProfileRelationship.pendingOutgoing
                          ? l10n.usersRequestPending
                          : l10n.usersSendRequest,
                      isLoading: _sending,
                      onPressed:
                          profile.relationship == ProfileRelationship.none &&
                              !_sending
                          ? _sendRequest
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.title, this.subtitle});

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: PokidokiRadii.borderXl,
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.md),
        child: Row(
          children: [
            Icon(icon, color: colors.textSecondary),
            const SizedBox(width: PokidokiSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: typography.cardTitle),
                  if (subtitle != null)
                    Text(subtitle!, style: typography.supportingBody),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
