import 'package:goose/goose.dart';
import 'package:postgres/postgres.dart';

final class Migration003CreateUserEmailIndex extends Migration {
  final Connection _db;

  const Migration003CreateUserEmailIndex(this._db)
      : super('003_create_user_email_index');

  @override
  Future<void> up() async {
    await _db.execute('CREATE UNIQUE INDEX users_email_idx ON users (email)');
  }

  @override
  Future<void> down() async {
    await _db.execute('DROP INDEX users_email_idx');
  }
}
