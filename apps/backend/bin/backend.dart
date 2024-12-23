import 'package:arcade/arcade.dart';
import 'package:backend/core/env.dart';
import 'package:backend/core/init.dart';

Future<void> main(List<String> arguments) async {
  const dev = !bool.fromEnvironment('dart.vm.product');
  return runServer(
    port: Env.port,
    init: init,
    logLevel: dev ? LogLevel.info : LogLevel.error,
    closeServerAfterRoutesSetUp: arguments.contains('--export-routes'),
  );
}
