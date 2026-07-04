import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';

/// Six-digit verification entry that preserves LTR digit order in RTL locales.
class VerificationCodeInput extends StatefulWidget {
  const VerificationCodeInput({
    super.key,
    required this.onChanged,
    this.length = 6,
    this.semanticLabel,
  });

  final ValueChanged<String> onChanged;
  final int length;
  final String? semanticLabel;

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final value = _controller.text;

    return Semantics(
      label: widget.semanticLabel,
      textField: true,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.length),
                  ],
                  onChanged: (text) {
                    setState(() {});
                    widget.onChanged(text);
                  },
                ),
              ),
              Row(
                children: List<Widget>.generate(widget.length, (index) {
                  final filled = index < value.length;
                  final focused =
                      _focusNode.hasFocus &&
                      index == value.length.clamp(0, widget.length - 1);
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: EdgeInsetsDirectional.only(
                        end: index == widget.length - 1
                            ? 0
                            : PokidokiSpacing.xs,
                      ),
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: PokidokiRadii.borderLg,
                        border: Border.all(
                          color: focused ? colors.primary : colors.border,
                          width: focused ? 2 : 1.5,
                        ),
                      ),
                      child: Text(
                        filled ? value[index] : '',
                        style: typography.display.copyWith(fontSize: 24),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
