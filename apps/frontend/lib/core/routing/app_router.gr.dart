// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:frontend/pages/auth/signin_page.dart' as _i1;
import 'package:frontend/pages/splash_page.dart' as _i2;

/// generated route for
/// [_i1.SigninPage]
class SigninRoute extends _i3.PageRouteInfo<void> {
  const SigninRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SigninRoute.name,
          initialChildren: children,
        );

  static const String name = 'SigninRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.SigninPage();
    },
  );
}

/// generated route for
/// [_i2.SplashPage]
class SplashRoute extends _i3.PageRouteInfo<void> {
  const SplashRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.SplashPage();
    },
  );
}
