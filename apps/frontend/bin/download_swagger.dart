import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';

Future<void> main(List<String> arguments) async {
  final dotenv = DotEnv()..load();
  final swaggerUrl = dotenv['SWAGGER_URL'];

  if (swaggerUrl == null) {
    throw StateError('SWAGGER_URL is not defined in .env file');
  }

  final dio = Dio();
  final response = await dio.get<String>(
    swaggerUrl,
    options: Options(responseType: ResponseType.plain),
  );
  final swaggerFile = File('swagger/swagger.json');
  if (!swaggerFile.existsSync()) {
    swaggerFile.createSync(recursive: true);
  }
  swaggerFile.writeAsStringSync(response.data!);
}
