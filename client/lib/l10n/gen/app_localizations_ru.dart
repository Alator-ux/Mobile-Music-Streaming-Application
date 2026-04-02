// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get greetings => 'Привет, мир!';

  @override
  String get header_login => 'Войти в аккаунт';

  @override
  String get header_signup => 'Регистрация';

  @override
  String get name_label => 'Имя или никнейм';

  @override
  String get email_label => 'Электронная почта';

  @override
  String get password_label => 'Пароль';

  @override
  String get password_confirm_label => 'Подтвердите пароль';

  @override
  String get login_label => 'Логин';

  @override
  String get button_submit => 'Войти';

  @override
  String get button_signup => 'Зарегистрироваться';

  @override
  String get empty_field => 'Поле не должно быть пустым!';

  @override
  String get passwords_dont_match => 'Пароли не совпадают!';

  @override
  String get no_account => 'Нет аккаунта? ';

  @override
  String get already_have_account => 'Уже зарегистрированы? ';

  @override
  String get button_login => 'Войти';

  @override
  String get invalid_email => 'Введите корректный адрес электронной почты!';

  @override
  String get password_too_weak =>
      'Пароль должен содержать минимум 8 символов, включая заглавные и строчные буквы, цифры и специальные символы.';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get theme_system => 'Системная';

  @override
  String get theme_light => 'Светлая';

  @override
  String get theme_dark => 'Темная';

  @override
  String get tab_tracks => 'Треки';

  @override
  String get tab_favorites => 'Избранное';

  @override
  String get playlist => 'Плейлист';

  @override
  String get nav_home => 'Главная';

  @override
  String get nav_favorites => 'Избранное';

  @override
  String get nav_profile => 'Профиль';
}
