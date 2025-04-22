import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habittune/core/theme/app_theme.dart';

/// Performance optimization class for the HabitTune app
class PerformanceOptimizer {
  /// Initialize performance optimizations
  static void initialize() {
    // Set preferred orientations to portrait only for better performance
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Enable image caching
    PaintingBinding.instance.imageCache.maximumSize = 100;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 50 * 1024 * 1024; // 50 MB

    // Set up system UI overlay style for better contrast
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppTheme.deepPurple,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Apply performance optimizations to a widget
  static Widget optimizeWidget(Widget child) {
    return RepaintBoundary(
      child: child,
    );
  }

  /// Apply memory optimizations for list views
  static Widget optimizeListView({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    ScrollController? controller,
  }) {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      controller: controller,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
      cacheExtent: 500, // Cache more items for smoother scrolling
    );
  }

  /// Apply memory optimizations for grid views
  static Widget optimizeGridView({
    required SliverGridDelegate gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    ScrollController? controller,
  }) {
    return GridView.builder(
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      controller: controller,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
      cacheExtent: 500, // Cache more items for smoother scrolling
    );
  }
}
