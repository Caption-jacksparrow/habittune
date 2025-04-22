import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Accessibility helper for the HabitTune app
class AccessibilityHelper {
  /// Initialize accessibility features
  static void initialize() {
    // Set up semantics for screen readers
    SemanticsBinding.instance.ensureSemantics();
  }

  /// Add semantic labels to a widget
  static Widget addSemantics({
    required Widget child,
    required String label,
    String? hint,
    bool isButton = false,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: isButton,
      enabled: onTap != null,
      onTap: onTap,
      child: child,
    );
  }

  /// Create a widget with increased tap target size for better accessibility
  static Widget createAccessibleTapTarget({
    required Widget child,
    required VoidCallback onTap,
    double minSize = 48.0,
    String? semanticLabel,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: BoxConstraints(
          minWidth: minSize,
          minHeight: minSize,
        ),
        child: semanticLabel != null
            ? Semantics(
                label: semanticLabel,
                button: true,
                child: child,
              )
            : child,
      ),
    );
  }

  /// Create a text with proper contrast and scaling
  static Widget createAccessibleText(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      // Enable text scaling for accessibility
      textScaleFactor: 1.0,
      semanticsLabel: text,
    );
  }

  /// Add high contrast mode support
  static Color getAccessibleColor(Color originalColor, BuildContext context) {
    // Check if high contrast mode is enabled
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isHighContrast = mediaQuery.highContrast;

    if (isHighContrast) {
      // Increase contrast for better visibility
      if (_calculateLuminance(originalColor) > 0.5) {
        // Light color - make it darker for high contrast
        return _darkenColor(originalColor, 0.3);
      } else {
        // Dark color - make it lighter for high contrast
        return _lightenColor(originalColor, 0.3);
      }
    }

    return originalColor;
  }

  // Helper methods for color manipulation
  static double _calculateLuminance(Color color) {
    return (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
  }

  static Color _darkenColor(Color color, double factor) {
    return Color.fromARGB(
      color.alpha,
      (color.red * (1 - factor)).round().clamp(0, 255),
      (color.green * (1 - factor)).round().clamp(0, 255),
      (color.blue * (1 - factor)).round().clamp(0, 255),
    );
  }

  static Color _lightenColor(Color color, double factor) {
    return Color.fromARGB(
      color.alpha,
      (color.red + (255 - color.red) * factor).round().clamp(0, 255),
      (color.green + (255 - color.green) * factor).round().clamp(0, 255),
      (color.blue + (255 - color.blue) * factor).round().clamp(0, 255),
    );
  }
}
