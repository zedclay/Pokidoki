import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/models/contact.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';

class NewConversationScreen extends ConsumerStatefulWidget {
  const NewConversationScreen({super.key});

  @override
  ConsumerState<NewConversationScreen> createState() =>
      _NewConversationScreenState();
}

class _NewConversationScreenState extends ConsumerState<NewConversationScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final contacts = ref
        .read(socialGraphProvider.notifier)
        .filterContacts(_searchController.text);
    final recent = contacts.take(3).toList();

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
                      l10n.chatsNewConversation,
                      textAlign: TextAlign.center,
                      style: typography.sectionTitle,
                    ),
                  ),
                  const SizedBox(width: PokidokiSpacing.minTouchTarget),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PokidokiSpacing.lg,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: l10n.contactsSearchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(PokidokiSpacing.lg),
                children: [
                  _ActionTile(
                    icon: Icons.person_search_rounded,
                    title: l10n.usersFindSomeone,
                    subtitle: l10n.usersSearchByUsernameOrId,
                    onTap: () => context.push(AppRoutes.userSearch),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  _ActionTile(
                    icon: Icons.qr_code_scanner_rounded,
                    title: l10n.usersScanQr,
                    subtitle: l10n.usersScanQrSubtitle,
                    onTap: () => context.push(AppRoutes.qrScanner),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  _ActionTile(
                    icon: Icons.group_add_rounded,
                    title: l10n.usersNewGroup,
                    subtitle: l10n.usersNewGroupSubtitle,
                    trailing: Text(
                      l10n.usersComingLater,
                      style: typography.caption.copyWith(color: colors.primary),
                    ),
                    onTap: null,
                  ),
                  const SizedBox(height: PokidokiSpacing.xl),
                  Text(l10n.chatsRecentContacts, style: typography.inputLabel),
                  const SizedBox(height: PokidokiSpacing.sm),
                  ...recent.map((c) => _ContactTile(contact: c)),
                  const SizedBox(height: PokidokiSpacing.xl),
                  Text(l10n.contactsAllContacts, style: typography.inputLabel),
                  const SizedBox(height: PokidokiSpacing.sm),
                  ...contacts.map((c) => _ContactTile(contact: c)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return Material(
      color: colors.surface,
      borderRadius: PokidokiRadii.borderXl,
      child: InkWell(
        borderRadius: PokidokiRadii.borderXl,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.md),
          child: Row(
            children: [
              Icon(icon, color: colors.primary),
              const SizedBox(width: PokidokiSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: typography.cardTitle),
                    Text(subtitle, style: typography.supportingBody),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: PokidokiAvatar(displayName: contact.displayName),
      title: Row(
        children: [
          Flexible(
            child: Text(contact.displayName, style: typography.cardTitle),
          ),
          if (contact.isVerified) ...[
            const SizedBox(width: PokidokiSpacing.xxs),
            PokidokiVerifiedBadge(semanticLabel: l10n.semanticVerified),
          ],
        ],
      ),
      subtitle: LtrText(
        '@${contact.username}',
        style: typography.supportingBody,
      ),
      onTap: () => context.push(
        AppRoutes.chatPath('conv-${contact.id.replaceFirst('c-', '')}'),
      ),
    );
  }
}
