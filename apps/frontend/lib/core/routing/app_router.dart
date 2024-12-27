import 'package:auto_route/auto_route.dart';
import 'package:frontend/core/injection.dart';
import 'package:frontend/core/routing/app_router.gr.dart';
import 'package:frontend/core/routing/guards/auth_guard.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@singleton
@AutoRouterConfig()
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRouteGuard> get guards {
    return [di.authGuard];
  }

  @override
  List<AutoRoute> get routes {
    return [
      CustomRoute(
        initial: true,
        path: '/',
        page: SplashRoute.page,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      ),
      CustomRoute(
        page: SigninRoute.page,
        path: '/auth/signin',
        transitionsBuilder: TransitionsBuilders.fadeIn,
      ),
    ];
  }
}

extension AppRouterDI on GetIt {
  AppRouter get router => di();
}
