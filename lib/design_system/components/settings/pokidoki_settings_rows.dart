import 'package:flutter/material.dart';

import '../../colors/pokidoki_colors.dart';
import '../../spacing/pokidoki_spacing.dart';
import '../../typography/pokidoki_typography.dart';

class PokidokiSettingsRow extends StatelessWidget {
  const PokidokiSettingsRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;

    return Semantics(
      button: onTap != null,
      label: title,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: PokidokiSpacing.minTouchTarget,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PokidokiSpacing.md,
              vertical: PokidokiSpacing.sm,
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: PokidokiSpacing.sm),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: typography.body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: PokidokiSpacing.xxs),
                        Text(
                          subtitle!,
                          style: typography.supportingBody,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: PokidokiSpacing.sm),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PokidokiToggleRow extends StatelessWidget {
  const PokidokiToggleRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return PokidokiSettingsRow(
      title: title,
      subtitle: subtitle,
      trailing: Switch.adaptive(value: value, onChanged: onChanged),
      onTap: onChanged == null ? null : () => onChanged!(!value),
    );
  }
}

class PokidokiValueRow extends StatelessWidget {
  const PokidokiValueRow({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
  });

  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return PokidokiSettingsRow(
      title: title,
      trailing: Text(
        value,
        style: typography.supportingBody,
        textAlign: TextAlign.end,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}

class PokidokiNavigationRow extends StatelessWidget {
  const PokidokiNavigationRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return PokidokiSettingsRow(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Icon(Icons.chevron_right_rounded, color: colors.textTertiary),
      onTap: onTap,
    );
  }
}

class PokidokiRadioOptionRow<T> extends StatelessWidget {
  const PokidokiRadioOptionRow({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final selected = value == groupValue;
    return PokidokiSettingsRow(
      title: title,
      subtitle: subtitle,
      trailing: Icon(
        selected
            ? Icons.radio_button_checked_rounded
            : Icons.radio_button_off_rounded,
        color: selected ? colors.primary : colors.textTertiary,
      ),
      onTap: onChanged == null ? null : () => onChanged!(value),
    );
  }
}
