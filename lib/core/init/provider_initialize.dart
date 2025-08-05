import 'package:emayer_cutter/feature/home/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emayer_cutter/core/notifiers/theme_notifier.dart';

class ProviderInitialize extends StatelessWidget {
  const ProviderInitialize({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeNotifier(),
        ),
      ],
      child: child,
    );
  }
}
