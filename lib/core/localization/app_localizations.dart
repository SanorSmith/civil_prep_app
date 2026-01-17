import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  static const Map<String, Map<String, String>> _translations = {
    'sv': {
      // ============= NAVIGATION =============
      'home': 'Hem',
      'categories': 'Kategorier',
      'crisis_guide': 'Krisguide',
      'area': 'Område',
      'settings': 'Inställningar',
      
      // ============= HOME SCREEN =============
      'good_morning': 'God morgon',
      'good_day': 'God dag',
      'good_evening': 'God kväll',
      'readiness_status': 'Här är din beredskapsstatus',
      'fully_prepared': 'Du är helt förberedd!',
      'fully_prepared_desc': 'Din beredskap är komplett för alla scenarier. Bra jobbat!',
      'categories_title': 'Kategorier',
      'view_all': 'Visa alla',
      'maintenance_title': 'Underhåll & Kontroll',
      'reminders_active': 'Påminnelser aktiverade',
      'next_steps': 'Nästa viktiga steg',
      'complete': 'Klar!',
      'excellent': 'Utmärkt!',
      'good': 'Bra!',
      'keep_going': 'Fortsätt!',
      'get_started': 'Kom igång!',
      
      // ============= TIME PERIODS =============
      '24h': '24h',
      '72h': '72h',
      '7_days': '7 dagar',
      'hours': 'timmar',
      'days': 'dagar',
      'months': 'månader',
      'in_x_months': 'Om {0} månader',
      'in_x_days': 'Om {0} dagar',
      
      // ============= CATEGORIES =============
      'water': 'Vatten',
      'food': 'Mat',
      'heat': 'Värme',
      'light': 'Ljus',
      'radio': 'Radio',
      'medicine': 'Medicin',
      'hygiene': 'Hygien',
      'cash': 'Kontanter',
      
      // ============= CATEGORY DETAILS =============
      'progress': 'Framsteg',
      'items': 'Artiklar',
      'add_custom': 'Lägg till egen',
      'custom_item': 'Egen artikel',
      'item_name': 'Artikelnamn',
      'quantity': 'Mängd',
      'unit': 'Enhet',
      'priority': 'Prioritet',
      'high': 'Hög',
      'medium': 'Medel',
      'low': 'Låg',
      
      // ============= MAINTENANCE =============
      'rotate_water': 'Rotera vatten',
      'check_food': 'Kontrollera mat',
      'test_flashlight': 'Testa ficklampa',
      'check_batteries': 'Kontrollera batterier',
      'test_radio': 'Testa radio',
      'check_medicine': 'Kontrollera medicin',
      'why': 'Varför?',
      'how': 'Hur?',
      'mark_complete': 'Markera som utfört',
      'remind_later': 'Påminn mig senare',
      'next': 'Nästa',
      'completed': 'Slutförd',
      
      // ============= ONBOARDING =============
      'welcome': 'Välkommen',
      'welcome_title': 'Välkommen till Civil Beredskap',
      'welcome_desc': 'Vi hjälper dig förbereda ditt hushåll för kriser',
      'get_started_btn': 'Kom igång',
      'skip': 'Hoppa över',
      'next_btn': 'Nästa',
      'back': 'Tillbaka',
      'finish': 'Slutför',
      
      // Postal code
      'postal_code': 'Postnummer',
      'enter_postal_code': 'Ange ditt postnummer för att få lokala rekommendationer',
      'postal_code_why': 'Varför behöver vi detta?',
      'postal_code_reason': 'För att ge dig relevant information om ditt område',
      'postal_code_invalid': 'Ogiltigt postnummer',
      'invalid_postal': 'Ogiltigt svenskt postnummer',
      'step_1_of_4': 'Steg 1 av 4',
      'step_2_of_4': 'Steg 2 av 4',
      'step_3_of_4': 'Steg 3 av 4',
      'step_4_of_4': 'Steg 4 av 4',
      'app_name': 'Civil Beredskap',
      
      // Housing
      'housing_type': 'Boendetyp',
      'select_housing': 'Välj din boendetyp',
      'housing_situation': 'Din boendesituation',
      'housing_situation_desc': 'Detta hjälper oss beräkna dina beredskapsbehov',
      'apartment': 'Lägenhet',
      'apartment_desc': 'Flerbostadshus',
      'house': 'Villa/Radhus',
      'house_desc': 'Egen- eller radhus',
      'rural': 'Lantbruk/Landsbygd',
      'rural_desc': 'Gård eller landsbygd',
      'farm': 'Lantbruk',
      
      // Household
      'household': 'Hushåll',
      'household_size': 'Hushållets storlek',
      'household_size_desc': 'Hur många personer bor i ditt hushåll?',
      'adults': 'Vuxna',
      'adults_age': '18+ år',
      'children': 'Barn',
      'children_age': '3-17 år',
      'infants': 'Spädbarn',
      'infants_age': '0-2 år',
      'total': 'Totalt',
      'person': 'person',
      'people': 'personer',
      'at_least_one_adult': 'Minst en vuxen krävs',
      
      // Special needs
      'special_needs': 'Särskilda behov',
      'special_needs_desc': 'Finns det något vi bör veta?',
      'special_needs_question': 'Finns det något vi bör veta?',
      'medical_equipment': 'Medicinsk utrustning som kräver el',
      'medical_equipment_desc': 'T.ex. syrgaskoncentrator, CPAP',
      'pets': 'Husdjur',
      'pets_desc': 'Katt, hund, eller andra djur',
      'mobility': 'Rörelsehinder',
      'mobility_desc': 'Begränsad rörlighet',
      'allergies': 'Matallergier',
      'allergies_desc': 'Celiaki, laktos, nötter, etc.',
      'pet_count': 'Antal husdjur',
      'other_info': 'Annan information (valfritt)',
      'other_info_hint': 'T.ex. särskilda mediciner, behov...',
      
      // Privacy
      'privacy': 'Integritet',
      'share_data': 'Dela anonyma data',
      'share_data_desc': 'Hjälp oss förbättra appen',
      'privacy_explanation': 'Din data skyddas med k-anonymitet. Vi visar endast områdesstatistik när minst 50 hushåll deltar.',
      
      // Profile summary
      'profile_summary': 'Din beredskapsprofil',
      'profile_complete': 'Profilen är klar!',
      'profile_desc': 'Baserat på ditt hushåll har vi beräknat dina beredskapsbehov',
      'preparedness_levels': 'Beredskapsnivåer',
      '24_hours': '24 timmar',
      '72_hours': '72 timmar',
      'tip': 'Tips!',
      'start_24h': 'Börja med 24-timmars beredskap för snabba resultat!',
      'start_preparing': 'Börja förbereda',
      
      // ============= SETTINGS =============
      'profile': 'PROFIL',
      'privacy_caps': 'INTEGRITET',
      'notifications': 'NOTIFIKATIONER',
      'data_sync': 'DATA & SYNK',
      'app': 'APP',
      'account': 'KONTO',
      
      'privacy_policy': 'Integritetspolicy',
      'enable_notifications': 'Aktivera notifikationer',
      'notification_subtitle': 'Få påminnelser om underhåll',
      'frequency': 'Frekvens',
      'daily': 'Daglig',
      'weekly': 'Veckovis',
      'monthly': 'Månatlig',
      'types': 'Typer',
      'quiet_hours': 'Tysta timmar',
      
      'last_sync': 'Senaste synk',
      'sync_now': 'Synka nu',
      'clear_cache': 'Rensa cache',
      
      'language': 'Språk',
      'swedish': 'Svenska',
      'english': 'English',
      'dark_theme': 'Mörkt tema',
      'use_dark_theme': 'Använd mörkt färgschema',
      'version': 'Version',
      'about': 'Om Civil Beredskap',
      
      'export_data': 'Exportera data',
      'delete_account': 'Ta bort konto',
      
      // ============= ACTIONS =============
      'cancel': 'Avbryt',
      'save': 'Spara',
      'delete': 'Ta bort',
      'confirm': 'Bekräfta',
      'close': 'Stäng',
      'ok': 'OK',
      'yes': 'Ja',
      'no': 'Nej',
      'edit': 'Redigera',
      'add': 'Lägg till',
      'remove': 'Ta bort',
      'search': 'Sök',
      'of': 'av',
      'not_specified': 'Ej angivet',
      'adult_singular': 'vuxen',
      
      // ============= MESSAGES =============
      'synced': 'Synkad!',
      'sync_failed': 'Synkning misslyckades',
      'cache_cleared': 'Cache rensad',
      'saved': 'Sparat',
      'deleted': 'Raderat',
      'error': 'Ett fel uppstod',
      'success': 'Lyckades!',
      'loading': 'Laddar...',
      'no_internet': 'Ingen internetanslutning',
      'try_again': 'Försök igen',
      'language_changed': 'Språk ändrat till {0}',
      
      // ============= UNITS =============
      'liter': 'liter',
      'liters': 'liter',
      'piece': 'st',
      'pieces': 'st',
      'kg': 'kg',
      'gram': 'gram',
      'pack': 'förpackning',
      'packs': 'förpackningar',
      'bottle': 'flaska',
      'bottles': 'flaskor',
      'can': 'burk',
      'cans': 'burkar',
    },
    
    'en': {
      // ============= NAVIGATION =============
      'home': 'Home',
      'categories': 'Categories',
      'crisis_guide': 'Crisis Guide',
      'area': 'Area',
      'settings': 'Settings',
      
      // ============= HOME SCREEN =============
      'good_morning': 'Good morning',
      'good_day': 'Good day',
      'good_evening': 'Good evening',
      'readiness_status': 'Here is your readiness status',
      'fully_prepared': 'You are fully prepared!',
      'fully_prepared_desc': 'Your preparedness is complete for all scenarios. Well done!',
      'categories_title': 'Categories',
      'view_all': 'View all',
      'maintenance_title': 'Maintenance & Control',
      'reminders_active': 'Reminders active',
      'next_steps': 'Next important steps',
      'complete': 'Complete!',
      'excellent': 'Excellent!',
      'good': 'Good!',
      'keep_going': 'Keep going!',
      'get_started': 'Get started!',
      
      // ============= TIME PERIODS =============
      '24h': '24h',
      '72h': '72h',
      '7_days': '7 days',
      'hours': 'hours',
      'days': 'days',
      'months': 'months',
      'in_x_months': 'In {0} months',
      'in_x_days': 'In {0} days',
      
      // ============= CATEGORIES =============
      'water': 'Water',
      'food': 'Food',
      'heat': 'Heat',
      'light': 'Light',
      'radio': 'Radio',
      'medicine': 'Medicine',
      'hygiene': 'Hygiene',
      'cash': 'Cash',
      
      // ============= CATEGORY DETAILS =============
      'progress': 'Progress',
      'items': 'Items',
      'add_custom': 'Add custom',
      'custom_item': 'Custom item',
      'item_name': 'Item name',
      'quantity': 'Quantity',
      'unit': 'Unit',
      'priority': 'Priority',
      'high': 'High',
      'medium': 'Medium',
      'low': 'Low',
      
      // ============= MAINTENANCE =============
      'rotate_water': 'Rotate water',
      'check_food': 'Check food',
      'test_flashlight': 'Test flashlight',
      'check_batteries': 'Check batteries',
      'test_radio': 'Test radio',
      'check_medicine': 'Check medicine',
      'why': 'Why?',
      'how': 'How?',
      'mark_complete': 'Mark as complete',
      'remind_later': 'Remind me later',
      'next': 'Next',
      'completed': 'Completed',
      
      // ============= ONBOARDING =============
      'welcome': 'Welcome',
      'welcome_title': 'Welcome to Civil Preparedness',
      'welcome_desc': 'We help you prepare your household for emergencies',
      'get_started_btn': 'Get started',
      'skip': 'Skip',
      'next_btn': 'Next',
      'back': 'Back',
      'finish': 'Finish',
      
      // Postal code
      'postal_code': 'Postal Code',
      'enter_postal_code': 'Enter your postal code for local recommendations',
      'postal_code_why': 'Why do we need this?',
      'postal_code_reason': 'To provide relevant information about your area',
      'postal_code_invalid': 'Invalid postal code',
      'invalid_postal': 'Invalid Swedish postal code',
      'step_1_of_4': 'Step 1 of 4',
      'step_2_of_4': 'Step 2 of 4',
      'step_3_of_4': 'Step 3 of 4',
      'step_4_of_4': 'Step 4 of 4',
      'app_name': 'Civil Preparedness',
      
      // Housing
      'housing_type': 'Housing Type',
      'select_housing': 'Select your housing type',
      'housing_situation': 'Your Housing Situation',
      'housing_situation_desc': 'This helps us calculate your preparedness needs',
      'apartment': 'Apartment',
      'apartment_desc': 'Multi-family building',
      'house': 'House/Townhouse',
      'house_desc': 'Detached or townhouse',
      'rural': 'Farm/Rural',
      'rural_desc': 'Farm or rural area',
      'farm': 'Farm',
      
      // Household
      'household': 'Household',
      'household_size': 'Household Size',
      'household_size_desc': 'How many people live in your household?',
      'adults': 'Adults',
      'adults_age': '18+ years',
      'children': 'Children',
      'children_age': '3-17 years',
      'infants': 'Infants',
      'infants_age': '0-2 years',
      'total': 'Total',
      'person': 'person',
      'people': 'people',
      'at_least_one_adult': 'At least one adult required',
      
      // Special needs
      'special_needs': 'Special Needs',
      'special_needs_desc': 'Is there anything we should know?',
      'special_needs_question': 'Is there anything we should know?',
      'medical_equipment': 'Medical equipment requiring power',
      'medical_equipment_desc': 'E.g. oxygen concentrator, CPAP',
      'pets': 'Pets',
      'pets_desc': 'Cat, dog, or other animals',
      'mobility': 'Mobility Issues',
      'mobility_desc': 'Limited mobility',
      'allergies': 'Food Allergies',
      'allergies_desc': 'Celiac, lactose, nuts, etc.',
      'pet_count': 'Number of pets',
      'other_info': 'Other information (optional)',
      'other_info_hint': 'E.g. special medications, needs...',
      
      // Privacy
      'privacy': 'Privacy',
      'share_data': 'Share anonymous data',
      'share_data_desc': 'Help us improve the app',
      'privacy_explanation': 'Your data is protected with k-anonymity. We only show area statistics when at least 50 households participate.',
      
      // Profile summary
      'profile_summary': 'Your Preparedness Profile',
      'profile_complete': 'Profile is complete!',
      'profile_desc': 'Based on your household, we have calculated your preparedness needs',
      'preparedness_levels': 'Preparedness Levels',
      '24_hours': '24 hours',
      '72_hours': '72 hours',
      'tip': 'Tip!',
      'start_24h': 'Start with 24-hour preparedness for quick results!',
      'start_preparing': 'Start preparing',
      
      // ============= SETTINGS =============
      'profile': 'PROFILE',
      'privacy_caps': 'PRIVACY',
      'notifications': 'NOTIFICATIONS',
      'data_sync': 'DATA & SYNC',
      'app': 'APP',
      'account': 'ACCOUNT',
      
      'privacy_policy': 'Privacy Policy',
      'enable_notifications': 'Enable notifications',
      'notification_subtitle': 'Get reminders about maintenance',
      'frequency': 'Frequency',
      'daily': 'Daily',
      'weekly': 'Weekly',
      'monthly': 'Monthly',
      'types': 'Types',
      'quiet_hours': 'Quiet hours',
      
      'last_sync': 'Last sync',
      'sync_now': 'Sync now',
      'clear_cache': 'Clear cache',
      
      'language': 'Language',
      'swedish': 'Svenska',
      'english': 'English',
      'dark_theme': 'Dark Theme',
      'use_dark_theme': 'Use dark color scheme',
      'version': 'Version',
      'about': 'About Civil Preparedness',
      
      'export_data': 'Export data',
      'delete_account': 'Delete account',
      
      // ============= ACTIONS =============
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'confirm': 'Confirm',
      'close': 'Close',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',
      'edit': 'Edit',
      'add': 'Add',
      'remove': 'Remove',
      'search': 'Search',
      'of': 'of',
      'not_specified': 'Not specified',
      'adult_singular': 'adult',
      
      // ============= MESSAGES =============
      'synced': 'Synced!',
      'sync_failed': 'Sync failed',
      'cache_cleared': 'Cache cleared',
      'saved': 'Saved',
      'deleted': 'Deleted',
      'error': 'An error occurred',
      'success': 'Success!',
      'loading': 'Loading...',
      'no_internet': 'No internet connection',
      'try_again': 'Try again',
      'language_changed': 'Language changed to {0}',
      
      // ============= UNITS =============
      'liter': 'liter',
      'liters': 'liters',
      'piece': 'pc',
      'pieces': 'pcs',
      'kg': 'kg',
      'gram': 'gram',
      'pack': 'pack',
      'packs': 'packs',
      'bottle': 'bottle',
      'bottles': 'bottles',
      'can': 'can',
      'cans': 'cans',
    },
  };
  
  String t(String key, [List<String>? params]) {
    var text = _translations[locale.languageCode]?[key] ?? key;
    
    if (params != null) {
      for (var i = 0; i < params.length; i++) {
        text = text.replaceAll('{$i}', params[i]);
      }
    }
    
    return text;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) => ['sv', 'en'].contains(locale.languageCode);
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }
  
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
