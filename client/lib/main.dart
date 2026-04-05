import 'package:client/data/datasources/local/auth_storage.dart';
import 'package:client/l10n/gen/app_localizations.dart';
import 'package:client/presentation/controllers/audio_player_controller.dart';
import 'package:client/presentation/screens/login/login_screen.dart';
import 'package:client/providers/locale_provider.dart';
import 'package:client/providers/theme_provider.dart';
import 'package:client/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/home/home_screen.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AudioPlayerController>(
    () => AudioPlayerController(),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  final token = await AuthStorage().getToken();
  final bool isLoggedIn = token != null && token.isNotEmpty;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: TestApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class TestApp extends StatelessWidget {
  final bool isLoggedIn;

  const TestApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localeProvider.locale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
