import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';

class NumberPad extends StatelessWidget {
  const NumberPad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    this.onBiometrics,
    this.showBiometrics = false,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback? onBiometrics;
  final bool showBiometrics;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final keys = <_PadKey>[
      const _PadKey.digit('1'),
      const _PadKey.digit('2'),
      const _PadKey.digit('3'),
      const _PadKey.digit('4'),
      const _PadKey.digit('5'),
      const _PadKey.digit('6'),
      const _PadKey.digit('7'),
      const _PadKey.digit('8'),
      const _PadKey.digit('9'),
      if (showBiometrics)
        _PadKey.action(
          icon: Icons.fingerprint_rounded,
          semanticLabel: l10n.authUseBiometrics,
          onTap: onBiometrics,
        )
      else
        const _PadKey.empty(),
      const _PadKey.digit('0'),
      _PadKey.action(
        icon: Icons.backspace_rounded,
        semanticLabel: l10n.authDeleteDigit,
        onTap: onBackspace,
      ),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: PokidokiSpacing.lg,
      crossAxisSpacing: PokidokiSpacing.xl,
      childAspectRatio: 1.4,
      children: keys
          .map((key) => _PadButton(keyData: key, onDigit: onDigit))
          .toList(),
    );
  }
}

class _PadKey {
  const _PadKey._({
    this.digit,
    this.icon,
    this.semanticLabel,
    this.onTap,
    this.isEmpty = false,
  });

  const _PadKey.digit(String value)
    : this._(digit: value, semanticLabel: value);

  const _PadKey.action({
    required IconData icon,
    required String semanticLabel,
    required VoidCallback? onTap,
  }) : this._(icon: icon, semanticLabel: semanticLabel, onTap: onTap);

  const _PadKey.empty() : this._(isEmpty: true);

  final String? digit;
  final IconData? icon;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final bool isEmpty;
}

class _PadButton extends StatelessWidget {
  const _PadButton({required this.keyData, required this.onDigit});

  final _PadKey keyData;
  final ValueChanged<String> onDigit;

  @override
  Widget build(BuildContext context) {
    if (keyData.isEmpty) {
      return const SizedBox.shrink();
    }

    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return Semantics(
      button: true,
      label: keyData.semanticLabel,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: keyData.digit != null
              ? () => onDigit(keyData.digit!)
              : keyData.onTap,
          child: Center(
            child: keyData.digit != null
                ? Text(
                    keyData.digit!,
                    style: typography.display.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Icon(keyData.icon, color: colors.textSecondary, size: 28),
          ),
        ),
      ),
    );
  }
}
