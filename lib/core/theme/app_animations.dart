import 'package:flutter/material.dart';

/// Custom animations for the HabitTune app based on brand guidelines
class AppAnimations {
  /// Create a progress circle completion animation
  static Animation<double> createProgressAnimation(
    AnimationController controller,
    double startValue,
    double endValue,
  ) {
    return Tween<double>(
      begin: startValue,
      end: endValue,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
  }

  /// Create a checkmark appearance animation
  static Animation<double> createCheckmarkAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  /// Create a celebration animation for achievement unlocks
  static Animation<double> createCelebrationAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    );
  }

  /// Create a fade-in animation
  static Animation<double> createFadeInAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
  }

  /// Create a scale animation
  static Animation<double> createScaleAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );
  }
}
