import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/app_config.dart';
import 'core/services/storage_service.dart';
import 'models/prep_item_model.dart';
import 'models/prep_category_model.dart';
import 'models/household_profile_model.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeApp();

  runApp(
    const ProviderScope(
      child: CivilPrepApp(),
    ),
  );
}

Future<void> _initializeApp() async {
  await Hive.initFlutter();
  
  // Register Hive adapters for PrepItem and PrepCategory only
  // User and HouseholdProfile now use SharedPreferences (no adapters needed)
  Hive.registerAdapter(PrepItemAdapter());
  Hive.registerAdapter(PrepCategoryAdapter());
  
  // Register enum adapters
  Hive.registerAdapter(HousingTypeAdapter());
  Hive.registerAdapter(HeatingTypeAdapter());
  
  await StorageService.initialize();
  
  await AppConfig.initialize();
}
