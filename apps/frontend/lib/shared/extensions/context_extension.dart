import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

extension ContextExtension on BuildContext {
  ShadThemeData get theme => ShadTheme.of(this);

  ShadTextTheme get textTheme => theme.textTheme;
}
