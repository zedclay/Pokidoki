import 'package:flutter/material.dart';

import '../../colors/pokidoki_colors.dart';
import '../../radii/pokidoki_radii.dart';
import '../../spacing/pokidoki_spacing.dart';
import '../../typography/pokidoki_typography.dart';

/// Foundation widgets for future messaging screens.
class PokidokiChatBubble extends StatelessWidget {
  const PokidokiChatBubble.incoming({
    super.key,
    required this.message,
    this.metadata,
  }) : isOutgoing = false;

  const PokidokiChatBubble.outgoing({
    super.key,
    required this.message,
    this.metadata,
  }) : isOutgoing = true;

  final String message;
  final String? metadata;
  final bool isOutgoing;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final background = isOutgoing ? colors.primary : colors.surfaceElevated;
    final foreground = isOutgoing ? colors.onPrimary : colors.textPrimary;

    return Align(
      alignment: isOutgoing
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
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
                Text(
                  message,
                  style: typography.chatMessage.copyWith(color: foreground),
                ),
                if (metadata != null) ...[
                  const SizedBox(height: PokidokiSpacing.xxs),
                  PokidokiMessageMetadata(
                    label: metadata!,
                    color: isOutgoing
                        ? foreground.withValues(alpha: 0.8)
                        : colors.textTertiary,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PokidokiMessageMetadata extends StatelessWidget {
  const PokidokiMessageMetadata({super.key, required this.label, this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(label, style: typography.metadata.copyWith(color: color)),
    );
  }
}

class PokidokiDateSeparator extends StatelessWidget {
  const PokidokiDateSeparator({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PokidokiSpacing.sm),
      child: Center(child: Text(label, style: typography.caption)),
    );
  }
}

class PokidokiTypingIndicator extends StatelessWidget {
  const PokidokiTypingIndicator({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return Row(
      children: [
        Icon(Icons.more_horiz_rounded, color: colors.textTertiary),
        const SizedBox(width: PokidokiSpacing.xs),
        Text(label, style: typography.caption),
      ],
    );
  }
}

class PokidokiComposerShell extends StatelessWidget {
  const PokidokiComposerShell({super.key, required this.child, this.trailing});

  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.sm),
          child: Row(
            children: [
              Expanded(child: child),
              if (trailing != null) ...[
                const SizedBox(width: PokidokiSpacing.xs),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
