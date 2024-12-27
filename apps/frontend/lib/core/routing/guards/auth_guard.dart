import 'package:auto_route/auto_route.dart';
import 'package:frontend/core/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@singleton
final class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // if (router.current is SplashRoute) {}
    resolver.next();
  }
}

extension AuthGuardDI on GetIt {
  AuthGuard get authGuard => di();
}
