import 'package:emayer_cutter/feature/home/home_screen.dart';
import 'package:emayer_cutter/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_router_name.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRouterName.splash,
  routes: [
    GoRoute(
      path: AppRouterName.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        // default page make dashboard
        GoRoute(path: AppRouterName.system, builder: (context, state) => const Scaffold(body: Center(child: Text('System')))),
        GoRoute(path: AppRouterName.stream, builder: (context, state) => const Scaffold(body: Center(child: Text('Stream')))),
        GoRoute(path: AppRouterName.help, builder: (context, state) => const Scaffold(body: Center(child: Text('Help')))),
        GoRoute(path: AppRouterName.lock, builder: (context, state) => const Scaffold(body: Center(child: Text('Lock')))),
      ],
    ),
  ],
);
