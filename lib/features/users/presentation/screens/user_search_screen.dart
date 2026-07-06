import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';

class UserSearchScreen extends ConsumerStatefulWidget {
  const UserSearchScreen({super.key});

  @override
  ConsumerState<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends ConsumerState<UserSearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(socialGraphProvider.notifier).searchUsers(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                      l10n.usersFindSomeone,
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
                controller: _controller,
                onChanged: _onChanged,
                decoration: InputDecoration(
                  hintText: l10n.usersSearchByUsernameOrId,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            ref
                                .read(socialGraphProvider.notifier)
                                .searchUsers('');
                            setState(() {});
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                ),
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (_controller.text.trim().isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.xl),
                        child: Text(
                          l10n.usersSearchInitial,
                          style: typography.supportingBody,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  if (graph.isSearching && graph.searchResults.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (graph.searchResults.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(PokidokiSpacing.xl),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.usersNoResultsTitle,
                              style: typography.sectionTitle,
                            ),
                            const SizedBox(height: PokidokiSpacing.xs),
                            Text(
                              l10n.usersNoResultsBody,
                              style: typography.supportingBody,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(PokidokiSpacing.lg),
                    itemCount: graph.searchResults.length,
                    itemBuilder: (context, index) {
                      final user = graph.searchResults[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              context.push(AppRoutes.userProfilePath(user.id)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: PokidokiSpacing.sm,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PokidokiAvatar(displayName: user.displayName),
                                const SizedBox(width: PokidokiSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.displayName,
                                        style: typography.cardTitle,
                                      ),
                                      LtrText(
                                        '@${user.username}',
                                        style: typography.supportingBody,
                                      ),
                                      LtrText(
                                        user.pokidokiId,
                                        style: typography.caption,
                                      ),
                                      if (user.bio != null)
                                        Text(
                                          user.bio!,
                                          style: typography.caption,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
