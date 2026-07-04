import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../features/social/presentation/controllers/social_graph_controller.dart';
import '../../../../l10n/app_localizations.dart';

class ContactVerificationScreen extends ConsumerWidget {
  const ContactVerificationScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    ref.watch(socialGraphProvider);
    final verified = ref
        .read(socialGraphProvider.notifier)
        .isContactVerified(userId);
    final isAmira = userId == MockSampleData.amiraUserId;
    final displayName = isAmira ? 'Amira Mansouri' : 'Contact';
    final username = isAmira ? 'amira' : userId;
    final pokidokiId = isAmira ? 'PKD-AM84-2LX7' : 'PKD-0000-0000';

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
                      l10n.verifyContactTitle,
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
              child: ListView(
                padding: const EdgeInsets.all(PokidokiSpacing.lg),
                children: [
                  Center(
                    child: PokidokiAvatar(displayName: displayName, size: 88),
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  Text(
                    displayName,
                    style: typography.screenTitle,
                    textAlign: TextAlign.center,
                  ),
                  LtrText(
                    '@$username',
                    style: typography.supportingBody,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  Center(
                    child: PokidokiContactStatusBadge(
                      label: verified
                          ? l10n.semanticVerified
                          : l10n.verifyNotVerified,
                      tone: verified
                          ? PokidokiBadgeTone.secure
                          : PokidokiBadgeTone.warning,
                    ),
                  ),
                  const SizedBox(height: PokidokiSpacing.lg),
                  _Card(
                    icon: Icons.qr_code_scanner_rounded,
                    iconColor: colors.secure,
                    title: l10n.verifyQrRecognized,
                    body: l10n.verifyQrRecognizedBody(displayName),
                  ),
                  const SizedBox(height: PokidokiSpacing.md),
                  Text(
                    l10n.verifyConfirmInPerson,
                    style: typography.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: PokidokiSpacing.xl),
                  _MethodTile(
                    icon: Icons.qr_code_scanner_rounded,
                    title: l10n.verifyScanQrMethod,
                    subtitle: l10n.verifyScanQrMethodBody,
                    onTap: () => context.push(AppRoutes.qrScanner),
                  ),
                  const SizedBox(height: PokidokiSpacing.sm),
                  _MethodTile(
                    icon: Icons.pin_rounded,
                    title: l10n.verifyCompareSafetyNumber,
                    subtitle: l10n.verifyCompareSafetyNumberBody,
                    onTap: () =>
                        context.push(AppRoutes.safetyNumberPath(userId)),
                  ),
                  const SizedBox(height: PokidokiSpacing.xl),
                  Text(l10n.verifyWhatItConfirms, style: typography.inputLabel),
                  const SizedBox(height: PokidokiSpacing.sm),
                  _Bullet(text: l10n.verifyBulletSameIdentity),
                  _Bullet(text: l10n.verifyBulletNotReplaced),
                  _Bullet(text: l10n.verifyBulletMarkedOnDevice),
                  const SizedBox(height: PokidokiSpacing.md),
                  LtrText(
                    pokidokiId,
                    style: typography.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(PokidokiSpacing.lg),
              child: PokidokiButton.primary(
                label: l10n.verifyCompareSafetyNumber,
                onPressed: () =>
                    context.push(AppRoutes.safetyNumberPath(userId)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: PokidokiRadii.borderXl,
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.md),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: PokidokiSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: typography.cardTitle),
                  Text(body, style: typography.supportingBody),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return Material(
      color: colors.surface,
      borderRadius: PokidokiRadii.borderXl,
      child: InkWell(
        borderRadius: PokidokiRadii.borderXl,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.md),
          child: Row(
            children: [
              Icon(icon, color: colors.primary),
              const SizedBox(width: PokidokiSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: typography.cardTitle),
                    Text(subtitle, style: typography.supportingBody),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    return Padding(
      padding: const EdgeInsets.only(bottom: PokidokiSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_rounded, size: 18, color: colors.secure),
          const SizedBox(width: PokidokiSpacing.xs),
          Expanded(child: Text(text, style: typography.supportingBody)),
        ],
      ),
    );
  }
}
