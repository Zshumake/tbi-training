import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight spaced repetition service using SharedPreferences.
///
/// Confidence levels:
///   1 = needs work  -> review in 1 day
///   2 = okay        -> review in 3 days
///   3 = knew it     -> review in 7 days
///
/// Each subsequent correct repetition doubles the interval (capped at 30 days).
class SRSService {
  static const String _storageKey = 'srs_items';

  // ── Record a study item with confidence ──

  static Future<void> recordItem(String itemId, int confidence) async {
    final prefs = await SharedPreferences.getInstance();
    final data = _loadAll(prefs);

    final existing = data[itemId];
    int interval;

    if (confidence == 1) {
      interval = 1;
    } else if (confidence == 2) {
      interval = existing != null ? (existing['interval'] as int) : 3;
      if (interval < 3) interval = 3;
    } else {
      // confidence == 3
      final prev = existing != null ? (existing['interval'] as int) : 7;
      interval = (prev * 2).clamp(7, 30);
    }

    final nextReview =
        DateTime.now().add(Duration(days: interval)).toIso8601String();

    data[itemId] = {
      'nextReview': nextReview,
      'interval': interval,
      'confidence': confidence,
    };

    await _saveAll(prefs, data);
  }

  // ── Get item IDs due for review today (or overdue) ──

  static Future<List<String>> getDueItems() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _loadAll(prefs);
    final now = DateTime.now();
    final due = <String>[];

    for (final entry in data.entries) {
      final nextReview = DateTime.tryParse(entry.value['nextReview'] as String);
      if (nextReview != null && !nextReview.isAfter(now)) {
        due.add(entry.key);
      }
    }

    // Sort by most overdue first
    due.sort((a, b) {
      final aDate = DateTime.parse(data[a]!['nextReview'] as String);
      final bDate = DateTime.parse(data[b]!['nextReview'] as String);
      return aDate.compareTo(bDate);
    });

    return due;
  }

  // ── Count of items due today ──

  static Future<int> getDueCount() async {
    final items = await getDueItems();
    return items.length;
  }

  // ── Per-module mastery score (0-100) ──
  //
  // Mastery is computed as:
  //   (sum of confidence scores for module items) / (3 * item count) * 100
  // Only items whose moduleId starts with [moduleId] are counted.

  static Future<int> getModuleMastery(String moduleId) async {
    final prefs = await SharedPreferences.getInstance();
    final data = _loadAll(prefs);

    int totalConfidence = 0;
    int itemCount = 0;

    for (final entry in data.entries) {
      if (entry.key.startsWith(moduleId)) {
        totalConfidence += (entry.value['confidence'] as int?) ?? 0;
        itemCount++;
      }
    }

    if (itemCount == 0) return 0;
    return ((totalConfidence / (3 * itemCount)) * 100).round().clamp(0, 100);
  }

  // ── Get total tracked item count ──

  static Future<int> getTotalTrackedCount() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _loadAll(prefs);
    return data.length;
  }

  // ── Internal helpers ──

  static Map<String, Map<String, dynamic>> _loadAll(SharedPreferences prefs) {
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return {};

    final decoded = json.decode(raw) as Map<String, dynamic>;
    return decoded.map(
      (key, value) => MapEntry(key, Map<String, dynamic>.from(value as Map)),
    );
  }

  static Future<void> _saveAll(
    SharedPreferences prefs,
    Map<String, Map<String, dynamic>> data,
  ) async {
    await prefs.setString(_storageKey, json.encode(data));
  }
}
