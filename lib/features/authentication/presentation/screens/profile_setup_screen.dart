import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/components/identity/pokidoki_identity.dart';
import '../../../../design_system/components/inputs/pokidoki_text_field.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/auth_flow_controller.dart';
import '../widgets/auth_scaffold.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final flow = ref.read(authFlowProvider);
    _nameController = TextEditingController(
      text: flow.displayName.isEmpty ? 'Zed Clay' : flow.displayName,
    );
    _bioController = TextEditingController(
      text: flow.bio.isEmpty
          ? 'Building ideas and keeping the important conversations private.'
          : flow.bio,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _continue({required bool skipOptional}) {
    ref
        .read(authFlowProvider.notifier)
        .setDisplayName(
          _nameController.text.trim().isEmpty
              ? 'Zed Clay'
              : _nameController.text.trim(),
        );
    if (!skipOptional) {
      ref.read(authFlowProvider.notifier).setBio(_bioController.text.trim());
    }
    context.push(AppRoutes.createPin);
  }

  Future<void> _showAvatarSheet() async {
    final l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(l10n.authChoosePhoto),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: Text(l10n.authTakePhoto),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(l10n.authRemovePhoto),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final bioLength = _bioController.text.length;

    return AuthScaffold(
      title: l10n.authCreateProfileTitle,
      onBack: () => context.pop(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(PokidokiSpacing.lg),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                l10n.authProfileStep2,
                style: typography.caption.copyWith(color: colors.primary),
              ),
            ),
            const SizedBox(height: PokidokiSpacing.sm),
            Text(
              l10n.authProfileHeading,
              style: typography.screenTitle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: PokidokiSpacing.xs),
            Text(
              l10n.authProfileBody,
              style: typography.body.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PokidokiSpacing.xl),
            Stack(
              children: [
                PokidokiAvatar(
                  displayName: _nameController.text.isEmpty
                      ? 'Zed Clay'
                      : _nameController.text,
                  size: 112,
                ),
                PositionedDirectional(
                  end: 0,
                  bottom: 0,
                  child: Material(
                    color: colors.primary,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _showAvatarSheet,
                      child: const SizedBox(
                        width: 36,
                        height: 36,
                        child: Icon(Icons.edit_rounded, size: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: PokidokiSpacing.xl),
            PokidokiTextField(
              controller: _nameController,
              label: l10n.authDisplayNameLabel,
              prefixIcon: Icon(
                Icons.person_outline,
                color: colors.textTertiary,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: PokidokiSpacing.md),
            PokidokiMultilineField(
              controller: _bioController,
              label: l10n.authAboutYouLabel,
              maxLines: 4,
              onChanged: (value) {
                if (value.length <= 120) {
                  setState(() {});
                } else {
                  _bioController.text = value.substring(0, 120);
                  _bioController.selection = const TextSelection.collapsed(
                    offset: 120,
                  );
                  setState(() {});
                }
              },
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text('$bioLength / 120', style: typography.caption),
            ),
            const SizedBox(height: PokidokiSpacing.xl),
            PokidokiButton.primary(
              label: l10n.actionContinue,
              onPressed: () => _continue(skipOptional: false),
            ),
            const SizedBox(height: PokidokiSpacing.sm),
            TextButton(
              onPressed: () => _continue(skipOptional: true),
              child: Text(l10n.authSkipOptionalDetails),
            ),
          ],
        ),
      ),
    );
  }
}
