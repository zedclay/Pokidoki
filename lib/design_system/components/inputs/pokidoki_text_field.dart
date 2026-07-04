import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../colors/pokidoki_colors.dart';
import '../../spacing/pokidoki_spacing.dart';
import '../../typography/pokidoki_typography.dart';

class PokidokiTextField extends StatelessWidget {
  const PokidokiTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.enabled = true,
    this.autofillHints,
    this.inputFormatters,
    this.semanticLabel,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final bool enabled;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Semantics(
      textField: true,
      label: semanticLabel ?? label ?? hint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(label!, style: typography.inputLabel),
            const SizedBox(height: PokidokiSpacing.xs),
          ],
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            validator: validator,
            maxLines: maxLines,
            enabled: enabled,
            autofillHints: autofillHints,
            inputFormatters: inputFormatters,
            style: typography.body,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}

class PokidokiSearchField extends StatelessWidget {
  const PokidokiSearchField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.semanticLabel,
  });

  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return PokidokiTextField(
      controller: controller,
      hint: hint,
      onChanged: onChanged,
      semanticLabel: semanticLabel,
      prefixIcon: Icon(Icons.search_rounded, color: colors.textTertiary),
      textInputAction: TextInputAction.search,
    );
  }
}

class PokidokiPasswordField extends StatefulWidget {
  const PokidokiPasswordField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  State<PokidokiPasswordField> createState() => _PokidokiPasswordFieldState();
}

class _PokidokiPasswordFieldState extends State<PokidokiPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return PokidokiTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      obscureText: _obscured,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: const [AutofillHints.password],
      suffixIcon: IconButton(
        tooltip: _obscured ? 'Show password' : 'Hide password',
        onPressed: () => setState(() => _obscured = !_obscured),
        icon: Icon(
          _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
        ),
      ),
    );
  }
}

class PokidokiPinField extends StatelessWidget {
  const PokidokiPinField({
    super.key,
    this.controller,
    this.label,
    this.onChanged,
    this.length = 6,
  });

  final TextEditingController? controller;
  final String? label;
  final ValueChanged<String>? onChanged;
  final int length;

  @override
  Widget build(BuildContext context) {
    return PokidokiTextField(
      controller: controller,
      label: label,
      obscureText: true,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(length),
      ],
    );
  }
}

class PokidokiMultilineField extends StatelessWidget {
  const PokidokiMultilineField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.onChanged,
    this.maxLines = 4,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return PokidokiTextField(
      controller: controller,
      label: label,
      hint: hint,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}

class PokidokiVerificationCodeField extends StatelessWidget {
  const PokidokiVerificationCodeField({
    super.key,
    this.controller,
    this.label,
    this.onChanged,
    this.length = 6,
  });

  final TextEditingController? controller;
  final String? label;
  final ValueChanged<String>? onChanged;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PokidokiTextField(
        controller: controller,
        label: label,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(length),
        ],
      ),
    );
  }
}
