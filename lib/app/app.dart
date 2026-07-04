import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../design_system/themes/pokidoki_theme.dart';
import '../l10n/app_localizations.dart';
import 'localization/locale_controller.dart';
import 'providers/app_providers.dart';
import 'routing/app_router.dart';

class PokidokiApp extends ConsumerWidget {
  const PokidokiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    final localeOverride = ref.watch(localeOverrideProvider);
    final platformLocales = WidgetsBinding.instance.platformDispatcher.locales;
    final locale = resolveAppLocale(
      override: localeOverride,
      deviceLocales: platformLocales,
    );

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: PokidokiTheme.light(locale: locale),
      darkTheme: PokidokiTheme.dark(locale: locale),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
