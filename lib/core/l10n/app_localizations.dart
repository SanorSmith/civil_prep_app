import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'sv': {
      'app_name': 'Civil Beredskap',
      'home': 'Hem',
      'alerts': 'Varningar',
      'checklist': 'Checklista',
      'info': 'Information',
      'settings': 'Inställningar',
      'welcome': 'Välkommen',
      'get_started': 'Kom igång',
      'postal_code': 'Postnummer',
      'enter_postal_code': 'Ange ditt postnummer',
      'continue': 'Fortsätt',
      'skip': 'Hoppa över',
      'offline_mode': 'Offline-läge',
      'online_mode': 'Online-läge',
      'sync': 'Synkronisera',
      'last_synced': 'Senast synkroniserad',
      'never': 'Aldrig',
    },
    'en': {
      'app_name': 'Civil Preparedness',
      'home': 'Home',
      'alerts': 'Alerts',
      'checklist': 'Checklist',
      'info': 'Information',
      'settings': 'Settings',
      'welcome': 'Welcome',
      'get_started': 'Get Started',
      'postal_code': 'Postal Code',
      'enter_postal_code': 'Enter your postal code',
      'continue': 'Continue',
      'skip': 'Skip',
      'offline_mode': 'Offline Mode',
      'online_mode': 'Online Mode',
      'sync': 'Sync',
      'last_synced': 'Last synced',
      'never': 'Never',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String get appName => translate('app_name');
  String get home => translate('home');
  String get alerts => translate('alerts');
  String get checklist => translate('checklist');
  String get info => translate('info');
  String get settings => translate('settings');
  String get welcome => translate('welcome');
  String get getStarted => translate('get_started');
  String get postalCode => translate('postal_code');
  String get enterPostalCode => translate('enter_postal_code');
  String get continueText => translate('continue');
  String get skip => translate('skip');
  String get offlineMode => translate('offline_mode');
  String get onlineMode => translate('online_mode');
  String get sync => translate('sync');
  String get lastSynced => translate('last_synced');
  String get never => translate('never');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['sv', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
