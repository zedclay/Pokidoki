import 'package:flutter/material.dart';

import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/models/message.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.timeLabel,
    required this.onLongPress,
  });

  final ChatMessage message;
  final String timeLabel;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageContentType.system) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: PokidokiSpacing.sm),
        child: Center(
          child: Text(
            message.body,
            style: context.pokidokiTypography.caption,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final outgoing = message.isOutgoing;
    final background = outgoing ? colors.primary : colors.surfaceElevated;
    final foreground = outgoing ? colors.onPrimary : colors.textPrimary;

    return Align(
      alignment: outgoing
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        child: GestureDetector(
          onLongPress: onLongPress,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              borderRadius: PokidokiRadii.borderChatBubble,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PokidokiSpacing.md,
                vertical: PokidokiSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.replyPreview != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(PokidokiSpacing.xs),
                      decoration: BoxDecoration(
                        color: foreground.withValues(alpha: 0.12),
                        borderRadius: PokidokiRadii.borderSm,
                      ),
                      child: Text(
                        message.replyPreview!,
                        style: typography.caption.copyWith(color: foreground),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                  ],
                  if (message.type == MessageContentType.file)
                    Row(
                      children: [
                        Icon(Icons.description_rounded, color: foreground),
                        const SizedBox(width: PokidokiSpacing.xs),
                        Expanded(
                          child: Text(
                            message.attachmentName ?? message.body,
                            style: typography.chatMessage.copyWith(
                              color: foreground,
                            ),
                          ),
                        ),
                      ],
                    )
                  else if (message.type == MessageContentType.link)
                    LtrText(
                      message.body,
                      style: typography.chatMessage.copyWith(
                        color: foreground,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  else
                    Text(
                      message.body,
                      style: typography.chatMessage.copyWith(color: foreground),
                    ),
                  const SizedBox(height: PokidokiSpacing.xxs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LtrText(
                        timeLabel,
                        style: typography.caption.copyWith(
                          color: foreground.withValues(alpha: 0.8),
                        ),
                      ),
                      if (outgoing) ...[
                        const SizedBox(width: PokidokiSpacing.xxs),
                        Icon(
                          _deliveryIcon(message.deliveryStatus),
                          size: 14,
                          color: foreground.withValues(alpha: 0.8),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _deliveryIcon(MessageDeliveryStatus status) {
    return switch (status) {
      MessageDeliveryStatus.sending => Icons.schedule_rounded,
      MessageDeliveryStatus.sent => Icons.done_rounded,
      MessageDeliveryStatus.delivered ||
      MessageDeliveryStatus.read => Icons.done_all_rounded,
      MessageDeliveryStatus.failed => Icons.error_outline_rounded,
    };
  }
}
