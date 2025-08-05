import 'package:flutter/material.dart';

/// Base class for defining themes
abstract class IAppTheme {
  /// Main theme data for the app
  ThemeData get themeData;

  ///
  FloatingActionButtonThemeData get floatingActionButtonThemeData;
}
