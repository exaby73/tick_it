import 'package:goose/goose.dart';
import 'package:postgres/postgres.dart';

final class Migration001AddUpdatedAtFunction extends Migration {
  final Connection _db;

  const Migration001AddUpdatedAtFunction(this._db)
      : super('001_add_updated_at_function');

  @override
  Future<void> up() async {
    await _db.execute(r'''
      CREATE OR REPLACE FUNCTION update_modified_column()
      RETURNS TRIGGER AS $$
      BEGIN
          NEW.updatedAt = now();
          RETURN NEW;
      END;
      $$ language 'plpgsql';
    ''');
  }

  @override
  Future<void> down() async {
    await _db.execute('DROP FUNCTION update_modified_column');
  }
}
