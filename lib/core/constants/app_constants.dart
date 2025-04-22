/// Constants for the HabitTune application
class AppConstants {
  // App information
  static const String appName = 'HabitTune';
  static const String appVersion = '1.0.0';
  
  // Hive box names
  static const String habitsBoxName = 'habits';
  static const String completionsBoxName = 'habit_completions';
  static const String achievementsBoxName = 'achievements';
  static const String userDataBoxName = 'user_data';
  
  // Brand colors
  static const String deepPurple = '#673AB7';
  static const String vibrantBlue = '#2196F3';
  static const String darkGray = '#212121';
  
  // Default values
  static const int defaultReminderNotificationId = 1000;
  static const int defaultStreakThreshold = 2; // Number of consecutive completions to form a streak
  
  // Feature flags
  static const bool enableContextAwareTracking = true;
  static const bool enableGamification = true;
  static const bool enableChallenges = true;
  static const bool enableSocialFeatures = false;
}
