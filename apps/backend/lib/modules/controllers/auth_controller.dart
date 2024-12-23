import 'package:arcade/arcade.dart';
import 'package:backend/modules/auth/dtos/signin_dto.dart';
import 'package:backend/modules/auth/dtos/signup_dto.dart';
import 'package:backend/modules/auth/services/auth_service.dart';
import 'package:backend/shared/extensions/luthor_extension.dart';
import 'package:injectable/injectable.dart';

@singleton
final class AuthController {
  final AuthService _authService;

  AuthController(this._authService) {
    route.group<RequestContext>(
      '/auth',
      defineRoutes: (route) {
        route.post('/signup').handle(_signup);
        route.post('/signin').handle(_signin);
      },
    );
  }

  Future<SignupResponseDto> _signup(RequestContext context) async {
    final dto = await $SignupRequestDtoValidate.withLuthor(context);
    return _authService.signup(dto);
  }

  Future<SignupResponseDto> _signin(RequestContext context) async {
    final dto = await $SigninRequestDtoValidate.withLuthor(context);
    return _authService.signin(dto);
  }
}
