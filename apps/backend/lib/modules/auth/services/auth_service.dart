import 'package:arcade/arcade.dart';
import 'package:backend/modules/auth/dtos/auth_response_dto.dart';
import 'package:backend/modules/auth/dtos/auth_response_dto.dart';
import 'package:backend/modules/auth/dtos/refresh_dto.dart';
import 'package:backend/modules/auth/dtos/signin_dto.dart';
import 'package:backend/modules/auth/dtos/signup_dto.dart';
import 'package:backend/modules/auth/models/jwt_payload.dart';
import 'package:backend/modules/auth/models/user.dart';
import 'package:backend/modules/auth/repositories/auth_reporsitory.dart';
import 'package:backend/modules/auth/services/hash_service.dart';
import 'package:backend/modules/auth/services/token_service.dart';
import 'package:injectable/injectable.dart';

@singleton
final class AuthService {
  final AuthRepository _authRepository;
  final HashService _hashService;
  final TokenService _tokenService;

  const AuthService(
    this._authRepository,
    this._hashService,
    this._tokenService,
  );

  Future<AuthResponseDto> signup(SignupRequestDto dto) async {
    final userExists = await _authRepository.userExistsByEmail(dto.email);
    if (userExists) {
      throw const ConflictException(message: 'User already exists');
    }

    final user = await _authRepository.createUser(
      UserInserable(
        name: dto.name,
        email: dto.email,
        password: _hashService.hash(dto.password),
      ),
    );

    final payload = JwtPayload(id: user.id);
    final accessToken = _tokenService.generateAccessToken(payload);
    final refreshToken = _tokenService.generateRefreshToken(payload);

    return AuthResponseDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<AuthResponseDto> signin(SigninRequestDto dto) async {
    final user = await _authRepository.getUserByEmail(dto.email);
    if (user == null) {
      throw const NotFoundException(message: 'User not found');
    }

    final passwordMatch = _hashService.verify(user.password, dto.password);
    if (!passwordMatch) {
      throw const UnauthorizedException(message: 'Invalid password');
    }

    final payload = JwtPayload(id: user.id);
    final accessToken = _tokenService.generateAccessToken(payload);
    final refreshToken = _tokenService.generateRefreshToken(payload);

    return AuthResponseDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<AuthResponseDto> refresh(RefreshRequestDto dto) async {
    final payload = _tokenService.verifyRefreshToken(dto.refreshToken);
    final accessToken = _tokenService.generateAccessToken(payload);
    final refreshToken = _tokenService.generateRefreshToken(payload);
    return AuthResponseDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
