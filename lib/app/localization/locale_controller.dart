import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../providers/app_providers.dart';

/// Resolves the active locale from an optional override or the device locale.
Locale resolveAppLocale({
  required Locale? override,
  required List<Locale> deviceLocales,
}) {
  if (override != null && _isSupported(override)) {
    return Locale(override.languageCode);
  }

  for (final locale in deviceLocales) {
    if (_isSupported(locale)) {
      return Locale(locale.languageCode);
    }
  }

  return const Locale('en');
}

bool _isSupported(Locale locale) {
  return AppConstants.supportedLanguageCodes.contains(locale.languageCode);
}

final resolvedLocaleProvider = Provider<Locale>((ref) {
  final override = ref.watch(localeOverrideProvider);
  // Device locales are read at the widget layer; default to English here.
  // [PokidokiApp] applies platform locales when building MaterialApp.router.
  return override ?? const Locale('en');
});

/// Updates the locale override used by Screen 34 (Language) later.
void setAppLocale(WidgetRef ref, Locale? locale) {
  ref.read(localeOverrideProvider.notifier).state = locale == null
      ? null
      : Locale(locale.languageCode);
}
