import 'package:arcade/arcade.dart';
import 'package:arcade_swagger/arcade_swagger.dart';
import 'package:backend/modules/auth/dtos/refresh_dto.dart';
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
        route()
            .swagger(
              tags: ['Auth'],
              request: $SignupRequestDtoSchema,
              responses: {
                '201': $SignupResponseDtoSchema,
              },
            )
            .post('/signup')
            .handle(_signup);

        route()
            .swagger(
              tags: ['Auth'],
              request: $SigninRequestDtoSchema,
              responses: {
                '200': $SignupResponseDtoSchema,
              },
            )
            .post('/signin')
            .handle(_signin);

        route()
            .swagger(
              tags: ['Auth'],
              request: $RefreshRequestDtoSchema,
              responses: {
                '200': $SignupResponseDtoSchema,
              },
            )
            .post('/refresh')
            .handle(_refresh);
      },
    );
  }

  Future<SignupResponseDto> _signup(RequestContext context) async {
    context.statusCode = 201;
    final dto = await $SignupRequestDtoValidate.withLuthor(context);
    return _authService.signup(dto);
  }

  Future<SignupResponseDto> _signin(RequestContext context) async {
    final dto = await $SigninRequestDtoValidate.withLuthor(context);
    return _authService.signin(dto);
  }

  Future<SignupResponseDto> _refresh(RequestContext context) async {
    final dto = await $RefreshRequestDtoValidate.withLuthor(context);
    return _authService.refresh(dto);
  }
}
