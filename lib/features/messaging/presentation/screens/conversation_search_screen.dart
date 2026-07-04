import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/messaging_controller.dart';

class ConversationSearchScreen extends ConsumerStatefulWidget {
  const ConversationSearchScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  ConsumerState<ConversationSearchScreen> createState() =>
      _ConversationSearchScreenState();
}

class _ConversationSearchScreenState
    extends ConsumerState<ConversationSearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  int _currentIndex = 0;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    final conversation = ref
        .read(messagingProvider.notifier)
        .conversation(widget.conversationId);
    final results = ref
        .read(messagingProvider.notifier)
        .searchMessages(widget.conversationId, _controller.text);
    final query = _controller.text.trim();

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
                      conversation?.peerDisplayName ??
                          l10n.chatSearchInConversation,
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
                autofocus: true,
                onChanged: (value) {
                  _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 250), () {
                    setState(() => _currentIndex = 0);
                  });
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: l10n.chatSearchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: query.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _controller.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                ),
              ),
            ),
            if (query.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(PokidokiSpacing.md),
                child: Text(
                  results.isEmpty
                      ? l10n.chatNoMessagesFound
                      : l10n.chatSearchResultCount(results.length),
                  style: typography.caption,
                ),
              ),
            Expanded(
              child: query.isEmpty
                  ? Center(
                      child: Text(
                        l10n.chatSearchInitial,
                        style: typography.supportingBody,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : results.isEmpty
                  ? Center(
                      child: Text(
                        l10n.chatNoMessagesFoundBody,
                        style: typography.supportingBody,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final message = results[index];
                        final selected = index == _currentIndex;
                        return ListTile(
                          selected: selected,
                          title: Text(message.body, maxLines: 2),
                          subtitle: Text(
                            message.isOutgoing
                                ? l10n.chatsYouPrefix.trim()
                                : (conversation?.peerDisplayName ?? ''),
                          ),
                          onTap: () => context.pop(message.id),
                        );
                      },
                    ),
            ),
            if (results.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(PokidokiSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_currentIndex + 1} / ${results.length}'),
                    IconButton(
                      onPressed: _currentIndex == 0
                          ? null
                          : () => setState(() => _currentIndex -= 1),
                      icon: const Icon(Icons.keyboard_arrow_up_rounded),
                    ),
                    IconButton(
                      onPressed: _currentIndex >= results.length - 1
                          ? null
                          : () => setState(() => _currentIndex += 1),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
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
