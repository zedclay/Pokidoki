import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../authentication/presentation/controllers/auth_flow_controller.dart';

Future<void> confirmAndSignOut(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.settingsSignOutTitle),
      content: Text(l10n.settingsSignOutBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.actionCancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.settingsSignOutAction),
        ),
      ],
    ),
  );

  if (confirmed != true || !context.mounted) {
    return;
  }

  await ref.read(authFlowProvider.notifier).signOut();
  if (!context.mounted) {
    return;
  }
  context.go(AppRoutes.welcome);
}
