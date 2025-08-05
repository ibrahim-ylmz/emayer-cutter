import 'package:flutter/material.dart';
import 'app_dimensions.dart';

/// Responsive helper utilities for portrait orientation
class ResponsiveHelpers {
  ResponsiveHelpers._();

  /// Check if screen is in portrait mode (always true for our 1080x1920 setup)
  static bool isPortrait(BuildContext context) => true;

  /// Check if screen is in landscape mode (always false for our setup)
  static bool isLandscape(BuildContext context) => false;

  /// Get responsive width percentage
  static double widthPercent(double percent) {
    return (AppDimensions.baseWidth * percent) / 100;
  }

  /// Get responsive height percentage
  static double heightPercent(double percent) {
    return (AppDimensions.baseHeight * percent) / 100;
  }

  /// Check if content should be displayed in compact mode
  static bool isCompact(BuildContext context) {
    // For portrait orientation, we consider it compact when width < 600
    return AppDimensions.baseWidth < 600;
  }

  /// Get appropriate column count for grid layouts
  static int getGridColumnCount(BuildContext context) {
    // Optimized for 1080px width
    if (AppDimensions.baseWidth >= 900) return 3;
    if (AppDimensions.baseWidth >= 600) return 2;
    return 1;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding() {
    return EdgeInsets.symmetric(
      horizontal: AppDimensions.baseWidth * 0.04, // 4% of width
      vertical: AppDimensions.baseHeight * 0.02,   // 2% of height
    );
  }

  /// Get responsive margin
  static EdgeInsets getResponsiveMargin() {
    return EdgeInsets.symmetric(
      horizontal: AppDimensions.baseWidth * 0.02, // 2% of width
      vertical: AppDimensions.baseHeight * 0.01,   // 1% of height
    );
  }
}
