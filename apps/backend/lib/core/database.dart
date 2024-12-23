import 'package:backend/core/env.dart';
import 'package:postgres/postgres.dart';

late final Connection connection;

Future<void> initializeDatabase() async {
  final databaseUri = Uri.parse(Env.databaseUrl);
  final [username, password] = databaseUri.userInfo.split(':');
  final sslMode = SslMode.values.firstWhere(
    (s) => s.name == databaseUri.queryParameters['sslmode'],
  );

  connection = await Connection.open(
    Endpoint(
      host: databaseUri.host,
      port: databaseUri.port,
      database: databaseUri.path.substring(1),
      username: username,
      password: password,
    ),
    settings: ConnectionSettings(sslMode: sslMode),
  );
}
