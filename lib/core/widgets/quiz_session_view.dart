import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../theme/app_theme.dart';

class QuizSessionView extends StatefulWidget {
  final List<QuizQuestion> questions;
  final String title;

  const QuizSessionView({
    super.key,
    required this.questions,
    required this.title,
  });

  @override
  State<QuizSessionView> createState() => _QuizSessionViewState();
}

class _QuizSessionViewState extends State<QuizSessionView> {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _correct = 0;
  int _total = 0;

  QuizQuestion get _currentQuestion => widget.questions[_currentIndex];
  bool get _isLastQuestion => _currentIndex >= widget.questions.length - 1;

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
      _total++;
      if (index == _currentQuestion.correctIndex) _correct++;
    });
  }

  void _nextQuestion() {
    if (_isLastQuestion) {
      _showResults();
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedIndex = null;
      _answered = false;
    });
  }

  void _showResults() {
    final pct = ((_correct / _total) * 100).round();
    final passed = _correct / _total >= 0.7;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Quiz Complete!',
          style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_correct / $_total',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: AppTheme.accent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$pct% correct',
              style: TextStyle(
                fontSize: 18,
                color: passed ? AppTheme.successGreen : AppTheme.dangerRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: AppTheme.accent),
              child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Color _getOptionColor(int index) {
    if (!_answered) return AppTheme.surface;
    if (index == _currentQuestion.correctIndex) {
      return AppTheme.successGreen.withValues(alpha: 0.12);
    }
    if (index == _selectedIndex) {
      return AppTheme.dangerRed.withValues(alpha: 0.12);
    }
    return AppTheme.surface;
  }

  Color _getOptionBorderColor(int index) {
    if (!_answered) {
      return index == _selectedIndex ? AppTheme.accent : AppTheme.border;
    }
    if (index == _currentQuestion.correctIndex) return AppTheme.successGreen;
    if (index == _selectedIndex) return AppTheme.dangerRed;
    return AppTheme.border;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: Text(widget.title),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${_currentIndex + 1}/${widget.questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / widget.questions.length,
                backgroundColor: AppTheme.border,
                valueColor: const AlwaysStoppedAnimation(AppTheme.accent),
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 24),

            // Question
            Text(
              _currentQuestion.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.4,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Options
            ...List.generate(_currentQuestion.options.length, (i) {
              return GestureDetector(
                onTap: () => _selectAnswer(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _getOptionColor(i),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getOptionBorderColor(i),
                      width: 1.5,
                    ),
                    boxShadow: !_answered && i == _selectedIndex
                        ? [
                            BoxShadow(
                              color: AppTheme.accent.withValues(alpha: 0.2),
                              blurRadius: 12,
                              spreadRadius: 0,
                            )
                          ]
                        : _answered && i == _currentQuestion.correctIndex
                            ? [
                                BoxShadow(
                                  color: AppTheme.successGreen.withValues(alpha: 0.15),
                                  blurRadius: 12,
                                  spreadRadius: 0,
                                )
                              ]
                            : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !_answered
                              ? AppTheme.surfaceElevated
                              : i == _currentQuestion.correctIndex
                                  ? AppTheme.successGreen.withValues(alpha: 0.2)
                                  : i == _selectedIndex
                                      ? AppTheme.dangerRed.withValues(alpha: 0.2)
                                      : AppTheme.surfaceElevated,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          String.fromCharCode(65 + i),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: !_answered
                                ? AppTheme.textSecondary
                                : i == _currentQuestion.correctIndex
                                    ? AppTheme.successGreen
                                    : i == _selectedIndex
                                        ? AppTheme.dangerRed
                                        : AppTheme.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _currentQuestion.options[i],
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      if (_answered && i == _currentQuestion.correctIndex)
                        const Icon(Icons.check_circle, color: AppTheme.successGreen, size: 22),
                      if (_answered &&
                          i == _selectedIndex &&
                          i != _currentQuestion.correctIndex)
                        const Icon(Icons.cancel, color: AppTheme.dangerRed, size: 22),
                    ],
                  ),
                ),
              );
            }),

            // Explanation
            if (_answered) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.pearlBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.pearlBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.school_rounded, color: AppTheme.pearlBorder, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Explanation',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.accentAmber,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentQuestion.explanation,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: AppTheme.accentAmber.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [AppTheme.accent, Color(0xFF06B6D4)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accent.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _isLastQuestion ? 'See Results' : 'Next Question',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
