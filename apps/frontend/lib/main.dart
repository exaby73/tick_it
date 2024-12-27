import 'package:flutter/material.dart';
import 'package:frontend/core/injection.dart';
import 'package:frontend/core/routing/app_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  configureInjection();
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
        colorScheme: ShadSlateColorScheme.dark(),
        brightness: Brightness.dark,
      ),
    );
  }
}
