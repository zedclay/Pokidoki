import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../data/mock/mock_contact_verification_repository.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../data/repositories/contact_verification_repository.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/qr_scanner_overlay.dart';

final contactVerificationRepositoryProvider =
    Provider<ContactVerificationRepository>((ref) {
      return const MockContactVerificationRepository();
    });

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});

  @override
  ConsumerState<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen> {
  bool _invalid = false;
  bool _loading = false;

  Future<void> _simulateScan({required bool valid}) async {
    setState(() {
      _loading = true;
      _invalid = false;
    });
    final repo = ref.read(contactVerificationRepositoryProvider);
    final profile = await repo.resolveQrPayload(
      valid ? MockSampleData.amiraQrPayload : 'invalid://payload',
    );
    if (!mounted) {
      return;
    }
    setState(() => _loading = false);
    if (profile == null) {
      setState(() => _invalid = true);
      return;
    }
    context.push(AppRoutes.contactVerificationPath(profile.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;

    return PokidokiScaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  PokidokiIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: l10n.semanticBack,
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      l10n.qrScanTitle,
                      textAlign: TextAlign.center,
                      style: typography.sectionTitle,
                    ),
                  ),
                  PokidokiIconButton(
                    icon: Icons.help_outline_rounded,
                    tooltip: l10n.qrHelp,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [colors.surfaceElevated, colors.background],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.qrScanHeading,
                        style: typography.screenTitle.copyWith(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: PokidokiSpacing.xs),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: PokidokiSpacing.xl,
                        ),
                        child: Text(
                          l10n.qrScanBody,
                          style: typography.supportingBody,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: PokidokiSpacing.xl),
                      QrScannerOverlay(
                        size: 240,
                        semanticLabel: l10n.qrFrameSemantic,
                        onSimulateScan: kDebugMode && !_loading
                            ? () => _simulateScan(valid: true)
                            : null,
                      ),
                      const SizedBox(height: PokidokiSpacing.lg),
                      Text(
                        _invalid
                            ? l10n.qrInvalidCode
                            : _loading
                            ? l10n.stateLoading
                            : l10n.qrLookingForCode,
                        style: typography.caption.copyWith(
                          color: _invalid ? colors.error : colors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (kDebugMode) ...[
                        const SizedBox(height: PokidokiSpacing.md),
                        TextButton(
                          onPressed: _loading
                              ? null
                              : () => _simulateScan(valid: true),
                          child: Text(l10n.qrSimulateScan),
                        ),
                      ],
                      if (_invalid)
                        TextButton(
                          onPressed: () => setState(() => _invalid = false),
                          child: Text(l10n.actionRetry),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(PokidokiSpacing.lg),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: PokidokiButton.secondary(
                          label: l10n.qrFlash,
                          icon: Icons.flashlight_on_rounded,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: PokidokiSpacing.sm),
                      Expanded(
                        child: PokidokiButton.secondary(
                          label: l10n.qrGallery,
                          icon: Icons.image_outlined,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  PokidokiButton.primary(
                    label: l10n.qrMyCodeAction,
                    onPressed: () => context.push(AppRoutes.myQrCode),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
