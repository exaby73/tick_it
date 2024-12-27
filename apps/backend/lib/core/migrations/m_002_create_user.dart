import 'package:goose/goose.dart';
import 'package:postgres/postgres.dart';

final class Migration002CreateUser extends Migration {
  final Connection _db;

  const Migration002CreateUser(this._db) : super('002_create_user');

  @override
  Future<void> up() async {
    await _db.execute('''
      CREATE TABLE users (
        id BIGSERIAL PRIMARY KEY,
        name TEXT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMP NOT NULL DEFAULT NOW()
      )
    ''');

    await _db.execute('''
      CREATE TRIGGER update_users_updated_at
      BEFORE UPDATE ON users
      FOR EACH ROW
      EXECUTE FUNCTION update_modified_column()
    ''');
  }

  @override
  Future<void> down() async {
    await _db.execute('DROP TRIGGER update_users_updated_at ON users');
    await _db.execute('DROP TABLE users');
  }
}
