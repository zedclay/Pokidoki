import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/inputs/pokidoki_text_field.dart';
import '../../../../l10n/app_localizations.dart';

class SecurePasswordField extends StatefulWidget {
  const SecurePasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.textInputAction,
    this.onChanged,
    this.autofillHints,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final bool enabled;

  @override
  State<SecurePasswordField> createState() => _SecurePasswordFieldState();
}

class _SecurePasswordFieldState extends State<SecurePasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: PokidokiTextField(
        controller: widget.controller,
        label: widget.label,
        hint: widget.hint,
        obscureText: _obscured,
        enabled: widget.enabled,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        autofillHints: widget.autofillHints,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\n'))],
        suffixIcon: IconButton(
          tooltip: _obscured
              ? l10n.accountShowPassword
              : l10n.accountHidePassword,
          onPressed: () => setState(() => _obscured = !_obscured),
          icon: Icon(
            _obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
