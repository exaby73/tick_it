import 'package:backend/modules/auth/models/user.dart';
import 'package:backend/shared/utils/pretty_print.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@singleton
final class AuthRepository {
  final Connection _db;

  const AuthRepository(this._db);

  Future<User?> getUserByEmail(String email) async {
    final result = await _db.execute(
      Sql.named('SELECT * FROM users WHERE email = @email'),
      parameters: {'email': email},
    );
    if (result.isEmpty) {
      return null;
    }
    return User.fromJson(result.first.toColumnMap());
  }

  Future<bool> userExistsByEmail(String email) async {
    final result = await _db.execute(
      Sql.named('SELECT id FROM users WHERE email = @email'),
      parameters: {'email': email},
    );
    return result.isNotEmpty;
  }

  Future<User> createUser(UserInserable user) async {
    final result = await _db.execute(
      Sql.named('''
        INSERT INTO users (name, email, password)
        VALUES (@name, @email, @password)
        RETURNING *
      '''),
      parameters: {
        'name': user.name,
        'email': user.email,
        'password': user.password,
      },
    );
    return User.fromJson(result.first.toColumnMap());
  }
}
