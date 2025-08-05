import 'dart:async';
import 'package:flutter/material.dart';

@immutable
/// This class is used initialize the application process
final class ApplicationInitialize {
  /// Project basic required initialize
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {});
  }

  /// This method is used to initialize the application process
  Future<void> _initialize() async {
    
  }
}
