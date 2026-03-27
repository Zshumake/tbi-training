import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/flashcard_model.dart';
import '../../../core/services/progress_service.dart';
import '../../../core/theme/app_theme.dart';

class FlashcardView extends StatefulWidget {
  final List<Flashcard> cards;
  final String title;

  const FlashcardView({super.key, required this.cards, required this.title});

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showBack = false;
  int _knewIt = 0;
  int _needsWork = 0;

  // Flip animation
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;
  bool _isFrontVisible = true;

  // Swipe state
  double _dragX = 0;

  // Swipe-out animation
  late final AnimationController _swipeOutController;
  double _swipeOutTarget = 0;

  Flashcard get _card => widget.cards[_currentIndex];
  bool get _isLast => _currentIndex >= widget.cards.length - 1;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOutCubic,
    );
    _flipController.addListener(() {
      // Switch content at the halfway point
      final front = _flipAnimation.value < 0.5;
      if (front != _isFrontVisible) {
        setState(() => _isFrontVisible = front);
      }
    });

    _swipeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    _swipeOutController.dispose();
    super.dispose();
  }

  void _flip() {
    if (_flipController.isAnimating) return;
    HapticFeedback.lightImpact();
    if (_showBack) {
      _flipController.reverse().then((_) {
        setState(() => _showBack = false);
      });
    } else {
      setState(() => _showBack = true);
      _flipController.forward();
    }
  }

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
        _isFrontVisible = true;
        _dragX = 0;
      });
      _flipController.reset();
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!_showBack) return; // Only allow swipe when answer is visible
    setState(() {
      _dragX += details.delta.dx;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!_showBack) return;
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.4;

    if (_dragX.abs() > threshold) {
      HapticFeedback.mediumImpact();
      final knew = _dragX > 0;
      // Animate card off-screen
      _swipeOutTarget = knew ? screenWidth * 1.5 : -screenWidth * 1.5;
      _swipeOutController.forward(from: 0).then((_) {
        _swipeOutController.reset();
        _swipeOutTarget = 0;
        _dragX = 0;
        _next(knew);
      });
    } else {
      setState(() {
        _dragX = 0;
      });
    }
  }

  void _showResults() {
    ProgressService.recordFlashcardResult(_knewIt, widget.cards.length);
    ProgressService.recordStudySession();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Session Complete!',
          style: TextStyle(
              color: AppTheme.textPrimary, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('$_knewIt',
                        style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.successGreen)),
                    const Text('Knew It',
                        style: TextStyle(
                            fontSize: 13, color: AppTheme.textSecondary)),
                  ],
                ),
                Column(
                  children: [
                    Text('$_needsWork',
                        style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.dangerRed)),
                    const Text('Needs Work',
                        style: TextStyle(
                            fontSize: 13, color: AppTheme.textSecondary)),
                  ],
                ),
              ],
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
              child: const Text('Done',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progress = (_currentIndex + 1) / widget.cards.length;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: Text(widget.title),
        actions: [
          // Card counter with circular progress ring
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 2.5,
                        backgroundColor: AppTheme.border,
                        valueColor:
                            const AlwaysStoppedAnimation(AppTheme.accent),
                      ),
                    ),
                    Text(
                      '${_currentIndex + 1}/${widget.cards.length}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppTheme.border,
                valueColor: const AlwaysStoppedAnimation(AppTheme.accent),
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 24),
            // Card with swipe + flip
            Expanded(
              child: GestureDetector(
                onTap: _flip,
                onHorizontalDragUpdate: _onHorizontalDragUpdate,
                onHorizontalDragEnd: _onHorizontalDragEnd,
                child: AnimatedBuilder(
                  animation: _swipeOutController,
                  builder: (context, child) {
                    // Combine drag offset with swipe-out animation
                    final swipeOffset = _swipeOutController.isAnimating
                        ? _swipeOutTarget * _swipeOutController.value
                        : _dragX;
                    final dragFraction =
                        (swipeOffset / screenWidth).clamp(-1.0, 1.0);
                    // Rotate up to 5 degrees
                    final rotAngle = dragFraction * 5.0 * math.pi / 180.0;
                    // Label opacity: fade in after 40%
                    final labelOpacity =
                        ((dragFraction.abs() - 0.15) / 0.25).clamp(0.0, 1.0);

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Swipe label overlays
                        if (dragFraction > 0.01)
                          Positioned(
                            left: 30,
                            top: 40,
                            child: Opacity(
                              opacity: labelOpacity,
                              child: Transform.rotate(
                                angle: -0.2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppTheme.successGreen,
                                        width: 3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'KNEW IT',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.successGreen,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (dragFraction < -0.01)
                          Positioned(
                            right: 30,
                            top: 40,
                            child: Opacity(
                              opacity: labelOpacity,
                              child: Transform.rotate(
                                angle: 0.2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppTheme.dangerRed, width: 3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'NEEDS WORK',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.dangerRed,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        // The card itself
                        Transform.translate(
                          offset: Offset(swipeOffset, 0),
                          child: Transform.rotate(
                            angle: rotAngle,
                            child: AnimatedBuilder(
                              animation: _flipAnimation,
                              builder: (context, _) {
                                final angle =
                                    math.pi * _flipAnimation.value;
                                // Shadow shifts with rotation
                                final shadowOffsetX =
                                    math.sin(angle) * 8;
                                final isBack = _flipAnimation.value >= 0.5;
                                final displayAngle =
                                    isBack ? math.pi - angle : angle;
                                return Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateY(displayAngle),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(28),
                                    decoration: BoxDecoration(
                                      color: _isFrontVisible
                                          ? AppTheme.surface
                                          : AppTheme.surfaceElevated,
                                      borderRadius:
                                          BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _isFrontVisible
                                            ? AppTheme.border
                                            : AppTheme.accentAmber
                                                .withValues(alpha: 0.4),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (_isFrontVisible
                                                  ? AppTheme.accent
                                                  : AppTheme.accentAmber)
                                              .withValues(alpha: 0.08),
                                          blurRadius: 20,
                                          offset: Offset(
                                              shadowOffsetX, 8),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _isFrontVisible
                                              ? 'QUESTION'
                                              : 'ANSWER',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1.5,
                                            color: _isFrontVisible
                                                ? AppTheme.accent
                                                : AppTheme.accentAmber,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          _isFrontVisible
                                              ? _card.front
                                              : _card.back,
                                          style: TextStyle(
                                            fontSize: _isFrontVisible
                                                ? 17
                                                : 18,
                                            fontWeight: _isFrontVisible
                                                ? FontWeight.w500
                                                : FontWeight.w700,
                                            height: 1.5,
                                            color: AppTheme.textPrimary,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        if (_isFrontVisible) ...[
                                          const SizedBox(height: 24),
                                          const Text(
                                            'Tap to reveal answer',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppTheme
                                                    .textSecondary),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
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
