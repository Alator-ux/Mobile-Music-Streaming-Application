import 'package:client/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  Locale _locale = const Locale('ru');

  void _changeLocale() {
    _locale = _locale == Locale('ru') ? const Locale('en') : const Locale('ru');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: HelloWorld(changeLocale: _changeLocale),
    );
  }
}

class HelloWorld extends StatelessWidget {
  final VoidCallback changeLocale;

  const HelloWorld({super.key, required this.changeLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(AppLocalizations.of(context).greetings),
            IconButton(
              onPressed: changeLocale,
              icon: const Icon(Icons.language),
            ),
          ],
        ),
      ),
    );
  }
}
