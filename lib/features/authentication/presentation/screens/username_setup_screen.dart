import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/route_names.dart';
import '../../../../core/utilities/bidirectional_text.dart';
import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/components/buttons/pokidoki_buttons.dart';
import '../../../../design_system/radii/pokidoki_radii.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/auth_flow_controller.dart';
import '../widgets/auth_requirement_row.dart';
import '../widgets/auth_scaffold.dart';

class UsernameSetupScreen extends ConsumerStatefulWidget {
  const UsernameSetupScreen({super.key});

  @override
  ConsumerState<UsernameSetupScreen> createState() =>
      _UsernameSetupScreenState();
}

class _UsernameSetupScreenState extends ConsumerState<UsernameSetupScreen> {
  final _controller = TextEditingController(text: 'zedclay');
  Timer? _debounce;
  bool? _available;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    _checkAvailability(_controller.text);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  bool _isValidFormat(String value) {
    return RegExp(r'^[a-z][a-z0-9._]{2,23}$').hasMatch(value);
  }

  bool get _startsWithLetter =>
      _controller.text.isNotEmpty &&
      RegExp(r'^[a-z]').hasMatch(_controller.text);
  bool get _lengthOk =>
      _controller.text.length >= 3 && _controller.text.length <= 24;
  bool get _charsetOk => RegExp(r'^[a-z0-9._]*$').hasMatch(_controller.text);
  bool get _noSpaces => !RegExp(r'\s').hasMatch(_controller.text);

  Future<void> _checkAvailability(String value) async {
    if (!_isValidFormat(value)) {
      setState(() {
        _available = null;
        _checking = false;
      });
      return;
    }
    setState(() => _checking = true);
    final available = await ref
        .read(authFlowProvider.notifier)
        .checkUsernameAvailable(value);
    if (!mounted || _controller.text != value) {
      return;
    }
    setState(() {
      _available = available;
      _checking = false;
    });
  }

  void _onChanged(String value) {
    final normalized = value.toLowerCase();
    if (normalized != value) {
      _controller.value = TextEditingValue(
        text: normalized,
        selection: TextSelection.collapsed(offset: normalized.length),
      );
    }
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      _checkAvailability(normalized);
    });
  }

  void _continue() {
    if (!_isValidFormat(_controller.text) || _available != true) {
      return;
    }
    ref.read(authFlowProvider.notifier).setUsername(_controller.text);
    context.push(AppRoutes.profileSetup);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.pokidokiColors;
    final typography = context.pokidokiTypography;
    final username = _controller.text;
    final canContinue =
        _isValidFormat(username) && _available == true && !_checking;

    return AuthScaffold(
      title: l10n.appName,
      onBack: () => context.pop(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(PokidokiSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.authProfileStep1,
              style: typography.caption.copyWith(color: colors.primary),
            ),
            const SizedBox(height: PokidokiSpacing.sm),
            Text(
              l10n.authUsernameHeading,
              style: typography.screenTitle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: PokidokiSpacing.xs),
            Text(
              l10n.authUsernameBody,
              style: typography.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: PokidokiSpacing.xl),
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                controller: _controller,
                onChanged: _onChanged,
                style: typography.body,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: colors.textTertiary,
                  ),
                  prefixText: '@',
                  suffixIcon: _checking
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : Icon(
                          _available == true
                              ? Icons.check_circle_rounded
                              : Icons.circle_outlined,
                          color: _available == true
                              ? colors.secure
                              : colors.textTertiary,
                        ),
                ),
              ),
            ),
            const SizedBox(height: PokidokiSpacing.sm),
            if (_available == true)
              Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: colors.secure,
                    size: 18,
                  ),
                  const SizedBox(width: PokidokiSpacing.xs),
                  LtrText(
                    l10n.authUsernameAvailable(username),
                    style: typography.supportingBody.copyWith(
                      color: colors.secure,
                    ),
                  ),
                ],
              )
            else if (_available == false)
              Text(
                l10n.authUsernameUnavailable,
                style: typography.supportingBody.copyWith(color: colors.error),
              ),
            const SizedBox(height: PokidokiSpacing.xl),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surfaceElevated,
                borderRadius: PokidokiRadii.borderXl,
                border: Border.all(color: colors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(PokidokiSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.authUsernameRequirements,
                      style: typography.inputLabel,
                    ),
                    const SizedBox(height: PokidokiSpacing.md),
                    AuthRequirementRow(
                      label: l10n.authUsernameLength,
                      met: _lengthOk,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    AuthRequirementRow(
                      label: l10n.authUsernameCharset,
                      met: _charsetOk && username.isNotEmpty,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    AuthRequirementRow(
                      label: l10n.authUsernameStartsWithLetter,
                      met: _startsWithLetter,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    AuthRequirementRow(
                      label: l10n.authUsernameNoSpaces,
                      met: _noSpaces && username.isNotEmpty,
                    ),
                    const SizedBox(height: PokidokiSpacing.xs),
                    AuthRequirementRow(
                      label: l10n.authUsernameUnique,
                      met: _available == true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: PokidokiSpacing.xl),
            PokidokiButton.primary(
              label: l10n.actionContinue,
              onPressed: canContinue ? _continue : null,
            ),
          ],
        ),
      ),
    );
  }
}
