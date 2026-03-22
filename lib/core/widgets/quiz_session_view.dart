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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_correct / $_total',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              '${((_correct / _total) * 100).round()}% correct',
              style: TextStyle(
                fontSize: 18,
                color: _correct / _total >= 0.7
                    ? AppTheme.successGreen
                    : AppTheme.dangerRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Color _getOptionColor(int index) {
    if (!_answered) return Colors.white;
    if (index == _currentQuestion.correctIndex) return const Color(0xFFDCFCE7);
    if (index == _selectedIndex) return const Color(0xFFFEE2E2);
    return Colors.white;
  }

  Color _getOptionBorderColor(int index) {
    if (!_answered) {
      return index == _selectedIndex
          ? AppTheme.accentTeal
          : Colors.grey.shade300;
    }
    if (index == _currentQuestion.correctIndex) return AppTheme.successGreen;
    if (index == _selectedIndex) return AppTheme.dangerRed;
    return Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation(AppTheme.accentTeal),
                minHeight: 6,
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
                child: Container(
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
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !_answered
                              ? Colors.grey.shade100
                              : i == _currentQuestion.correctIndex
                                  ? AppTheme.successGreen.withValues(alpha: 0.15)
                                  : i == _selectedIndex
                                      ? AppTheme.dangerRed.withValues(alpha: 0.15)
                                      : Colors.grey.shade100,
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
                            color: Color(0xFF92400E),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentQuestion.explanation,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Color(0xFF78350F),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentTeal,
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
                      fontWeight: FontWeight.w600,
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
