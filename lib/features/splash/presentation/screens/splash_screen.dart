import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_bootstrap.dart';
import '../../../../app/providers/app_providers.dart';
import '../../../../app/routing/auth_route_guard.dart';
import '../../../../core/utilities/motion.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/layout/pokidoki_safe_area.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/pokidoki_brand_mark.dart';

/// Screen 1 — Splash Screen.
///
/// Initializes lightweight app services, then navigates to onboarding.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  bool _navigated = false;

  String _statusLabel(String label, BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    if (languageCode == 'ar') {
      return label;
    }
    return label.toUpperCase();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(
      begin: 0.96,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      if (prefersReducedMotion(context)) {
        _controller.value = 1;
      } else {
        _controller.forward();
      }
      ref.read(appBootstrapProvider.notifier).start();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBootstrap(BootstrapState bootstrap) {
    if (_navigated || !mounted) {
      return;
    }
    if (bootstrap.phase == BootstrapPhase.failed || !bootstrap.isReady) {
      return;
    }
    _navigated = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      // Prefer go_router when available; splash may also be hosted standalone
      // in widget tests without a router.
      final router = GoRouter.maybeOf(context);
      if (router != null) {
        final authStatus = ref.read(authPresentationProvider);
        final onboardingCompleted = ref.read(onboardingCompletedProvider);
        context.go(
          resolveInitialEntry(
            authStatus: authStatus,
            onboardingCompleted: onboardingCompleted,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final bootstrap = ref.watch(appBootstrapProvider);

    ref.listen<BootstrapState>(appBootstrapProvider, (_, next) {
      _handleBootstrap(next);
    });
    _handleBootstrap(bootstrap);

    final statusLabel = bootstrap.phase == BootstrapPhase.failed
        ? l10n.stateError
        : l10n.splashPreparing;
    final semanticStatus = bootstrap.isReady
        ? l10n.splashReadySemantic
        : l10n.splashLoadingSemantic;

    return PokidokiScaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.1,
                  colors: [
                    colors.primary.withValues(alpha: 0.08),
                    colors.background,
                  ],
                ),
              ),
            ),
          ),
          PokidokiSafeArea(
            child: Semantics(
              container: true,
              label: '${l10n.appName}. $semanticStatus',
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fade.value,
                    child: Transform.scale(scale: _scale.value, child: child),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PokidokiSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      const Spacer(flex: 3),
                      const PokidokiBrandMark(size: 128, iconSize: 80),
                      const SizedBox(height: PokidokiSpacing.xl),
                      Text(
                        l10n.appName,
                        style: typography.screenTitle.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          height: 36 / 28,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: PokidokiSpacing.xs),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 240),
                        child: Text(
                          l10n.splashTagline,
                          style: typography.body.copyWith(
                            color: colors.textSecondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(flex: 3),
                      Semantics(
                        liveRegion: true,
                        label: semanticStatus,
                        child: Column(
                          children: [
                            if (bootstrap.phase == BootstrapPhase.failed)
                              TextButton(
                                onPressed: () {
                                  _navigated = false;
                                  ref
                                      .read(appBootstrapProvider.notifier)
                                      .retry();
                                },
                                child: Text(l10n.actionRetry),
                              )
                            else
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: colors.primary,
                                  backgroundColor: colors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                              ),
                            const SizedBox(height: PokidokiSpacing.md),
                            Text(
                              _statusLabel(statusLabel, context),
                              style: typography.caption.copyWith(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2,
                                color: colors.textSecondary.withValues(
                                  alpha: 0.8,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: PokidokiSpacing.huge),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
