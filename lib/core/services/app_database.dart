import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/medicines/data/models/medicine_intake_record.dart';
import '../../features/medicines/data/models/medicine_record.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('appDatabaseProvider must be overridden in main');
});

class AppDatabase {
  AppDatabase(this.isar);

  final Isar isar;

  static Future<AppDatabase> create() async {
    final directory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [MedicineRecordSchema, MedicineIntakeRecordSchema],
      directory: directory.path,
      name: 'health_companion_db',
    );
    return AppDatabase(isar);
  }
}
