import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../data/models/message.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/messaging_providers.dart';
import '../widgets/chat_composer.dart';
import '../widgets/chat_message_bubble.dart';

class OneToOneChatScreen extends ConsumerStatefulWidget {
  const OneToOneChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  ConsumerState<OneToOneChatScreen> createState() => _OneToOneChatScreenState();
}

class _OneToOneChatScreenState extends ConsumerState<OneToOneChatScreen> {
  final _composer = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _composer.addListener(_onComposerChanged);
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(messagingProvider.notifier)
          .openConversation(widget.conversationId);
    });
  }

  void _onComposerChanged() {
    ref
        .read(messagingProvider.notifier)
        .onComposerChanged(widget.conversationId, _composer.text);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    if (_scrollController.position.pixels <= 80) {
      ref
          .read(messagingProvider.notifier)
          .loadOlderMessages(widget.conversationId);
    }
  }

  @override
  void dispose() {
    _composer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _timeLabel(DateTime sentAt) {
    final local = sentAt.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _send() async {
    final text = _composer.text;
    _composer.clear();
    await ref
        .read(messagingProvider.notifier)
        .sendTextMessage(widget.conversationId, text);
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _onMessageActions(ChatMessage message) async {
    final l10n = AppLocalizations.of(context);
    final action = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.reply_rounded),
              title: Text(l10n.chatReply),
              onTap: () => Navigator.pop(context, 'reply'),
            ),
            ListTile(
              leading: const Icon(Icons.copy_rounded),
              title: Text(l10n.chatCopy),
              onTap: () => Navigator.pop(context, 'copy'),
            ),
            if (message.isOutgoing)
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded),
                title: Text(l10n.chatDelete),
                onTap: () => Navigator.pop(context, 'delete'),
              ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: Text(l10n.chatMessageInfo),
              onTap: () => Navigator.pop(context, 'info'),
            ),
          ],
        ),
      ),
    );

    if (!mounted || action == null) {
      return;
    }
    final messaging = ref.read(messagingProvider.notifier);
    switch (action) {
      case 'reply':
        messaging.setReplyTo(message);
        setState(() {});
      case 'copy':
        await Clipboard.setData(ClipboardData(text: message.body));
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.chatMessageCopied)));
        }
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.chatDeleteTitle),
            content: Text(l10n.chatDeleteBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.actionCancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l10n.chatDeleteForMe),
              ),
            ],
          ),
        );
        if (confirmed == true) {
          messaging.deleteMessage(widget.conversationId, message.id);
        }
      case 'info':
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.chatMessageInfo),
            content: Text(
              '${l10n.chatSent}: ${_timeLabel(message.sentAt)}\n'
              '${l10n.chatDelivered}: ${_timeLabel(message.sentAt)}\n'
              '${l10n.chatRead}: ${_timeLabel(message.sentAt)}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.actionCancel),
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    ref.watch(socialGraphProvider);
    final messaging = ref.watch(messagingProvider);
    final conversation = ref
        .read(messagingProvider.notifier)
        .conversation(widget.conversationId);
    final messages = messaging.messagesFor(widget.conversationId);
    final verified = conversation == null
        ? false
        : ref
              .read(socialGraphProvider.notifier)
              .isContactVerified(conversation.peerId);
    final displayName = conversation?.peerDisplayName ?? 'Chat';
    final blocked = conversation?.isBlocked ?? false;
    final reply = messaging.replyTo;
    final isTyping = messaging.isPeerTyping;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          final notifier = ref.read(messagingProvider.notifier);
          if (notifier.mounted) {
            unawaited(notifier.closeConversation(widget.conversationId));
          }
        }
      },
      child: PokidokiScaffold(
        body: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PokidokiSpacing.xs,
                ),
                child: Row(
                  children: [
                    PokidokiIconButton(
                      icon: Icons.arrow_back_rounded,
                      tooltip: l10n.semanticBack,
                      onPressed: () => context.pop(),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => context.push(
                          AppRoutes.conversationInfoPath(widget.conversationId),
                        ),
                        child: Row(
                          children: [
                            PokidokiAvatar(displayName: displayName, size: 36),
                            const SizedBox(width: PokidokiSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          displayName,
                                          style: typography.cardTitle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (verified) ...[
                                        const SizedBox(
                                          width: PokidokiSpacing.xxs,
                                        ),
                                        PokidokiVerifiedBadge(
                                          semanticLabel: l10n.semanticVerified,
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    verified
                                        ? l10n.semanticVerified
                                        : l10n.verifyNotVerified,
                                    style: typography.caption,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.chatSearchInConversation,
                      onPressed: () => context.push(
                        AppRoutes.conversationSearchPath(widget.conversationId),
                      ),
                      icon: const Icon(Icons.search_rounded),
                    ),
                    IconButton(
                      tooltip: l10n.chatConversationInfo,
                      onPressed: () => context.push(
                        AppRoutes.conversationInfoPath(widget.conversationId),
                      ),
                      icon: const Icon(Icons.info_outline_rounded),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PokidokiSpacing.lg,
              ),
              child: Row(
                children: [
                  Icon(Icons.lock_rounded, size: 14, color: colors.secure),
                  const SizedBox(width: PokidokiSpacing.xs),
                  Expanded(
                    child: Text(
                      l10n.chatProtectedBanner,
                      style: typography.caption,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(PokidokiSpacing.lg),
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: PokidokiSpacing.md,
                      ),
                      child: Center(
                        child: Text(l10n.chatToday, style: typography.caption),
                      ),
                    );
                  }
                  final message = messages[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: PokidokiSpacing.sm),
                    child: ChatMessageBubble(
                      message: message,
                      timeLabel: _timeLabel(message.sentAt),
                      onLongPress: () => _onMessageActions(message),
                    ),
                  );
                },
              ),
            ),
            if (isTyping)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PokidokiSpacing.lg,
                  vertical: PokidokiSpacing.xs,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(l10n.chatPeerTyping, style: typography.caption),
                ),
              ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _composer,
              builder: (context, value, child) {
                return ChatComposer(
                  controller: _composer,
                  enabled: !blocked,
                  disabledNotice: blocked
                      ? l10n.chatBlockedNotice(displayName.split(' ').first)
                      : null,
                  replyPreview: reply?.body,
                  onCancelReply: () {
                    ref.read(messagingProvider.notifier).setReplyTo(null);
                  },
                  onAttach: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.chatAttachmentLater)),
                    );
                  },
                  onSend: _send,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
