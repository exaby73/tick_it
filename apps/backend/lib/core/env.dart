import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(useConstantCase: true, interpolate: true)
class Env {
  const Env._();

  @EnviedField()
  static const int port = _Env.port;

  @EnviedField()
  static const String databaseUrl = _Env.databaseUrl;

  @EnviedField()
  static const String jwtAccessSecret = _Env.jwtAccessSecret;

  @EnviedField()
  static const String jwtRefreshSecret = _Env.jwtRefreshSecret;
}
