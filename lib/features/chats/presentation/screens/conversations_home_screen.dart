import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../app/routing/route_names.dart';
import '../../../../data/models/conversation.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/messaging/data/messaging_providers.dart';
import '../../../../features/messaging/presentation/messaging_error_messages.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/conversation_row.dart';

class ConversationsHomeScreen extends ConsumerStatefulWidget {
  const ConversationsHomeScreen({super.key});

  @override
  ConsumerState<ConversationsHomeScreen> createState() =>
      _ConversationsHomeScreenState();
}

class _ConversationsHomeScreenState
    extends ConsumerState<ConversationsHomeScreen>
    with WidgetsBindingObserver {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _searchOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshConversations();
    });
  }

  void _refreshConversations() {
    ref.read(messagingProvider);
    ref.read(conversationsProvider.notifier).loadInitial();
    unawaited(
      ref.read(messagingSocketCoordinatorProvider).connectIfAuthenticated(),
    );
    unawaited(ref.read(messagingOfflineCoordinatorProvider).onForeground());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshConversations();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      ref.read(conversationsProvider.notifier).loadMore();
    }
  }

  String _timeLabel(BuildContext context, Conversation conversation) {
    final l10n = AppLocalizations.of(context);
    final local = conversation.updatedAt.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(local.year, local.month, local.day);
    if (day == today) {
      final hour = local.hour.toString().padLeft(2, '0');
      final minute = local.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    }
    if (day == today.subtract(const Duration(days: 1))) {
      return l10n.chatsYesterday;
    }
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[local.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final conversationsState = ref.watch(conversationsProvider);
    ref.watch(messagingProvider);
    final query = _searchController.text;
    final conversations = ref
        .read(conversationsProvider.notifier)
        .filter(query);
    final pinned = conversations.where((c) => c.isPinned).toList();
    final recent = conversations.where((c) => !c.isPinned).toList();

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
                  const PokidokiAvatar(displayName: 'Zed Clay', size: 40),
                  const SizedBox(width: PokidokiSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.navChats,
                      style: typography.screenTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.semanticSearch,
                    onPressed: () => setState(() => _searchOpen = !_searchOpen),
                    icon: Icon(Icons.search_rounded, color: colors.textPrimary),
                  ),
                ],
              ),
            ),
            if (_searchOpen)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PokidokiSpacing.lg,
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: l10n.chatsSearchHint,
                    prefixIcon: const Icon(Icons.search_rounded),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(PokidokiSpacing.lg),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: PokidokiRadii.borderXl,
                  border: Border.all(color: colors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(PokidokiSpacing.md),
                  child: Row(
                    children: [
                      Icon(Icons.lock_rounded, color: colors.secure, size: 18),
                      const SizedBox(width: PokidokiSpacing.sm),
                      Expanded(
                        child: Text(
                          l10n.chatsProtectedBanner,
                          style: typography.caption,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (conversationsState.isLoading && conversations.isEmpty)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (conversationsState.errorKey != null &&
                conversations.isEmpty)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(PokidokiSpacing.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          messagingErrorMessage(
                            l10n,
                            conversationsState.errorKey,
                          ),
                          style: typography.supportingBody,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: PokidokiSpacing.md),
                        FilledButton(
                          onPressed: () => ref
                              .read(conversationsProvider.notifier)
                              .refresh(),
                          child: Text(l10n.actionRetry),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () =>
                      ref.read(conversationsProvider.notifier).refresh(),
                  child: conversations.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            _EmptyConversations(
                              onNewConversation: () =>
                                  context.push(AppRoutes.newConversation),
                            ),
                          ],
                        )
                      : ListView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            if (pinned.isNotEmpty) ...[
                              _SectionLabel(label: l10n.chatsPinned),
                              ...pinned.map(
                                (c) => ConversationRow(
                                  conversation: c,
                                  timeLabel: _timeLabel(context, c),
                                  onTap: () =>
                                      context.push(AppRoutes.chatPath(c.id)),
                                ),
                              ),
                            ],
                            if (recent.isNotEmpty) ...[
                              _SectionLabel(label: l10n.chatsRecent),
                              ...recent.map(
                                (c) => ConversationRow(
                                  conversation: c,
                                  timeLabel: _timeLabel(context, c),
                                  onTap: () =>
                                      context.push(AppRoutes.chatPath(c.id)),
                                ),
                              ),
                            ],
                            if (conversationsState.isLoadingMore)
                              const Padding(
                                padding: EdgeInsets.all(PokidokiSpacing.md),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          ],
                        ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.newConversation),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        tooltip: l10n.chatsNewConversation,
        child: const Icon(Icons.edit_square),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        PokidokiSpacing.lg,
        PokidokiSpacing.sm,
        PokidokiSpacing.lg,
        PokidokiSpacing.xs,
      ),
      child: Text(
        label,
        style: context.pokidokiTypography.caption.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyConversations extends StatelessWidget {
  const _EmptyConversations({required this.onNewConversation});

  final VoidCallback onNewConversation;

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
            Text(l10n.chatsEmptyTitle, style: typography.sectionTitle),
            const SizedBox(height: PokidokiSpacing.xxs),
            Text(
              l10n.chatsEmptyBody,
              style: typography.supportingBody,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.lg),
            FilledButton(
              onPressed: onNewConversation,
              child: Text(l10n.chatsNewConversation),
            ),
          ],
        ),
      ),
    );
  }
}
