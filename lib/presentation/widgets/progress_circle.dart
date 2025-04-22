import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  const ProgressCircle({
    super.key,
    required this.progress,
    required this.size,
    required this.strokeWidth,
    this.progressColor = const Color(0xFF673AB7), // Deep Purple from brand guidelines
    this.backgroundColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          // Background circle
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
            ),
          ),
          
          // Progress circle
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              strokeCap: StrokeCap.round,
            ),
          ),
          
          // Percentage text in the center
          Center(
            child: Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: size / 4,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
