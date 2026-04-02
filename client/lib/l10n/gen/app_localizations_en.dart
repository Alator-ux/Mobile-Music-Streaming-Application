// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get greetings => 'Hello, world!';

  @override
  String get header_login => 'Log in to your account';

  @override
  String get header_signup => 'Create an account';

  @override
  String get name_label => 'Name or username';

  @override
  String get email_label => 'Email address';

  @override
  String get password_label => 'Password';

  @override
  String get password_confirm_label => 'Confirm password';

  @override
  String get login_label => 'Username';

  @override
  String get button_submit => 'Log In';

  @override
  String get button_signup => 'Sign up';

  @override
  String get empty_field => 'The field must not be empty!';

  @override
  String get passwords_dont_match => 'Passwords do not match!';

  @override
  String get no_account => 'Don’t have an account? ';

  @override
  String get already_have_account => 'Already have an account? ';

  @override
  String get button_login => 'Log in';

  @override
  String get invalid_email => 'Please enter a valid email address!';

  @override
  String get password_too_weak =>
      'Password must be 8+ chars, with Uppercase, Lowercase, Number, and Special Char.';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get theme_system => 'System';

  @override
  String get theme_light => 'Light';

  @override
  String get theme_dark => 'Dark';

  @override
  String get tab_tracks => 'Tracks';

  @override
  String get tab_favorites => 'Favorites';

  @override
  String get playlist => 'Playlist';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_favorites => 'Favorites';

  @override
  String get nav_profile => 'Profile';
}
