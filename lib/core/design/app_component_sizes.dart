import 'size_extensions.dart';

/// Component sizing constants for portrait orientation (1080x1920)
class AppComponentSizes {
  AppComponentSizes._();

  // Sidebar dimensions optimized for portrait width (increased)
  static double get sidebarCollapsedWidth => 90.w;
  static double get sidebarExpandedWidth => 240.w;
  
  // Top bar height (increased)
  static double get topBarHeight => 80.h;
  
  // Button sizes (increased)
  static double get buttonHeight => 56.h;
  static double get buttonWidth => 140.w;
  static double get iconButtonSize => 48.s;
  
  // Icon sizes (increased)
  static double get smallIcon => 20.s;
  static double get mediumIcon => 28.s;
  static double get largeIcon => 36.s;
  
  // Font sizes optimized for portrait (increased)
  static double get titleFontSize => 28.sp;
  static double get subtitleFontSize => 22.sp;
  static double get bodyFontSize => 16.sp;
  static double get captionFontSize => 14.sp;
  
  // Spacing (increased)
  static double get smallSpacing => 10.s;
  static double get mediumSpacing => 20.s;
  static double get largeSpacing => 30.s;
  static double get extraLargeSpacing => 40.s;
  
  // Border radius (increased)
  static double get smallRadius => 6.r;
  static double get mediumRadius => 10.r;
  static double get largeRadius => 16.r;
  
  // Container dimensions (increased)
  static double get cardWidth => 360.w;
  static double get cardHeight => 240.h;
  static double get dialogWidth => 480.w;
  static double get dialogMaxHeight => 720.h;
}
