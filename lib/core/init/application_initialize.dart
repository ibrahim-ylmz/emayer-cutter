import 'dart:async';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

@immutable
/// This class is used initialize the application process
final class ApplicationInitialize {
  /// Project basic required initialize
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {});
  }

  /// This method is used to initialize the application process
  Future<void> _initialize() async {
    WindowOptions windowOptions = const WindowOptions(
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      fullScreen: true,
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
