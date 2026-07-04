import 'package:flutter/material.dart';

import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/models/conversation.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';

class ConversationRow extends StatelessWidget {
  const ConversationRow({
    super.key,
    required this.conversation,
    required this.timeLabel,
    required this.onTap,
  });

  final Conversation conversation;
  final String timeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final l10n = AppLocalizations.of(context);
    final preview = conversation.isOutgoingPreview
        ? '${l10n.chatsYouPrefix}${conversation.lastMessagePreview ?? ''}'
        : (conversation.lastMessagePreview ?? '');

    return Semantics(
      button: true,
      label:
          '${conversation.peerDisplayName}. $preview. $timeLabel'
          '${conversation.unreadCount > 0 ? '. ${l10n.chatsUnreadCount(conversation.unreadCount)}' : ''}'
          '${conversation.isPeerVerified ? '. ${l10n.semanticVerified}' : ''}',
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PokidokiSpacing.lg,
            vertical: PokidokiSpacing.md,
          ),
          child: Row(
            children: [
              PokidokiAvatar(displayName: conversation.peerDisplayName),
              const SizedBox(width: PokidokiSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.peerDisplayName,
                            style: typography.cardTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        if (conversation.isPeerVerified) ...[
                          const SizedBox(width: PokidokiSpacing.xxs),
                          PokidokiVerifiedBadge(
                            semanticLabel: l10n.semanticVerified,
                          ),
                        ],
                        if (conversation.isPinned) ...[
                          const SizedBox(width: PokidokiSpacing.xxs),
                          Icon(
                            Icons.push_pin_rounded,
                            size: 14,
                            color: colors.textTertiary,
                          ),
                        ],
                        if (conversation.isMuted) ...[
                          const SizedBox(width: PokidokiSpacing.xxs),
                          Icon(
                            Icons.notifications_off_rounded,
                            size: 14,
                            color: colors.textTertiary,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: PokidokiSpacing.xxs),
                    Text(
                      preview,
                      style: typography.supportingBody,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: PokidokiSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LtrText(timeLabel, style: typography.caption),
                  if (conversation.unreadCount > 0) ...[
                    const SizedBox(height: PokidokiSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${conversation.unreadCount}',
                        style: typography.badge.copyWith(
                          color: colors.onPrimary,
                        ),
                      ),
                    ),
                  ] else if (conversation.disappearingMessagesEnabled)
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: colors.textTertiary,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
