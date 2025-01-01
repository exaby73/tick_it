import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/injection.dart';
import 'package:frontend/core/routing/app_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Future<void> main() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await configureInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.router(
      routerConfig: di.router.config(),
      themeMode: ThemeMode.dark,
      darkTheme: ShadThemeData(
        colorScheme: const ShadSlateColorScheme.dark(),
        brightness: Brightness.dark,
      ),
    );
  }
}
