import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../messaging/data/messaging_providers.dart';
import '../widgets/main_bottom_nav.dart';

/// Authenticated three-tab shell: Chats, Contacts, Settings.
class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Subscribe to message and conversation socket events app-wide.
    ref.watch(messagingProvider);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: MainBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
