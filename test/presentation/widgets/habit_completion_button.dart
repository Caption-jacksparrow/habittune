import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Custom animated habit completion button that follows brand guidelines
class HabitCompletionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isCompleted;
  final double size;

  const HabitCompletionButton({
    super.key,
    required this.onPressed,
    this.isCompleted = false,
    this.size = 56.0,
  });

  @override
  State<HabitCompletionButton> createState() => _HabitCompletionButtonState();
}

class _HabitCompletionButtonState extends State<HabitCompletionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkmarkAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
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
    
    if (widget.isCompleted) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(HabitCompletionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCompleted != widget.isCompleted) {
      if (widget.isCompleted) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
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
        return GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isCompleted 
                  ? AppTheme.deepPurple 
                  : Colors.transparent,
              border: Border.all(
                color: widget.isCompleted 
                    ? AppTheme.deepPurple 
                    : AppTheme.deepPurple.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Center(
              child: widget.isCompleted
                  ? Transform.scale(
                      scale: _checkmarkAnimation.value,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.add,
                      color: AppTheme.deepPurple,
                    ),
            ),
          ),
        );
      },
    );
  }
}
