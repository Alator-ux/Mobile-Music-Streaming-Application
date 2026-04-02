import 'package:client/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
