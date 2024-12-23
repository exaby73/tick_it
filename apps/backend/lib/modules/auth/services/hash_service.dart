import 'package:hashlib/hashlib.dart';
import 'package:hashlib/random.dart';
import 'package:injectable/injectable.dart';

@singleton
final class HashService {
  const HashService();

  String hash(String password) {
    final salt = randomBytes(16);
    final digest = argon2i(password.codeUnits, salt);
    return digest.encoded();
  }

  bool verify(String hash, String password) {
    return argon2Verify(hash, password.codeUnits);
  }
}
