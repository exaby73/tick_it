import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/injection.dart';
import 'package:frontend/core/routing/app_router.dart';
import 'package:frontend/core/routing/app_router.gr.dart';
import 'package:frontend/shared/extensions/context_extension.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    const curve = Curves.easeInOutCubic;
    const duration = Duration(milliseconds: 500);
    return Scaffold(
      body: Center(
        child: Animate(
          effects: const [
            ScaleEffect(
              begin: Offset(1, 1),
              end: Offset(20, 20),
              curve: curve,
              duration: duration,
            ),
            FadeEffect(
              begin: 1,
              end: 0,
              curve: curve,
              duration: duration,
            ),
          ],
          delay: const Duration(seconds: 1),
          onComplete: (controller) {
            di.router.replace(const SigninRoute());
          },
          child: Text(
            'Tick-It',
            style: context.textTheme.h1Large,
          ),
        ),
      ),
    );
  }
}
