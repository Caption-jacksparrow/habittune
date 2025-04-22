import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection/injection_container.dart' as di;
import 'presentation/pages/home_page.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/performance_optimizer.dart';
import 'core/utils/accessibility_helper.dart';
import 'core/utils/analytics_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  
  // Initialize performance optimizations
  PerformanceOptimizer.initialize();
  
  // Initialize accessibility features
  AccessibilityHelper.initialize();
  
  // Initialize analytics
  AnalyticsHelper.initialize();
  
  runApp(const HabituneApp());
}

class HabituneApp extends StatelessWidget {
  const HabituneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitune',
      theme: AppTheme.getLightTheme(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Remove debug banner for production
    );
  }
}
