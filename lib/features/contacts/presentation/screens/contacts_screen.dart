import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/models/contact.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/messaging/data/messaging_failure.dart';
import '../../../../features/messaging/data/messaging_providers.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';

class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(socialGraphProvider.notifier).refresh();
    });
  }

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
    final graph = ref.watch(socialGraphProvider);
    final contacts = ref
        .read(socialGraphProvider.notifier)
        .filterContacts(_searchController.text);
    final verified = contacts.where((c) => c.isVerified).toList();
    final pendingCount = graph.receivedRequests.length;

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                PokidokiSpacing.lg,
                PokidokiSpacing.sm,
                PokidokiSpacing.lg,
                PokidokiSpacing.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.navContacts,
                      style: typography.screenTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.qrMyCodeTitle,
                    onPressed: () => context.push(AppRoutes.myQrCode),
                    icon: Icon(Icons.qr_code_2_rounded, color: colors.primary),
                  ),
                  IconButton(
                    tooltip: l10n.usersFindSomeone,
                    onPressed: () => context.push(AppRoutes.userSearch),
                    icon: Icon(
                      Icons.person_add_alt_1_rounded,
                      color: colors.primary,
                    ),
                  ),
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
              child: contacts.isEmpty
                  ? _EmptyContacts(
                      onFindPeople: () => context.push(AppRoutes.userSearch),
                      onReviewRequests: () =>
                          context.push(AppRoutes.contactRequests),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(PokidokiSpacing.lg),
                      children: [
                        Material(
                          color: colors.surface,
                          borderRadius: PokidokiRadii.borderXl,
                          child: InkWell(
                            borderRadius: PokidokiRadii.borderXl,
                            onTap: () =>
                                context.push(AppRoutes.contactRequests),
                            child: Padding(
                              padding: const EdgeInsets.all(PokidokiSpacing.md),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person_add_rounded,
                                    color: colors.primary,
                                  ),
                                  const SizedBox(width: PokidokiSpacing.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.contactsRequestsTitle,
                                          style: typography.cardTitle,
                                        ),
                                        Text(
                                          l10n.contactsRequestsWaiting(
                                            pendingCount,
                                          ),
                                          style: typography.supportingBody,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (pendingCount > 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.primary,
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Text(
                                        '$pendingCount',
                                        style: typography.badge.copyWith(
                                          color: colors.onPrimary,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (verified.isNotEmpty) ...[
                          const SizedBox(height: PokidokiSpacing.xl),
                          Text(
                            l10n.contactsVerifiedSection,
                            style: typography.inputLabel,
                          ),
                          const SizedBox(height: PokidokiSpacing.sm),
                          ...verified.map((c) => _ContactRow(contact: c)),
                        ],
                        const SizedBox(height: PokidokiSpacing.xl),
                        Text(
                          l10n.contactsAllContacts,
                          style: typography.inputLabel,
                        ),
                        const SizedBox(height: PokidokiSpacing.sm),
                        ...contacts.map((c) => _ContactRow(contact: c)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends ConsumerWidget {
  const _ContactRow({required this.contact});

  final Contact contact;

  Future<void> _openChat(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    try {
      final conversation = await ref
          .read(conversationsProvider.notifier)
          .createOrGet(contact.id);
      if (context.mounted && conversation != null) {
        context.push(AppRoutes.chatPath(conversation.id));
      }
    } on MessagingFailure catch (failure) {
      if (!context.mounted) {
        return;
      }
      final message = switch (failure.messageKey) {
        'conversationContactRequired' => l10n.conversationContactRequired,
        'conversationUnavailable' => l10n.conversationUnavailable,
        'conversationSelfNotAllowed' => l10n.cannotMessageUser,
        _ => l10n.messagingUnavailable,
      };
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      trailing: IconButton(
        tooltip: l10n.usersMessage,
        onPressed: () => _openChat(context, ref),
        icon: const Icon(Icons.chat_bubble_outline_rounded),
      ),
      onTap: () => _openChat(context, ref),
    );
  }
}

class _EmptyContacts extends StatelessWidget {
  const _EmptyContacts({
    required this.onFindPeople,
    required this.onReviewRequests,
  });

  final VoidCallback onFindPeople;
  final VoidCallback onReviewRequests;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.contactsEmptyTitle, style: typography.sectionTitle),
            const SizedBox(height: PokidokiSpacing.xs),
            Text(
              l10n.contactsEmptyBody,
              style: typography.supportingBody,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            FilledButton(
              onPressed: onFindPeople,
              child: Text(l10n.usersFindPeople),
            ),
            TextButton(
              onPressed: onReviewRequests,
              child: Text(l10n.contactsReviewRequests),
            ),
          ],
        ),
      ),
    );
  }
}
