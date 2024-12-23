import 'package:backend/core/migrations/m_001_add_updated_at_function.dart';
import 'package:backend/core/migrations/m_002_create_user.dart';
import 'package:backend/core/migrations/m_003_create_user_email_index.dart';
import 'package:goose/goose.dart';
import 'package:postgres/postgres.dart';

final class Migrator {
  late final Goose _goose;
  final Connection _db;

  Migrator(this._db) {
    _goose = Goose(
      migrations: [
        Migration001AddUpdatedAtFunction(_db),
        Migration002CreateUser(_db),
        Migration003CreateUserEmailIndex(_db),
      ],
      store: (index) async {
        final migrationRow = await _db.execute('SELECT id FROM migrations');
        if (migrationRow.isEmpty) {
          await _db.execute(
            Sql.named('INSERT INTO migrations (index) VALUES (@index)'),
            parameters: {
              'index': index,
            },
          );
        } else {
          await _db.execute(
            Sql.named('UPDATE migrations SET index = @index'),
            parameters: {
              'index': index,
            },
          );
        }
      },
      retrieve: () async {
        await _db.execute('''
          CREATE TABLE IF NOT EXISTS migrations (
            id SERIAL PRIMARY KEY,
            index BIGINT NOT NULL
          )
        ''');
        final result = await _db.execute('SELECT index FROM migrations');
        return result.firstOrNull?.first as int?;
      },
    );
  }

  Future<void> up() async {
    await _goose.up();
  }

  Future<void> down() async {
    await _goose.down();
  }
}
