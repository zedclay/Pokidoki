import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/shared_media_item.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/layout/pokidoki_scaffold.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/messaging_controller.dart';

class SharedContentScreen extends ConsumerWidget {
  const SharedContentScreen({super.key, required this.conversationId});

  final String conversationId;

  String _sizeLabel(int bytes) {
    if (bytes >= 1000000) {
      return '${(bytes / 1000000).toStringAsFixed(1)} MB';
    }
    return '${(bytes / 1000).round()} KB';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final conversation = ref
        .read(messagingProvider.notifier)
        .conversation(conversationId);
    final media = ref
        .read(messagingProvider.notifier)
        .sharedMedia(conversationId);
    final images = media
        .where((item) => item.kind != SharedMediaKind.file)
        .toList();
    final files = media
        .where((item) => item.kind == SharedMediaKind.file)
        .toList();
    final links = ref
        .read(messagingProvider.notifier)
        .sharedLinks(conversationId);

    return DefaultTabController(
      length: 3,
      child: PokidokiScaffold(
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
                        l10n.chatSharedContent,
                        textAlign: TextAlign.center,
                        style: typography.sectionTitle,
                      ),
                    ),
                    const SizedBox(width: PokidokiSpacing.minTouchTarget),
                  ],
                ),
              ),
              Text(
                l10n.chatSharedWith(conversation?.peerDisplayName ?? ''),
                style: typography.caption,
              ),
              TabBar(
                labelColor: colors.primary,
                unselectedLabelColor: colors.textTertiary,
                tabs: [
                  Tab(text: l10n.chatMedia),
                  Tab(text: l10n.chatFiles),
                  Tab(text: l10n.chatLinks),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    images.isEmpty
                        ? Center(child: Text(l10n.chatNoMedia))
                        : GridView.builder(
                            padding: const EdgeInsets.all(PokidokiSpacing.md),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                ),
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              final item = images[index];
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: colors.surfaceElevated,
                                  borderRadius: PokidokiRadii.borderMd,
                                ),
                                child: Center(
                                  child: Icon(
                                    item.kind == SharedMediaKind.video
                                        ? Icons.play_circle_rounded
                                        : Icons.image_rounded,
                                    color: colors.primary,
                                  ),
                                ),
                              );
                            },
                          ),
                    files.isEmpty
                        ? Center(child: Text(l10n.chatNoFiles))
                        : ListView.builder(
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              final file = files[index];
                              return ListTile(
                                leading: Icon(
                                  Icons.description_rounded,
                                  color: colors.primary,
                                ),
                                title: Text(file.fileName),
                                subtitle: Text(_sizeLabel(file.sizeBytes)),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.chatFilePreviewLater),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                    links.isEmpty
                        ? Center(child: Text(l10n.chatNoLinks))
                        : ListView.builder(
                            itemCount: links.length,
                            itemBuilder: (context, index) {
                              final link = links[index];
                              return ListTile(
                                leading: Icon(
                                  Icons.link_rounded,
                                  color: colors.primary,
                                ),
                                title: Text(link['title'] ?? ''),
                                subtitle: Text(
                                  '${link['domain']}\n${link['description']}',
                                ),
                                isThreeLine: true,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
