import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/models/contact_request.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';

class ContactRequestsScreen extends ConsumerStatefulWidget {
  const ContactRequestsScreen({super.key});

  @override
  ConsumerState<ContactRequestsScreen> createState() =>
      _ContactRequestsScreenState();
}

class _ContactRequestsScreenState extends ConsumerState<ContactRequestsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    Future<void>.microtask(
      () => ref.read(socialGraphProvider.notifier).refresh(),
    );
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _accept(ContactRequest request) async {
    await ref.read(socialGraphProvider.notifier).acceptRequest(request.id);
    if (!mounted) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.contactsRequestAccepted)));
  }

  Future<void> _decline(ContactRequest request) async {
    await ref.read(socialGraphProvider.notifier).declineRequest(request.id);
    if (!mounted) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.contactsRequestDeclined)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final graph = ref.watch(socialGraphProvider);

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
                      l10n.contactsRequestsTitle,
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
              child: Text(l10n.contactsRequestsInfo, style: typography.caption),
            ),
            TabBar(
              controller: _tabs,
              labelColor: colors.primary,
              unselectedLabelColor: colors.textTertiary,
              tabs: [
                Tab(text: l10n.contactsReceived),
                Tab(text: l10n.contactsSent),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: [
                  _RequestList(
                    requests: graph.receivedRequests,
                    emptyLabel: l10n.contactsNoReceivedRequests,
                    itemBuilder: (request) => _ReceivedCard(
                      request: request,
                      onAccept: () => _accept(request),
                      onDecline: () => _decline(request),
                      onProfile: () => context.push(
                        AppRoutes.userProfilePath(request.userId),
                      ),
                    ),
                  ),
                  _RequestList(
                    requests: graph.sentRequests,
                    emptyLabel: l10n.contactsNoSentRequests,
                    itemBuilder: (request) => _SentCard(
                      request: request,
                      onCancel: () async {
                        await ref
                            .read(socialGraphProvider.notifier)
                            .cancelSentRequest(request.id);
                      },
                    ),
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

class _RequestList extends StatelessWidget {
  const _RequestList({
    required this.requests,
    required this.emptyLabel,
    required this.itemBuilder,
  });

  final List<ContactRequest> requests;
  final String emptyLabel;
  final Widget Function(ContactRequest request) itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Center(child: Text(emptyLabel));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(PokidokiSpacing.lg),
      itemCount: requests.length,
      separatorBuilder: (_, _) => const SizedBox(height: PokidokiSpacing.md),
      itemBuilder: (context, index) => itemBuilder(requests[index]),
    );
  }
}

class _ReceivedCard extends StatelessWidget {
  const _ReceivedCard({
    required this.request,
    required this.onAccept,
    required this.onDecline,
    required this.onProfile,
  });

  final ContactRequest request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PokidokiAvatar(displayName: request.displayName),
                const SizedBox(width: PokidokiSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.displayName, style: typography.cardTitle),
                      LtrText(
                        '@${request.username}',
                        style: typography.supportingBody,
                      ),
                      LtrText(request.pokidokiId, style: typography.caption),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onProfile,
                  icon: const Icon(Icons.more_horiz_rounded),
                ),
              ],
            ),
            if (request.bio != null) ...[
              const SizedBox(height: PokidokiSpacing.sm),
              Text('"${request.bio}"', style: typography.supportingBody),
            ],
            const SizedBox(height: PokidokiSpacing.md),
            Row(
              children: [
                Expanded(
                  child: PokidokiButton.primary(
                    label: l10n.contactsAccept,
                    onPressed: onAccept,
                  ),
                ),
                const SizedBox(width: PokidokiSpacing.sm),
                Expanded(
                  child: PokidokiButton.secondary(
                    label: l10n.contactsDecline,
                    onPressed: onDecline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SentCard extends StatelessWidget {
  const _SentCard({required this.request, required this.onCancel});

  final ContactRequest request;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: PokidokiAvatar(displayName: request.displayName),
      title: Text(request.displayName, style: typography.cardTitle),
      subtitle: LtrText(
        '@${request.username}',
        style: typography.supportingBody,
      ),
      trailing: TextButton(
        onPressed: onCancel,
        child: Text(l10n.contactsCancelRequest),
      ),
    );
  }
}
