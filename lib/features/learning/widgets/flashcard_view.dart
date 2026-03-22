import 'package:flutter/material.dart';
import '../../../data/models/flashcard_model.dart';
import '../../../core/theme/app_theme.dart';

class FlashcardView extends StatefulWidget {
  final List<Flashcard> cards;
  final String title;

  const FlashcardView({super.key, required this.cards, required this.title});

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  int _currentIndex = 0;
  bool _showBack = false;
  int _knewIt = 0;
  int _needsWork = 0;

  Flashcard get _card => widget.cards[_currentIndex];
  bool get _isLast => _currentIndex >= widget.cards.length - 1;

  void _flip() => setState(() => _showBack = !_showBack);

  void _next(bool knew) {
    setState(() {
      if (knew) {
        _knewIt++;
      } else {
        _needsWork++;
      }
    });
    if (_isLast) {
      _showResults();
    } else {
      setState(() {
        _currentIndex++;
        _showBack = false;
      });
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Session Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('$_knewIt', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: AppTheme.successGreen)),
                    const Text('Knew It', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                  ],
                ),
                Column(
                  children: [
                    Text('$_needsWork', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: AppTheme.dangerRed)),
                    const Text('Needs Work', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () { Navigator.of(ctx).pop(); Navigator.of(context).pop(); },
            child: const Text('Done'),
          ),
        ],
      ),
    );
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
                '${_currentIndex + 1}/${widget.cards.length}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Progress
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / widget.cards.length,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation(AppTheme.accentTeal),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 24),
            // Card
            Expanded(
              child: GestureDetector(
                onTap: _flip,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey('$_currentIndex-$_showBack'),
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: _showBack ? const Color(0xFFF0FDFA) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _showBack ? AppTheme.accentTeal.withValues(alpha: 0.4) : Colors.grey.shade200,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _showBack ? 'ANSWER' : 'QUESTION',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: _showBack ? AppTheme.accentTeal : AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _showBack ? _card.back : _card.front,
                          style: TextStyle(
                            fontSize: _showBack ? 18 : 17,
                            fontWeight: _showBack ? FontWeight.w700 : FontWeight.w500,
                            height: 1.5,
                            color: AppTheme.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (!_showBack) ...[
                          const SizedBox(height: 24),
                          Text(
                            'Tap to reveal answer',
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Buttons
            if (_showBack)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _next(false),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Needs Work'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.dangerRed,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _next(true),
                      icon: const Icon(Icons.check_rounded, size: 18),
                      label: const Text('Knew It'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.successGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              )
            else
              const SizedBox(height: 52), // Placeholder for layout stability
          ],
        ),
      ),
    );
  }
}
