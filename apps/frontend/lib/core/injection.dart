import 'package:dio/dio.dart';
import 'package:frontend/api/auth/auth_client.dart';
import 'package:frontend/core/env.dart';
import 'package:frontend/core/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final di = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  await Future.value(di.init());
}

@module
abstract class ExternalModules {
  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
      ),
    );
  }

  @singleton
  AuthClient authClient(Dio dio) {
    return AuthClient(dio);
  }
}
