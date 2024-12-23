// ignore_for_file: avoid_print

import 'package:backend/core/init.dart';
import 'package:backend/core/migrations/migrator.dart';
import 'package:postgres/postgres.dart';

Future<void> main(List<String> arguments) async {
  await init();
  final db = di<Connection>();

  try {
    final migrator = Migrator(db);

    if (arguments.isEmpty) {
      print('Usage: migrate <up|down>');
      return;
    }

    final direction = arguments.single;
    switch (direction) {
      case 'up':
        await migrator.up();
        print('Migrated up');
      case 'down':
        await migrator.down();
        print('Migrated down');
      default:
        print('Usage: migrate <up|down>');
    }
  } finally {
    await db.close();
  }
}
