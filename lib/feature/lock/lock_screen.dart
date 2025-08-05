import 'dart:async';

import 'package:emayer_cutter/core/constant/const_asset.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  late Timer _timer;
  late List<Color> _colors;
  late int _currentColorIndex;
  late Color _nextColor;

  @override
  void initState() {
    super.initState();
    _initializeColors();
    _startColorTransitionTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initializeColors() {
    _colors = [
      const Color(0xFF000000),
      const Color(0xFF7A7A7A),
      const Color(0xFF111111),
      const Color(0xFF696969),
      const Color(0xFF232323),
      const Color(0xFF575757),
      const Color(0xFF343434),
      const Color(0xFF464646),
    ];
    _currentColorIndex = 0;
    _nextColor = _colors[(_currentColorIndex + 1) % _colors.length];
  }

  void _startColorTransitionTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
        _nextColor = _colors[(_currentColorIndex + 1) % _colors.length];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _colors[_currentColorIndex].withValues(alpha: 1),
                _nextColor.withValues(alpha: 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AssetsConfirguration.splash, height: 70.h),
                SizedBox(height: 30.h),
                Text(
                  'Tap to unlock',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 18.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
