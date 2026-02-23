import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/services/app_database.dart';
import 'core/services/local_storage_service.dart';
import 'core/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDatabase = await AppDatabase.create();
  final localStorage = LocalStorageService();
  final notificationService = NotificationService();
  await notificationService.initialize();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(appDatabase),
        localStorageProvider.overrideWithValue(localStorage),
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: const HealthCompanionApp(),
    ),
  );
}
