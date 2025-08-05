import 'app_dimensions.dart';

/// Extension methods for responsive sizing in portrait orientation
extension SizeExtensions on num {
  /// Width scaling based on 1080px base width
  double get w => (this * AppDimensions.baseWidth) / 1080;
  
  /// Height scaling based on 1920px base height  
  double get h => (this * AppDimensions.baseHeight) / 1920;
  
  /// Proportional scaling (uses smaller dimension for consistent sizing)
  double get s => (this * AppDimensions.baseWidth) / 1080;
  
  /// Font size scaling optimized for portrait
  double get sp => (this * AppDimensions.baseWidth) / 1080;
  
  /// Radius scaling
  double get r => (this * AppDimensions.baseWidth) / 1080;
}
