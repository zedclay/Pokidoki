import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/storage_usage.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/components/settings/pokidoki_settings_rows.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_section_card.dart';

class StorageUsageScreen extends ConsumerStatefulWidget {
  const StorageUsageScreen({super.key});

  @override
  ConsumerState<StorageUsageScreen> createState() => _StorageUsageScreenState();
}

class _StorageUsageScreenState extends ConsumerState<StorageUsageScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(settingsProvider.notifier).loadStorage());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final settings = ref.watch(settingsProvider);
    final storage = settings.storage;

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsStorageUsage),
            Expanded(
              child: settings.isLoadingStorage
                  ? const Center(child: CircularProgressIndicator())
                  : settings.storageError
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l10n.settingsStorageError),
                          TextButton(
                            onPressed: () => ref
                                .read(settingsProvider.notifier)
                                .loadStorage(),
                            child: Text(l10n.actionTryAgain),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        PokidokiSpacing.lg,
                        PokidokiSpacing.sm,
                        PokidokiSpacing.lg,
                        PokidokiSpacing.xl,
                      ),
                      children: [
                        StorageSummaryCard(storage: storage),
                        const SizedBox(height: PokidokiSpacing.lg),
                        Text(
                          l10n.settingsCategories,
                          style: typography.caption.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: PokidokiSpacing.sm),
                        SettingsSectionCard(
                          children: [
                            StorageCategoryRow(
                              icon: Icons.photo_library_rounded,
                              label: l10n.settingsStorageMedia,
                              bytes: storage.mediaBytes,
                              color: colors.primary,
                            ),
                            StorageCategoryRow(
                              icon: Icons.description_rounded,
                              label: l10n.settingsStorageFiles,
                              bytes: storage.filesBytes,
                              color: colors.information,
                            ),
                            StorageCategoryRow(
                              icon: Icons.mic_rounded,
                              label: l10n.settingsStorageVoice,
                              bytes: storage.voiceBytes,
                              color: colors.secure,
                            ),
                            StorageCategoryRow(
                              icon: Icons.cached_rounded,
                              label: l10n.settingsStorageCache,
                              bytes: storage.cacheBytes,
                              color: colors.warning,
                              actionLabel: l10n.settingsClear,
                              onAction: storage.cacheBytes == 0
                                  ? null
                                  : () => _clearCache(),
                            ),
                            StorageCategoryRow(
                              icon: Icons.dataset_rounded,
                              label: l10n.settingsStorageOther,
                              bytes: storage.otherBytes,
                              color: colors.textTertiary,
                            ),
                          ],
                        ),
                        const SizedBox(height: PokidokiSpacing.lg),
                        SettingsSectionCard(
                          children: [
                            PokidokiNavigationRow(
                              title: l10n.settingsClearCache,
                              subtitle: l10n.settingsClearCacheSubtitle,
                              leading: const SettingsIconBadge(
                                icon: Icons.delete_sweep_rounded,
                              ),
                              onTap: storage.cacheBytes == 0
                                  ? null
                                  : () => _clearCache(),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _clearCache() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsClearCacheTitle),
        content: Text(l10n.settingsClearCacheBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.settingsClearCacheAction),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await ref.read(settingsProvider.notifier).clearCache();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.settingsCacheCleared)));
      }
    }
  }
}

class StorageSummaryCard extends StatelessWidget {
  const StorageSummaryCard({super.key, required this.storage});

  final StorageUsage storage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final segments = <(int, Color)>[
      (storage.mediaBytes, colors.primary),
      (storage.filesBytes, colors.information),
      (storage.voiceBytes, colors.secure),
      (storage.cacheBytes, colors.warning),
      (storage.otherBytes, colors.textTertiary),
    ];

    return Semantics(
      label: l10n.settingsStorageSummarySemantic(
        _formatBytes(storage.totalBytes),
      ),
      child: SettingsSectionCard(
        children: [
          Padding(
            padding: const EdgeInsets.all(PokidokiSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatBytes(storage.totalBytes),
                  style: typography.sectionTitle,
                ),
                Text(
                  l10n.settingsStorageUsedOnDevice,
                  style: typography.supportingBody,
                ),
                const SizedBox(height: PokidokiSpacing.md),
                ClipRRect(
                  borderRadius: PokidokiRadii.borderSm,
                  child: SizedBox(
                    height: 12,
                    child: Row(
                      children: [
                        for (final segment in segments)
                          if (segment.$1 > 0)
                            Expanded(
                              flex: segment.$1,
                              child: ColoredBox(color: segment.$2),
                            ),
                        if (segments.every((s) => s.$1 == 0))
                          Expanded(child: ColoredBox(color: colors.border)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: PokidokiSpacing.sm),
                Wrap(
                  spacing: PokidokiSpacing.md,
                  runSpacing: PokidokiSpacing.xs,
                  children: [
                    _Legend(
                      color: colors.primary,
                      label: l10n.settingsStorageMedia,
                    ),
                    _Legend(
                      color: colors.information,
                      label: l10n.settingsStorageFiles,
                    ),
                    _Legend(
                      color: colors.secure,
                      label: l10n.settingsStorageVoice,
                    ),
                    _Legend(
                      color: colors.warning,
                      label: l10n.settingsStorageCache,
                    ),
                    _Legend(
                      color: colors.textTertiary,
                      label: l10n.settingsStorageOther,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StorageCategoryRow extends StatelessWidget {
  const StorageCategoryRow({
    super.key,
    required this.icon,
    required this.label,
    required this.bytes,
    required this.color,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String label;
  final int bytes;
  final Color color;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Padding(
      padding: const EdgeInsets.all(PokidokiSpacing.md),
      child: Row(
        children: [
          SettingsIconBadge(icon: icon, color: color),
          const SizedBox(width: PokidokiSpacing.sm),
          Expanded(child: Text(label, style: typography.body)),
          if (actionLabel != null && onAction != null)
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
          Text(_formatBytes(bytes), style: typography.supportingBody),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final typography = context.pokidokiTypography;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: typography.caption),
      ],
    );
  }
}

String _formatBytes(int bytes) {
  if (bytes <= 0) {
    return '0 MB';
  }
  final mb = bytes / (1024 * 1024);
  if (mb >= 100) {
    return '${mb.round()} MB';
  }
  return '${mb.toStringAsFixed(mb >= 10 ? 0 : 0)} MB';
}
