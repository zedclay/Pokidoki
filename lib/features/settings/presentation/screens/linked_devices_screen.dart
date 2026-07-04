import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/linked_device.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_section_card.dart';

class LinkedDevicesScreen extends ConsumerStatefulWidget {
  const LinkedDevicesScreen({super.key});

  @override
  ConsumerState<LinkedDevicesScreen> createState() =>
      _LinkedDevicesScreenState();
}

class _LinkedDevicesScreenState extends ConsumerState<LinkedDevicesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(settingsProvider.notifier).loadDevices());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final settings = ref.watch(settingsProvider);
    final current = settings.currentDevice;
    final others = settings.otherDevices;

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsLinkedDevices),
            Expanded(
              child: settings.isLoadingDevices
                  ? const Center(child: CircularProgressIndicator())
                  : settings.devicesError
                  ? _ErrorState(
                      message: l10n.settingsLinkedDevicesError,
                      onRetry: () =>
                          ref.read(settingsProvider.notifier).loadDevices(),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        PokidokiSpacing.lg,
                        PokidokiSpacing.sm,
                        PokidokiSpacing.lg,
                        PokidokiSpacing.xl,
                      ),
                      children: [
                        SettingsSectionCard(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(PokidokiSpacing.md),
                              child: Row(
                                children: [
                                  SettingsIconBadge(
                                    icon: Icons.devices_rounded,
                                    color: colors.primary,
                                  ),
                                  const SizedBox(width: PokidokiSpacing.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.settingsActiveDevices(
                                            settings.activeDeviceCount,
                                          ),
                                          style: typography.cardTitle,
                                        ),
                                        Text(
                                          l10n.settingsLinkedDevicesInfo,
                                          style: typography.supportingBody,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (others.any((d) => d.needsReview)) ...[
                          const SizedBox(height: PokidokiSpacing.md),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: colors.warning.withValues(alpha: 0.12),
                              borderRadius: PokidokiRadii.borderXl,
                              border: Border.all(
                                color: colors.warning.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(PokidokiSpacing.md),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: colors.warning,
                                  ),
                                  const SizedBox(width: PokidokiSpacing.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.settingsDeviceLinkedRecently,
                                          style: typography.cardTitle,
                                        ),
                                        Text(
                                          l10n.settingsDeviceLinkedRecentlyBody,
                                          style: typography.supportingBody,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        if (current != null) ...[
                          const SizedBox(height: PokidokiSpacing.lg),
                          Text(
                            l10n.settingsThisDevice,
                            style: typography.caption.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: PokidokiSpacing.sm),
                          LinkedDeviceCard(device: current, isCurrent: true),
                        ],
                        const SizedBox(height: PokidokiSpacing.lg),
                        Text(
                          l10n.settingsOtherDevices,
                          style: typography.caption.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: PokidokiSpacing.sm),
                        if (others.isEmpty)
                          SettingsSectionCard(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                  PokidokiSpacing.md,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.settingsNoOtherDevices,
                                      style: typography.cardTitle,
                                    ),
                                    Text(
                                      l10n.settingsNoOtherDevicesBody,
                                      style: typography.supportingBody,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          ...others.map(
                            (device) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: PokidokiSpacing.sm,
                              ),
                              child: LinkedDeviceCard(
                                device: device,
                                isCurrent: false,
                                onRemove: () => _confirmRemove(device),
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmRemove(LinkedDevice device) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsRemoveDeviceTitle(device.name)),
        content: Text(l10n.settingsRemoveDeviceBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.settingsRemoveDeviceAction),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await ref.read(settingsProvider.notifier).removeDevice(device.id);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.settingsDeviceRemoved)));
      }
    }
  }
}

class LinkedDeviceCard extends StatelessWidget {
  const LinkedDeviceCard({
    super.key,
    required this.device,
    required this.isCurrent,
    this.onRemove,
  });

  final LinkedDevice device;
  final bool isCurrent;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final icon =
        device.platform.toLowerCase().contains('mac') ||
            device.platform.toLowerCase().contains('desktop')
        ? Icons.laptop_mac_rounded
        : Icons.phone_iphone_rounded;

    return Semantics(
      label: [
        device.name,
        device.platform,
        if (isCurrent) l10n.settingsCurrentDevice,
        if (device.needsReview) l10n.settingsNeedsReview,
        if (device.approximateLocation != null) device.approximateLocation!,
      ].join(', '),
      child: SettingsSectionCard(
        children: [
          Padding(
            padding: const EdgeInsets.all(PokidokiSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsIconBadge(icon: icon, color: colors.primary),
                const SizedBox(width: PokidokiSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              device.name,
                              style: typography.cardTitle,
                            ),
                          ),
                          if (isCurrent)
                            _StatusChip(
                              label: l10n.settingsCurrentDevice,
                              color: colors.secure,
                            )
                          else if (device.needsReview)
                            _StatusChip(
                              label: l10n.settingsNeedsReview,
                              color: colors.warning,
                            ),
                        ],
                      ),
                      Text(device.platform, style: typography.supportingBody),
                      Text(
                        isCurrent
                            ? l10n.settingsActiveNow
                            : l10n.settingsLastActiveRecently,
                        style: typography.caption,
                      ),
                      if (device.approximateLocation != null)
                        Text(
                          device.approximateLocation!,
                          style: typography.caption,
                        ),
                      if (!isCurrent && onRemove != null) ...[
                        const SizedBox(height: PokidokiSpacing.sm),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: TextButton(
                            onPressed: onRemove,
                            child: Text(l10n.settingsRemoveDeviceAction),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: PokidokiRadii.borderSm,
      ),
      child: Text(label, style: typography.badge.copyWith(color: color)),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PokidokiSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: typography.body, textAlign: TextAlign.center),
            const SizedBox(height: PokidokiSpacing.md),
            TextButton(onPressed: onRetry, child: Text(l10n.actionTryAgain)),
          ],
        ),
      ),
    );
  }
}
