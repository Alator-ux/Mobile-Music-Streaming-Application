import 'package:client/l10n/gen/app_localizations.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class FormValidators {
  static String? _combine(List<String? Function()> validators) {
    for (final validator in validators) {
      final res = validator();
      if (res != null) return res;
    }
    return null;
  }

  static bool _isPasswordValid(String value) {
    RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>+-=-_;]).{8,}$',
    );
    return regex.hasMatch(value);
  }

  static String? isEmpty(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context).empty_field;
    }
    return null;
  }

  static String? emailValidator(BuildContext context, String? value) {
    return _combine([
      () => isEmpty(context, value),
      () => !EmailValidator.validate(value!)
          ? AppLocalizations.of(context).invalid_email
          : null,
    ]);
  }

  static String? passwordValidator(BuildContext context, String? value) {
    return _combine([
      () => isEmpty(context, value),
      () => !_isPasswordValid(value!)
          ? AppLocalizations.of(context).password_too_weak
          : null,
    ]);
  }

  static String? passwordConfirmValidator(
    BuildContext context,
    String? value,
    String? passwordValue,
  ) {
    return _combine([
      () => isEmpty(context, value),
      () => value != passwordValue
          ? AppLocalizations.of(context).passwords_dont_match
          : null,
    ]);
  }
}
