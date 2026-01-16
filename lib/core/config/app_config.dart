class AppConfig {
  static late String supabaseUrl;
  static late String supabaseAnonKey;
  static late String environment;

  static const int K_ANONYMITY_THRESHOLD = 50;
  static const Duration SYNC_INTERVAL = Duration(hours: 6);
  static const Duration CACHE_EXPIRY = Duration(days: 7);

  static Future<void> initialize() async {
    environment = const String.fromEnvironment('ENV', defaultValue: 'dev');
    
    supabaseUrl = const String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: '',
    );
    
    supabaseAnonKey = const String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: '',
    );
  }

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'dev';
}
