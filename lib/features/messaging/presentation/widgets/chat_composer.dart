import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';

class ChatComposer extends StatelessWidget {
  const ChatComposer({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttach,
    this.replyPreview,
    this.onCancelReply,
    this.enabled = true,
    this.disabledNotice,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;
  final String? replyPreview;
  final VoidCallback? onCancelReply;
  final bool enabled;
  final String? disabledNotice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final canSend = enabled && controller.text.trim().isNotEmpty;

    return Material(
      color: colors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            PokidokiSpacing.sm,
            PokidokiSpacing.xs,
            PokidokiSpacing.sm,
            PokidokiSpacing.sm,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (replyPreview != null)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: PokidokiSpacing.xs),
                  padding: const EdgeInsets.all(PokidokiSpacing.sm),
                  decoration: BoxDecoration(
                    color: colors.surfaceElevated,
                    borderRadius: PokidokiRadii.borderMd,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          replyPreview!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: typography.caption,
                        ),
                      ),
                      IconButton(
                        onPressed: onCancelReply,
                        icon: const Icon(Icons.close_rounded, size: 18),
                      ),
                    ],
                  ),
                ),
              if (!enabled && disabledNotice != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: PokidokiSpacing.xs),
                  child: Text(disabledNotice!, style: typography.caption),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: l10n.chatAttach,
                    onPressed: enabled ? onAttach : null,
                    icon: Icon(Icons.add_rounded, color: colors.primary),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      enabled: enabled,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: l10n.chatTypeMessage,
                        filled: true,
                        fillColor: colors.surfaceElevated,
                        border: const OutlineInputBorder(
                          borderRadius: PokidokiRadii.borderXl,
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: PokidokiSpacing.xs),
                  IconButton.filled(
                    onPressed: canSend ? onSend : null,
                    style: IconButton.styleFrom(
                      backgroundColor: canSend
                          ? colors.primary
                          : colors.surfaceSecondary,
                      foregroundColor: colors.onPrimary,
                    ),
                    tooltip: l10n.chatSend,
                    icon: const Icon(Icons.send_rounded),
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
