import 'package:flutter/material.dart';

import '../../colors/pokidoki_colors.dart';
import '../../radii/pokidoki_radii.dart';
import '../../spacing/pokidoki_spacing.dart';
import '../../typography/pokidoki_typography.dart';
import '../buttons/pokidoki_buttons.dart';

abstract final class PokidokiSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    final colors = context.pokidokiColors;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colors.error : colors.surfaceElevated,
      ),
    );
  }
}

class PokidokiLoadingSkeleton extends StatelessWidget {
  const PokidokiLoadingSkeleton({super.key, this.height = 16, this.width});

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return Semantics(
      label: 'Loading',
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: colors.surfaceSecondary,
          borderRadius: PokidokiRadii.borderSm,
        ),
      ),
    );
  }
}

class PokidokiEmptyState extends StatelessWidget {
  const PokidokiEmptyState({
    super.key,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    final colors = context.pokidokiColors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_rounded, size: 40, color: colors.textTertiary),
            const SizedBox(height: PokidokiSpacing.md),
            Text(
              title,
              style: typography.sectionTitle,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: PokidokiSpacing.xs),
              Text(
                message!,
                style: typography.supportingBody,
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: PokidokiSpacing.lg),
              PokidokiButton.secondary(
                label: actionLabel!,
                onPressed: onAction,
                expanded: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PokidokiErrorState extends StatelessWidget {
  const PokidokiErrorState({
    super.key,
    required this.title,
    this.message,
    this.retryLabel,
    this.onRetry,
  });

  final String title;
  final String? message;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    final colors = context.pokidokiColors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 40, color: colors.error),
            const SizedBox(height: PokidokiSpacing.md),
            Text(
              title,
              style: typography.sectionTitle,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: PokidokiSpacing.xs),
              Text(
                message!,
                style: typography.supportingBody,
                textAlign: TextAlign.center,
              ),
            ],
            if (retryLabel != null && onRetry != null) ...[
              const SizedBox(height: PokidokiSpacing.lg),
              PokidokiButton.primary(
                label: retryLabel!,
                onPressed: onRetry,
                expanded: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PokidokiOfflineBanner extends StatelessWidget {
  const PokidokiOfflineBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return Semantics(
      liveRegion: true,
      child: Material(
        color: colors.warning.withValues(alpha: 0.16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PokidokiSpacing.md,
            vertical: PokidokiSpacing.sm,
          ),
          child: Row(
            children: [
              Icon(Icons.wifi_off_rounded, color: colors.warning),
              const SizedBox(width: PokidokiSpacing.xs),
              Expanded(
                child: Text(
                  message,
                  style: typography.supportingBody.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> showPokidokiConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  bool isDestructive = false,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmLabel,
              style: TextStyle(
                color: isDestructive
                    ? context.pokidokiColors.error
                    : context.pokidokiColors.primary,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<T?> showPokidokiBottomSheet<T>(
  BuildContext context, {
  required Widget child,
}) {
  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => SafeArea(child: child),
  );
}
