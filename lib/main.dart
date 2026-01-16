import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/app_config.dart';
import 'core/services/storage_service.dart';
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
  
  await StorageService.initialize();
  
  await AppConfig.initialize();
}
