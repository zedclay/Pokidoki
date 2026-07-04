import 'package:flutter/material.dart';

import '../../../../data/models/account_security.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';
import '../../../../design_system/typography/pokidoki_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../authentication/presentation/widgets/auth_requirement_row.dart';

class PasswordRequirementList extends StatelessWidget {
  const PasswordRequirementList({
    super.key,
    required this.password,
    this.currentPassword,
    this.showDifferentFromCurrent = false,
  });

  final String password;
  final String? currentPassword;
  final bool showDifferentFromCurrent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typography = context.pokidokiTypography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.accountPasswordRequirements, style: typography.caption),
        const SizedBox(height: PokidokiSpacing.xs),
        AuthRequirementRow(
          label: l10n.accountPasswordMinLength,
          met: AccountPasswordPolicy.hasMinLength(password),
        ),
        AuthRequirementRow(
          label: l10n.accountPasswordUpperLower,
          met:
              AccountPasswordPolicy.hasUpper(password) &&
              AccountPasswordPolicy.hasLower(password),
        ),
        AuthRequirementRow(
          label: l10n.accountPasswordNumber,
          met: AccountPasswordPolicy.hasNumber(password),
        ),
        AuthRequirementRow(
          label: l10n.accountPasswordSymbol,
          met: AccountPasswordPolicy.hasSymbol(password),
        ),
        if (showDifferentFromCurrent)
          AuthRequirementRow(
            label: l10n.accountPasswordDifferent,
            met:
                password.isNotEmpty &&
                currentPassword != null &&
                password != currentPassword,
          ),
      ],
    );
  }
}
