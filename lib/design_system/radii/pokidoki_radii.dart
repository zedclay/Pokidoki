import 'package:flutter/material.dart';

/// Corner radius tokens for Pokidoki surfaces and controls.
abstract final class PokidokiRadii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 14;
  static const double xl = 18;
  static const double chatBubble = 20;
  static const double modal = 24;

  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius borderChatBubble = BorderRadius.all(
    Radius.circular(chatBubble),
  );
  static const BorderRadius borderModal = BorderRadius.all(
    Radius.circular(modal),
  );
}
