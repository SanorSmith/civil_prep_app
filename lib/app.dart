import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/l10n/app_localizations.dart';
import 'core/localization/app_localizations.dart' as new_l10n;
import 'core/router/app_router.dart';
import 'core/services/storage_service.dart';

class CivilPrepApp extends ConsumerStatefulWidget {
  const CivilPrepApp({super.key});

  @override
  ConsumerState<CivilPrepApp> createState() => _CivilPrepAppState();
}

class _CivilPrepAppState extends ConsumerState<CivilPrepApp> {
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    // Load saved language
    final savedLanguage = await StorageService.getLanguage();
    if (savedLanguage != null) {
      ref.read(localeProvider.notifier).state = Locale(savedLanguage);
    }

    // Load saved theme mode
    final savedTheme = await StorageService.getThemeMode();
    if (savedTheme != null) {
      ref.read(themeModeProvider.notifier).state = 
        savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Civil Prep',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [
        Locale('sv'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        new_l10n.AppLocalizationsDelegate(),
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}

// Providers for locale and theme mode
final localeProvider = StateProvider<Locale>((ref) => const Locale('sv'));
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);
