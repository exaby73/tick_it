import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(useConstantCase: true)
final class Env {
  const Env._();

  @EnviedField()
  static const String baseUrl = _Env.baseUrl;

  @EnviedField()
  static const String swaggerUrl = _Env.swaggerUrl;
}
