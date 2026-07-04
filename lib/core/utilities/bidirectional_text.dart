import 'package:flutter/widgets.dart';

/// Wraps technical identifiers so they remain LTR inside RTL layouts.
///
/// Use for usernames, Pokidoki IDs, emails, URLs, verification codes,
/// safety numbers, timestamps, and other technical identifiers.
class LtrText extends StatelessWidget {
  const LtrText(
    this.data, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  final String data;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        data,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
      ),
    );
  }
}
