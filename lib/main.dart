import 'package:emayer_cutter/core/init/application_initialize.dart';
import 'package:emayer_cutter/core/init/provider_initialize.dart';
import 'package:emayer_cutter/core/init/theme/custom_dark_theme.dart';
import 'package:emayer_cutter/core/init/theme/custom_light_theme.dart';
import 'package:emayer_cutter/core/navigation/app_router.dart';
import 'package:emayer_cutter/core/notifiers/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  ApplicationInitialize().init();
  runApp(ProviderInitialize(child: const _MyApp()));
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          themeMode: themeNotifier.themeMode,
          theme: CustomLightTheme().themeData,
          darkTheme: CustomDarkTheme().themeData,
        );
      },
    );
  }
}
