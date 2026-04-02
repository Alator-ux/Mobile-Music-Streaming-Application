import 'package:client/extensions/context_extensions.dart';
import 'package:client/presentation/widgets/settings_picker.dart';
import 'package:client/providers/locale_provider.dart';
import 'package:client/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return context.l10n.theme_system;
      case ThemeMode.light:
        return context.l10n.theme_light;
      case ThemeMode.dark:
        return context.l10n.theme_dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Center(
      child: Column(
        spacing: 8,
        children: [
          Icon(Icons.account_circle, size: 170),
          Text('username', style: theme.textTheme.headlineMedium,),
          SettingsPicker<Locale>(
            initialValue: localeProvider.locale,
            buttonLabel:
                '${context.l10n.language}: ${localeProvider.locale.languageCode.toUpperCase()}',
            onSelected: (locale) => localeProvider.setLocale(locale),
            items: [
              PickerItem(value: const Locale('ru'), label: 'Русский'),
              PickerItem(value: const Locale('en'), label: 'English'),
            ],
          ),
          SettingsPicker<ThemeMode>(
            initialValue: themeProvider.themeMode,
            buttonLabel:
                '${context.l10n.theme}: ${_getThemeName(themeProvider.themeMode)}',
            onSelected: (mode) => themeProvider.setTheme(mode),
            items: [
              PickerItem(
                value: ThemeMode.system,
                label: context.l10n.theme_system,
                icon: Icons.brightness_auto,
              ),
              PickerItem(
                value: ThemeMode.light,
                label: context.l10n.theme_light,
                icon: Icons.light_mode,
              ),
              PickerItem(
                value: ThemeMode.dark,
                label: context.l10n.theme_dark,
                icon: Icons.dark_mode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
