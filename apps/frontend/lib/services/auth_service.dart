import 'package:frontend/api/export.dart';
import 'package:frontend/shared/either.dart';
import 'package:frontend/shared/failure.dart';
import 'package:frontend/shared/utils/handle_http_errors.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@singleton
final class AuthService {
  final AuthClient _authClient;

  const AuthService(this._authClient);

  Future<Either<Failure, AuthResponse>> signup(SignupRequest body) {
    return handleDioErrors(
      () => _authClient.postAuthSignup(body: body),
    );
  }

  Future<Either<Failure, AuthResponse>> signin(SigninRequest body) {
    return handleDioErrors(
      () => _authClient.postAuthSignin(body: body),
    );
  }

  Future<Either<Failure, AuthResponse>> refresh(RefreshRequest body) {
    return handleDioErrors(
      () => _authClient.postAuthRefresh(body: body),
    );
  }
}

extension DIAuthService on GetIt {
  AuthService get authService => this();
}
