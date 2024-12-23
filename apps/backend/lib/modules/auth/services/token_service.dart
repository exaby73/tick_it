import 'package:arcade/arcade.dart';
import 'package:backend/core/env.dart';
import 'package:backend/modules/auth/models/jwt_payload.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:injectable/injectable.dart';

@singleton
final class TokenService {
  const TokenService();

  String generateAccessToken(JwtPayload payload) {
    return _generateToken(
      payload,
      Env.jwtAccessSecret,
      const Duration(minutes: 15),
    );
  }

  JwtPayload verifyAccessToken(String token) {
    return _verifyToken(token, Env.jwtAccessSecret);
  }

  String generateRefreshToken(JwtPayload payload) {
    return _generateToken(
      payload,
      Env.jwtRefreshSecret,
      const Duration(days: 30),
    );
  }

  JwtPayload verifyRefreshToken(String token) {
    return _verifyToken(token, Env.jwtRefreshSecret);
  }

  String _generateToken(JwtPayload payload, String secret, Duration duration) {
    final jwt = JWT(payload.toJson());
    return jwt.sign(SecretKey(secret), expiresIn: duration);
  }

  JwtPayload _verifyToken(String token, String secret) {
    try {
      final jwt = JWT.verify(token, SecretKey(secret));
      return JwtPayload.fromJson(jwt.payload as Map<String, dynamic>);
    } catch (e) {
      throw const UnauthorizedException();
    }
  }
}
