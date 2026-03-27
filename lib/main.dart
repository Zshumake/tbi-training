import 'package:flutter/material.dart';
import 'core/services/progress_service.dart';
import 'core/theme/app_theme.dart';
import 'features/learning/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProgressService.init();
  runApp(const TBITrainingApp());
}

class TBITrainingApp extends StatelessWidget {
  const TBITrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TBI Training',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
