import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Analytics helper for the HabitTune app
class AnalyticsHelper {
  static bool _initialized = false;
  static bool _analyticsEnabled = true;
  
  /// Initialize analytics
  static void initialize() {
    if (_initialized) return;
    
    // In a real app, this would initialize analytics services
    // like Firebase Analytics, Amplitude, etc.
    _initialized = true;
    
    debugPrint('Analytics initialized');
  }
  
  /// Log a screen view event
  static void logScreenView(String screenName) {
    if (!_analyticsEnabled) return;
    
    // In a real app, this would log to the analytics service
    debugPrint('Screen view: $screenName');
  }
  
  /// Log a user action event
  static void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    if (!_analyticsEnabled) return;
    
    // In a real app, this would log to the analytics service
    debugPrint('Event: $eventName, Parameters: $parameters');
  }
  
  /// Log a habit creation event
  static void logHabitCreated(String habitId, String habitTitle, String frequency) {
    logEvent('habit_created', parameters: {
      'habit_id': habitId,
      'habit_title': habitTitle,
      'frequency': frequency,
    });
  }
  
  /// Log a habit completion event
  static void logHabitCompleted(String habitId, String habitTitle) {
    logEvent('habit_completed', parameters: {
      'habit_id': habitId,
      'habit_title': habitTitle,
    });
  }
  
  /// Log an achievement unlocked event
  static void logAchievementUnlocked(String achievementId, String achievementTitle) {
    logEvent('achievement_unlocked', parameters: {
      'achievement_id': achievementId,
      'achievement_title': achievementTitle,
    });
  }
  
  /// Enable or disable analytics
  static void setAnalyticsEnabled(bool enabled) {
    _analyticsEnabled = enabled;
    debugPrint('Analytics ${enabled ? 'enabled' : 'disabled'}');
  }
}
