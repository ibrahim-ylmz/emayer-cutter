import 'size_extensions.dart';

/// Component sizing constants for portrait orientation (1080x1920)
class AppComponentSizes {
  AppComponentSizes._();

  // Sidebar dimensions optimized for portrait width
  static double get sidebarCollapsedWidth => 75.6.w;
  static double get sidebarExpandedWidth => 194.4.w;
  
  // Top bar height
  static double get topBarHeight => 64.h;
  
  // Button sizes
  static double get buttonHeight => 48.h;
  static double get buttonWidth => 120.w;
  static double get iconButtonSize => 40.s;
  
  // Icon sizes
  static double get smallIcon => 16.s;
  static double get mediumIcon => 24.s;
  static double get largeIcon => 32.s;
  
  // Font sizes optimized for portrait
  static double get titleFontSize => 24.sp;
  static double get subtitleFontSize => 18.sp;
  static double get bodyFontSize => 14.sp;
  static double get captionFontSize => 12.sp;
  
  // Spacing
  static double get smallSpacing => 8.s;
  static double get mediumSpacing => 16.s;
  static double get largeSpacing => 24.s;
  static double get extraLargeSpacing => 32.s;
  
  // Border radius
  static double get smallRadius => 4.r;
  static double get mediumRadius => 8.r;
  static double get largeRadius => 12.r;
  
  // Container dimensions
  static double get cardWidth => 300.w;
  static double get cardHeight => 200.h;
  static double get dialogWidth => 400.w;
  static double get dialogMaxHeight => 600.h;
}
