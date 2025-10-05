import 'dart:developer' as dev;

import 'package:film_link/core/config/supabase_config.dart';
import 'package:film_link/core/router/app_router.dart';
import 'package:film_link/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize logger
  AppLogger.init();
  final logger = AppLogger.getLogger('Main');
  
  try {
    // Initialize Supabase
    // Always initialize Supabase with default or configured values
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
    );
    
    if (SupabaseConfig.isConfigured) {
      logger.info('Supabase initialized successfully with provided configuration');
    } else {
      logger.warning('Supabase initialized with default values. Please set SUPABASE_URL and SUPABASE_ANON_KEY');
      dev.log(
        'WARNING: Supabase initialized with default values. Please update .env file or lib/core/config/supabase_config.dart',
        name: 'Main',
      );
    }
  } catch (e, stackTrace) {
    logger.severe('Failed to initialize Supabase', e, stackTrace);
    dev.log(
      'ERROR: Failed to initialize Supabase: $e',
      name: 'Main',
      error: e,
      stackTrace: stackTrace,
    );
  }
  
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'FilmLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
      ),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
