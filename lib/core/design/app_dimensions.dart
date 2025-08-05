/// Professional sizing system for portrait orientation (1080x1920)
/// Designed specifically for Linux full-screen applications
class AppDimensions {
  AppDimensions._();

  // Base design resolution - Portrait orientation
  static const double baseWidth = 1080.0;
  static const double baseHeight = 1920.0;

  // Screen size getters (for reference)
  static double get screenWidth => baseWidth;
  static double get screenHeight => baseHeight;

  // Design aspect ratio
  static double get aspectRatio => baseWidth / baseHeight;

  // Safe area considerations for Linux
  static const double statusBarHeight = 0.0; // Linux doesn't have status bar
  static const double navigationBarHeight = 0.0; // Linux doesn't have nav bar
  
  // Usable screen dimensions
  static double get usableWidth => baseWidth;
  static double get usableHeight => baseHeight;
}
