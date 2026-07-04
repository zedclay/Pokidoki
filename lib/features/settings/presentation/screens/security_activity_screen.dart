import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../data/models/security_event.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_section_card.dart';

/// Security Activity list with filters (Stitch screen_2) and attention banner
/// (Stitch screen_1). Event tap opens detail route.
class SecurityActivityScreen extends ConsumerStatefulWidget {
  const SecurityActivityScreen({super.key});

  @override
  ConsumerState<SecurityActivityScreen> createState() =>
      _SecurityActivityScreenState();
}

class _SecurityActivityScreenState
    extends ConsumerState<SecurityActivityScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(settingsProvider.notifier).loadEvents());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final settings = ref.watch(settingsProvider);
    final events = settings.filteredEvents;
    final attentionCount = settings.events
        .where((event) => event.requiresAttention)
        .length;

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsSecurityActivity),
            Expanded(
              child: settings.isLoadingEvents
                  ? const Center(child: CircularProgressIndicator())
                  : settings.eventsError
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l10n.settingsSecurityActivityError),
                          TextButton(
                            onPressed: () => ref
                                .read(settingsProvider.notifier)
                                .loadEvents(),
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
                        SettingsSectionCard(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(PokidokiSpacing.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.settingsSecurityHistoryTitle,
                                    style: typography.cardTitle,
                                  ),
                                  Text(
                                    l10n.settingsSecurityHistoryBody,
                                    style: typography.supportingBody,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (attentionCount > 0) ...[
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
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: colors.warning,
                                  ),
                                  const SizedBox(width: PokidokiSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      l10n.settingsEventsNeedReview(
                                        attentionCount,
                                      ),
                                      style: typography.body,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: PokidokiSpacing.md),
                        Wrap(
                          spacing: PokidokiSpacing.xs,
                          runSpacing: PokidokiSpacing.xs,
                          children: [
                            for (final filter in SecurityEventFilter.values)
                              FilterChip(
                                label: Text(_filterLabel(l10n, filter)),
                                selected: settings.eventFilter == filter,
                                onSelected: (_) => ref
                                    .read(settingsProvider.notifier)
                                    .setEventFilter(filter),
                              ),
                          ],
                        ),
                        const SizedBox(height: PokidokiSpacing.md),
                        if (events.isEmpty)
                          SettingsSectionCard(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                  PokidokiSpacing.md,
                                ),
                                child: Text(
                                  l10n.settingsNoSecurityEvents,
                                  style: typography.body,
                                ),
                              ),
                            ],
                          )
                        else
                          SettingsSectionCard(
                            children: [
                              for (final event in events)
                                SecurityActivityRow(
                                  event: event,
                                  onTap: () => context.push(
                                    AppRoutes.settingsSecurityEventPath(
                                      event.id,
                                    ),
                                  ),
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

  String _filterLabel(AppLocalizations l10n, SecurityEventFilter filter) {
    return switch (filter) {
      SecurityEventFilter.all => l10n.settingsFilterAll,
      SecurityEventFilter.devices => l10n.settingsFilterDevices,
      SecurityEventFilter.identity => l10n.settingsFilterIdentity,
      SecurityEventFilter.signIn => l10n.settingsFilterSignIn,
    };
  }
}

class SecurityActivityRow extends StatelessWidget {
  const SecurityActivityRow({super.key, required this.event, this.onTap});

  final SecurityEvent event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final (icon, color) = _iconFor(event.type, colors);

    return Semantics(
      button: onTap != null,
      label: [
        event.title,
        event.summary,
        if (event.requiresAttention) 'Needs attention',
      ].join(', '),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(PokidokiSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsIconBadge(icon: icon, color: color),
              const SizedBox(width: PokidokiSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(event.title, style: typography.cardTitle),
                        ),
                        if (event.requiresAttention)
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 18,
                            color: colors.warning,
                          ),
                      ],
                    ),
                    Text(event.summary, style: typography.supportingBody),
                    if (event.deviceLabel != null)
                      Text(event.deviceLabel!, style: typography.caption),
                    Text(
                      _formatTime(event.occurredAt),
                      style: typography.caption,
                    ),
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

  (IconData, Color) _iconFor(SecurityEventType type, PokidokiColors colors) {
    return switch (type) {
      SecurityEventType.deviceLinked => (
        Icons.laptop_mac_rounded,
        colors.warning,
      ),
      SecurityEventType.deviceRemoved => (
        Icons.desktop_windows_rounded,
        colors.error,
      ),
      SecurityEventType.passwordChanged ||
      SecurityEventType.passwordReset => (Icons.key_rounded, colors.secure),
      SecurityEventType.verificationCompleted => (
        Icons.verified_rounded,
        colors.secure,
      ),
      SecurityEventType.emailVerified || SecurityEventType.emailChanged => (
        Icons.check_circle_rounded,
        colors.secure,
      ),
      SecurityEventType.emailChangeRequested => (
        Icons.mark_email_unread_rounded,
        colors.information,
      ),
      SecurityEventType.recoveryStarted ||
      SecurityEventType.recoveryCompleted => (
        Icons.shield_rounded,
        colors.warning,
      ),
      SecurityEventType.reportSubmitted => (
        Icons.flag_rounded,
        colors.information,
      ),
      SecurityEventType.otherDevicesSignedOut => (
        Icons.logout_rounded,
        colors.warning,
      ),
      SecurityEventType.signIn => (
        Icons.fingerprint_rounded,
        colors.information,
      ),
      SecurityEventType.appLockChanged => (Icons.lock_rounded, colors.primary),
      SecurityEventType.screenPrivacyEnabled => (
        Icons.visibility_off_rounded,
        colors.information,
      ),
    };
  }

  String _formatTime(DateTime time) {
    final local = time.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class SecurityEventDetailScreen extends ConsumerWidget {
  const SecurityEventDetailScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final event = ref.watch(settingsProvider).eventById(eventId);

    return PokidokiScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(title: l10n.settingsSecurityActivity),
            Expanded(
              child: event == null
                  ? Center(child: Text(l10n.settingsNoSecurityEvents))
                  : ListView(
                      padding: const EdgeInsets.all(PokidokiSpacing.lg),
                      children: [
                        SettingsSectionCard(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(PokidokiSpacing.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title,
                                    style: typography.sectionTitle,
                                  ),
                                  const SizedBox(height: PokidokiSpacing.sm),
                                  Text(event.summary, style: typography.body),
                                  if (event.deviceLabel != null) ...[
                                    const SizedBox(height: PokidokiSpacing.sm),
                                    Text(
                                      event.deviceLabel!,
                                      style: typography.supportingBody,
                                    ),
                                  ],
                                  const SizedBox(height: PokidokiSpacing.sm),
                                  Text(
                                    event.occurredAt.toLocal().toString(),
                                    style: typography.caption,
                                  ),
                                  if (event.requiresAttention) ...[
                                    const SizedBox(height: PokidokiSpacing.md),
                                    Text(
                                      l10n.settingsReviewLinkedDevicesHint,
                                      style: typography.supportingBody.copyWith(
                                        color: colors.warning,
                                      ),
                                    ),
                                    const SizedBox(height: PokidokiSpacing.sm),
                                    TextButton(
                                      onPressed: () => context.push(
                                        AppRoutes.settingsLinkedDevices,
                                      ),
                                      child: Text(
                                        l10n.settingsReviewLinkedDevices,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
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
}
