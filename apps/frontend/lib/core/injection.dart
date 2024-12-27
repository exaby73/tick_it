import 'package:frontend/core/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final di = GetIt.instance;

@injectableInit
void configureInjection() {
  di.init();
}
