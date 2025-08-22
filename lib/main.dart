// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package Imports
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Imports
import 'package:lendnborrow/core/cfg/themes.dart';
import 'package:lendnborrow/core/provider/settings_service_provider.dart';
import 'package:lendnborrow/feature/borrowed/borrowed_screen.dart';
import 'package:lendnborrow/feature/history/history_screen.dart';
import 'package:lendnborrow/feature/home/home_screen.dart';
import 'package:lendnborrow/feature/lent/lent_screen.dart';
import 'package:lendnborrow/feature/settings/settings_screen.dart';
import 'package:lendnborrow/l10n/app_localizations.dart';
import 'package:lendnborrow/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsAsync = ref.watch(settingsServiceNotifierProvider);

    return settingsAsync.when(
      data: (settings) => MaterialApp(
        title: "Lend & Borrow",
        themeMode: settings.themeMode,
        theme: light,
        darkTheme: dark,
        locale: settings.locale,
        supportedLocales: const [Locale("en", ""), Locale("de", "")],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routes: {
          HomeScreen.path: (context) => const MainScreen(child: HomeScreen()),
          BorrowedScreen.path: (context) =>
              const MainScreen(child: BorrowedScreen()),
          LentScreen.path: (context) => const MainScreen(child: LentScreen()),
          HistoryScreen.path: (context) =>
              const MainScreen(child: HistoryScreen()),
          SettingsScreen.path: (context) =>
              const MainScreen(child: SettingsScreen()),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const MainScreen(child: HomeScreen()),
        ),
      ),
      loading: () => Center(child: const CircularProgressIndicator()),
      error: (e, st) => Center(child: Text("Error: $e")),
    );
  }
}
