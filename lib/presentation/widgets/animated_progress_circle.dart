import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Custom animated progress circle widget that follows brand guidelines
class AnimatedProgressCircle extends StatefulWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;
  final Duration animationDuration;
  final bool showCheckmark;

  const AnimatedProgressCircle({
    super.key,
    required this.progress,
    required this.size,
    required this.strokeWidth,
    this.progressColor = const Color(0xFF673AB7), // Deep Purple from brand guidelines
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.animationDuration = const Duration(milliseconds: 500),
    this.showCheckmark = false,
  });

  @override
  State<AnimatedProgressCircle> createState() => _AnimatedProgressCircleState();
}

class _AnimatedProgressCircleState extends State<AnimatedProgressCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _checkmarkAnimation;
  double _oldProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    
    _checkmarkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
      ),
    );
    
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _oldProgress = oldWidget.progress;
      _progressAnimation = Tween<double>(
        begin: _oldProgress,
        end: widget.progress,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
        ),
      );
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: widget.size,
          width: widget.size,
          child: Stack(
            children: [
              // Background circle
              SizedBox(
                height: widget.size,
                width: widget.size,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: widget.strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.backgroundColor),
                ),
              ),
              
              // Progress circle
              SizedBox(
                height: widget.size,
                width: widget.size,
                child: CircularProgressIndicator(
                  value: _progressAnimation.value,
                  strokeWidth: widget.strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
                  strokeCap: StrokeCap.round,
                ),
              ),
              
              // Checkmark (visible only when showCheckmark is true and progress is complete)
              if (widget.showCheckmark && widget.progress >= 0.99)
                Center(
                  child: Transform.scale(
                    scale: _checkmarkAnimation.value,
                    child: Container(
                      width: widget.size * 0.5,
                      height: widget.size * 0.5,
                      decoration: BoxDecoration(
                        color: widget.progressColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: widget.size * 0.3,
                      ),
                    ),
                  ),
                ),
              
              // Percentage text in the center (hidden when checkmark is shown)
              if (!(widget.showCheckmark && widget.progress >= 0.99))
                Center(
                  child: Text(
                    '${(_progressAnimation.value * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: widget.size / 4,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
