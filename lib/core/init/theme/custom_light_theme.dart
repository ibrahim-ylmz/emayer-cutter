import 'package:flutter/material.dart';
import 'package:emayer_cutter/core/init/theme/custom_color_scheme.dart';
import 'package:emayer_cutter/core/init/theme/custom_theme.dart';

/// Custom Light Theme
final class CustomLightTheme implements IAppTheme {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: CustomColorScheme.lightScheme(),
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData();
}
