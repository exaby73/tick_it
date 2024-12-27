import 'package:arcade_swagger/arcade_swagger.dart';
import 'package:backend/core/database.dart';
import 'package:backend/core/init.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

final di = GetIt.instance;

@injectableInit
Future<void> init() async {
  await di.reset();
  await di.init();

  setupSwagger(
    title: 'Tick-It',
    version: '1.0.0',
    securitySchemes: const {
      'auth': SecurityScheme.apiKey(
        name: 'Authorization',
        location: ApiKeyLocation.header,
      ),
    },
    servers: const [
      Server(url: 'http://localhost:7331'),
    ],
  );
}

@module
abstract class ExternalInjection {
  @singleton
  @preResolve
  Future<Connection> get db async {
    await initializeDatabase();
    return connection;
  }
}
