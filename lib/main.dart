import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/learning/home_screen.dart';

void main() {
  runApp(const TBITrainingApp());
}

class TBITrainingApp extends StatelessWidget {
  const TBITrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TBI Training',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
