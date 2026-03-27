import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Quiz history
  static int get totalQuizCorrect => _prefs?.getInt('quiz_correct') ?? 0;
  static int get totalQuizAttempted => _prefs?.getInt('quiz_attempted') ?? 0;
  static Future<void> recordQuizResult(int correct, int total) async {
    await _prefs?.setInt('quiz_correct', totalQuizCorrect + correct);
    await _prefs?.setInt('quiz_attempted', totalQuizAttempted + total);
    await addXP(correct * 10); // 10 XP per correct answer
  }

  // Flashcard history
  static int get totalFlashcardsKnew => _prefs?.getInt('fc_knew') ?? 0;
  static int get totalFlashcardsStudied => _prefs?.getInt('fc_studied') ?? 0;
  static Future<void> recordFlashcardResult(int knew, int total) async {
    await _prefs?.setInt('fc_knew', totalFlashcardsKnew + knew);
    await _prefs?.setInt('fc_studied', totalFlashcardsStudied + total);
    await addXP(knew * 5); // 5 XP per "knew it"
  }

  // XP
  static int get xp => _prefs?.getInt('xp') ?? 0;
  static Future<void> addXP(int amount) async {
    await _prefs?.setInt('xp', xp + amount);
  }

  // Streak
  static int get streak => _prefs?.getInt('streak') ?? 0;
  static String get lastStudyDate =>
      _prefs?.getString('last_study_date') ?? '';
  static Future<void> recordStudySession() async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final yesterday = DateTime.now()
        .subtract(const Duration(days: 1))
        .toIso8601String()
        .substring(0, 10);
    final last = lastStudyDate;

    if (last == today) return; // Already recorded today

    if (last == yesterday) {
      await _prefs?.setInt('streak', streak + 1);
    } else if (last != today) {
      await _prefs?.setInt('streak', 1); // Reset streak
    }
    await _prefs?.setString('last_study_date', today);
  }

  // Modules visited
  static Set<String> get visitedModules {
    final list = _prefs?.getStringList('visited_modules') ?? [];
    return list.toSet();
  }

  static Future<void> markModuleVisited(String moduleId) async {
    final visited = visitedModules.toList();
    if (!visited.contains(moduleId)) {
      visited.add(moduleId);
      await _prefs?.setStringList('visited_modules', visited);
      await addXP(50); // 50 XP per new module
    }
  }
}
