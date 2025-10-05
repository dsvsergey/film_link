/// Supabase configuration
/// 
/// Replace these values with your actual Supabase project credentials
class SupabaseConfig {
  // Default values for development/testing
  // These are placeholder values that will allow the app to initialize
  // but won't connect to a real Supabase instance
  static const String _defaultUrl = 'https://placeholder-supabase-url.supabase.co';
  static const String _defaultAnonKey = 'placeholder-anon-key';
  
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: _defaultUrl,
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: _defaultAnonKey,
  );
  
  /// Check if configuration is valid (using real values, not placeholders)
  static bool get isConfigured =>
      supabaseUrl != _defaultUrl &&
      supabaseAnonKey != _defaultAnonKey;
}
