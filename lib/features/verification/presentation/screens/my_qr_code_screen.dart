import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import 'qr_scanner_screen.dart';

class MyQrCodeScreen extends ConsumerStatefulWidget {
  const MyQrCodeScreen({super.key});

  @override
  ConsumerState<MyQrCodeScreen> createState() => _MyQrCodeScreenState();
}

class _MyQrCodeScreenState extends ConsumerState<MyQrCodeScreen> {
  late String _payload;

  @override
  void initState() {
    super.initState();
    _payload = MockSampleData.currentUserQrPayload;
  }

  Future<void> _refresh() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.qrRefreshTitle),
        content: Text(l10n.qrRefreshBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.qrRefreshAction),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      setState(() {
        _payload =
            '${MockSampleData.currentUserQrPayload}?v=${DateTime.now().millisecondsSinceEpoch}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    const user = MockSampleData.currentUser;
    final repo = ref.watch(contactVerificationRepositoryProvider);

    return PokidokiScaffold(
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
                      l10n.qrMyCodeTitle,
                      textAlign: TextAlign.center,
                      style: typography.sectionTitle,
                    ),
                  ),
                  PokidokiIconButton(
                    icon: Icons.light_mode_outlined,
                    tooltip: l10n.qrBrightness,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(PokidokiSpacing.lg),
                children: [
                  Center(
                    child: PokidokiAvatar(
                      displayName: user.displayName,
                      size: 72,
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  Text(
                    user.displayName,
                    style: typography.screenTitle,
                    textAlign: TextAlign.center,
                  ),
                  LtrText(
                    '@${user.username}',
                    style: typography.supportingBody,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: PokidokiSpacing.xl),
                  Center(
                    child: Semantics(
                      label: l10n.qrCodeSemantic,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: PokidokiRadii.borderXl,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(PokidokiSpacing.md),
                          child: QrImageView(
                            data: _payload.isEmpty
                                ? repo.currentUserQrPayload()
                                : _payload,
                            size: 220,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.xl),
                  Text(
                    l10n.qrPublicIdentity,
                    style: typography.inputLabel,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: PokidokiSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LtrText(user.pokidokiId, style: typography.cardTitle),
                      IconButton(
                        tooltip: l10n.usersCopyId,
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: user.pokidokiId),
                          );
                        },
                        icon: const Icon(Icons.copy_rounded, size: 18),
                      ),
                    ],
                  ),
                  Text(
                    l10n.qrPublicIdHelp,
                    style: typography.caption,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  Text(
                    l10n.qrShareExplanation,
                    style: typography.supportingBody,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(PokidokiSpacing.lg),
              child: Column(
                children: [
                  PokidokiButton.primary(
                    label: l10n.qrShareAction,
                    icon: Icons.share_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.qrShareReady)),
                      );
                    },
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  PokidokiButton.secondary(
                    label: l10n.qrRefreshAction,
                    onPressed: _refresh,
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
