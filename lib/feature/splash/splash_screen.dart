import 'package:emayer_cutter/core/constant/const_asset.dart';
import 'package:emayer_cutter/core/navigation/app_router_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _progressTimer;
  double _progress = 0.0;
  late final Random _random;
  late final int _targetDurationMs;
  @override
  void initState() {
    super.initState();
    _random = Random();
    _targetDurationMs = 5000 + _random.nextInt(3001); // 5000..8000 ms
    _startProgress();
  }

  void _startProgress() {
    const int tickMs = 100; // smooth updates
    _progressTimer = Timer.periodic(const Duration(milliseconds: tickMs), (
      timer,
    ) {
      if (!mounted) return;

      final bool shouldPause = _random.nextDouble() < 0.15;
      double baseIncrement = tickMs / _targetDurationMs;
      final double variability = 0.85 + _random.nextDouble() * 0.35;

      setState(() {
        if (!shouldPause) {
          _progress += baseIncrement * variability;
        }
        if (_progress >= 1.0) {
          _progress = 1.0;
          _progressTimer?.cancel();
          _progressTimer = null;
          if (mounted) {
            context.go(AppRouterName.system);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                AssetsConfirguration.splash,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 280,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 10,
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
