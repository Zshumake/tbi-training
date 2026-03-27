import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/quiz_model.dart';
import '../services/progress_service.dart';
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

class _QuizSessionViewState extends State<QuizSessionView>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _correct = 0;
  int _total = 0;

  // Answer feedback animation controllers
  AnimationController? _shockwaveController;
  AnimationController? _checkScaleController;
  AnimationController? _shakeController;
  AnimationController? _revealController;

  // Track which option keys to use for shockwave positioning
  final Map<int, GlobalKey> _optionKeys = {};

  QuizQuestion get _currentQuestion => widget.questions[_currentIndex];
  bool get _isLastQuestion => _currentIndex >= widget.questions.length - 1;

  @override
  void initState() {
    super.initState();
    _initAnimationControllers();
  }

  void _initAnimationControllers() {
    _shockwaveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _checkScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _shockwaveController?.dispose();
    _checkScaleController?.dispose();
    _shakeController?.dispose();
    _revealController?.dispose();
    super.dispose();
  }

  GlobalKey _getKeyForOption(int index) {
    return _optionKeys.putIfAbsent(index, () => GlobalKey());
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    final isCorrect = index == _currentQuestion.correctIndex;

    setState(() {
      _selectedIndex = index;
      _answered = true;
      _total++;
      if (isCorrect) _correct++;
    });

    if (isCorrect) {
      HapticFeedback.mediumImpact();
      _shockwaveController!.forward(from: 0.0);
      _checkScaleController!.forward(from: 0.0);
    } else {
      HapticFeedback.heavyImpact();
      _shakeController!.forward(from: 0.0).then((_) {
        _revealController!.forward(from: 0.0);
      });
    }
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
      _optionKeys.clear();
    });
    _shockwaveController!.reset();
    _checkScaleController!.reset();
    _shakeController!.reset();
    _revealController!.reset();
  }

  void _showResults() {
    ProgressService.recordQuizResult(_correct, widget.questions.length);
    ProgressService.recordStudySession();
    final pct = ((_correct / _total) * 100).round();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return _ScoreCelebrationOverlay(
            correct: _correct,
            total: _total,
            percentage: pct,
            onDone: () {
              Navigator.of(context).pop(); // pop overlay
              Navigator.of(context).pop(); // pop quiz
            },
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
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

  Widget _buildOptionWidget(int i) {
    final key = _getKeyForOption(i);
    final isCorrect = i == _currentQuestion.correctIndex;
    final isSelectedWrong =
        _answered && i == _selectedIndex && !isCorrect;
    final isCorrectAnswer = _answered && isCorrect;

    Widget optionContent = AnimatedContainer(
      key: key,
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
            : _answered && isCorrect
                ? [
                    BoxShadow(
                      color:
                          AppTheme.successGreen.withValues(alpha: 0.15),
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
                  : isCorrect
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
                    : isCorrect
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
          if (isCorrectAnswer)
            AnimatedBuilder(
              animation: _checkScaleController!,
              builder: (context, child) {
                final scale = _selectedIndex == i
                    ? Curves.elasticOut
                        .transform(_checkScaleController!.value)
                    : (_revealController!.value > 0 ? 1.0 : 0.0);
                return Transform.scale(
                  scale: scale.clamp(0.0, 1.2),
                  child: child,
                );
              },
              child: const Icon(Icons.check_circle,
                  color: AppTheme.successGreen, size: 22),
            ),
          if (isSelectedWrong)
            const Icon(Icons.cancel,
                color: AppTheme.dangerRed, size: 22),
        ],
      ),
    );

    // Wrap correct + selected answer with shockwave
    if (isCorrectAnswer && _selectedIndex == i) {
      optionContent = _ShockwaveWrapper(
        animation: _shockwaveController!,
        child: optionContent,
      );
    }

    // Wrap wrong selected answer with shake
    if (isSelectedWrong) {
      optionContent = AnimatedBuilder(
        animation: _shakeController!,
        builder: (context, child) {
          final progress = _shakeController!.value;
          final offset =
              3.0 * math.sin(progress * 3 * 2 * math.pi);
          return Transform.translate(
            offset: Offset(offset, 0),
            child: child,
          );
        },
        child: optionContent,
      );
    }

    // Wrap correct answer (when user picked wrong) with green reveal
    if (isCorrectAnswer && _selectedIndex != i) {
      optionContent = _GreenRevealWrapper(
        animation: _revealController!,
        child: optionContent,
      );
    }

    return GestureDetector(
      onTap: () => _selectAnswer(i),
      child: optionContent,
    );
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
                valueColor:
                    const AlwaysStoppedAnimation(AppTheme.accent),
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
            ...List.generate(
              _currentQuestion.options.length,
              (i) => _buildOptionWidget(i),
            ),

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
                        Icon(Icons.school_rounded,
                            color: AppTheme.pearlBorder, size: 18),
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
                        color: AppTheme.accentAmber
                            .withValues(alpha: 0.85),
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
                        color:
                            AppTheme.accent.withValues(alpha: 0.3),
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
                      padding:
                          const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _isLastQuestion
                          ? 'See Results'
                          : 'Next Question',
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

// ════════════════════════════════════════════════
// Shockwave ripple effect on correct answer
// ════════════════════════════════════════════════

class _ShockwaveWrapper extends StatelessWidget {
  const _ShockwaveWrapper({
    required this.animation,
    required this.child,
  });

  final AnimationController animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, staticChild) {
        return CustomPaint(
          foregroundPainter: _ShockwavePainter(
            progress: animation.value,
            color: AppTheme.successGreen,
          ),
          child: staticChild,
        );
      },
      child: child,
    );
  }
}

class _ShockwavePainter extends CustomPainter {
  _ShockwavePainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0 || progress >= 1.0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width * 1.0;
    final radius = maxRadius * Curves.easeOut.transform(progress);
    final opacity = (1.0 - progress).clamp(0.0, 0.35);

    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0 * (1.0 - progress);

    canvas.drawCircle(center, radius, paint);

    // Inner fill
    final fillPaint = Paint()
      ..color = color.withValues(alpha: opacity * 0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.8, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _ShockwavePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ════════════════════════════════════════════════
// Green reveal wrapper for correct answer highlight
// ════════════════════════════════════════════════

class _GreenRevealWrapper extends StatelessWidget {
  const _GreenRevealWrapper({
    required this.animation,
    required this.child,
  });

  final AnimationController animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, staticChild) {
        return ShaderMask(
          shaderCallback: (rect) {
            final stop =
                Curves.easeInOut.transform(animation.value);
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppTheme.successGreen.withValues(alpha: 0.15),
                AppTheme.successGreen.withValues(alpha: 0.15),
                Colors.white,
                Colors.white,
              ],
              stops: [0.0, stop, stop, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: staticChild,
        );
      },
      child: child,
    );
  }
}

// ════════════════════════════════════════════════
// Score Celebration Overlay
// ════════════════════════════════════════════════

class _ScoreCelebrationOverlay extends StatefulWidget {
  const _ScoreCelebrationOverlay({
    required this.correct,
    required this.total,
    required this.percentage,
    required this.onDone,
  });

  final int correct;
  final int total;
  final int percentage;
  final VoidCallback onDone;

  @override
  State<_ScoreCelebrationOverlay> createState() =>
      _ScoreCelebrationOverlayState();
}

class _ScoreCelebrationOverlayState
    extends State<_ScoreCelebrationOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _countUpController;
  late final AnimationController _ringController;
  late final AnimationController _badgeController;
  late final AnimationController _particleController;
  late final Animation<int> _countAnimation;
  late final Animation<double> _ringAnimation;
  late final Animation<double> _badgeAnimation;

  @override
  void initState() {
    super.initState();

    _countUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _countAnimation = IntTween(begin: 0, end: widget.percentage).animate(
      CurvedAnimation(
        parent: _countUpController,
        curve: Curves.easeOutExpo,
      ),
    );

    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _ringAnimation = Tween<double>(
      begin: 0.0,
      end: widget.percentage / 100.0,
    ).animate(
      CurvedAnimation(
        parent: _ringController,
        curve: Curves.easeOutCubic,
      ),
    );

    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _badgeAnimation = CurvedAnimation(
      parent: _badgeController,
      curve: Curves.elasticOut,
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Sequence the animations
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _ringController.forward();
      _countUpController.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      _badgeController.forward();
      if (widget.percentage >= 90) {
        _particleController.forward();
      }
    });
  }

  @override
  void dispose() {
    _countUpController.dispose();
    _ringController.dispose();
    _badgeController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  Color get _tierColor {
    if (widget.percentage >= 90) return AppTheme.accentAmber;
    if (widget.percentage >= 70) return AppTheme.textSecondary;
    return AppTheme.dangerRed;
  }

  String get _tierLabel {
    if (widget.percentage >= 90) return 'Outstanding';
    if (widget.percentage >= 70) return 'Passed';
    return 'Keep Studying';
  }

  IconData get _tierIcon {
    if (widget.percentage >= 90) return Icons.emoji_events_rounded;
    if (widget.percentage >= 70) return Icons.verified_rounded;
    return Icons.arrow_upward_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred backdrop
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: AppTheme.background.withValues(alpha: 0.85),
            ),
          ),

          // Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Quiz Complete',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Score ring + count
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Ring painter
                          AnimatedBuilder(
                            animation: _ringAnimation,
                            builder: (context, _) {
                              return CustomPaint(
                                size: const Size(180, 180),
                                painter: _ScoreRingPainter(
                                  progress: _ringAnimation.value,
                                  color: _tierColor,
                                ),
                              );
                            },
                          ),

                          // Particles (gold tier only)
                          if (widget.percentage >= 90)
                            AnimatedBuilder(
                              animation: _particleController,
                              builder: (context, _) {
                                return CustomPaint(
                                  size: const Size(180, 180),
                                  painter: _ParticlePainter(
                                    progress:
                                        _particleController.value,
                                    color: AppTheme.accentAmber,
                                  ),
                                );
                              },
                            ),

                          // Count-up number
                          AnimatedBuilder(
                            animation: _countAnimation,
                            builder: (context, _) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${_countAnimation.value}%',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: _tierColor,
                                      letterSpacing: -2,
                                    ),
                                  ),
                                  Text(
                                    '${widget.correct} / ${widget.total}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Tier badge
                    AnimatedBuilder(
                      animation: _badgeAnimation,
                      builder: (context, child) {
                        final scale = widget.percentage >= 90
                            ? _badgeAnimation.value.clamp(0.0, 1.2)
                            : Curves.easeOutBack
                                .transform(
                                    _badgeController.value)
                                .clamp(0.0, 1.1);
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: _buildTierBadge(),
                    ),

                    const SizedBox(height: 48),

                    // Done button
                    SizedBox(
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [
                              AppTheme.accent,
                              Color(0xFF06B6D4),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.accent
                                  .withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: widget.onDone,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: _tierColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _tierColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_tierIcon, color: _tierColor, size: 24),
          const SizedBox(width: 10),
          Text(
            _tierLabel,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: _tierColor,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Score Ring Painter (circular progress arc)
// ════════════════════════════════════════════════

class _ScoreRingPainter extends CustomPainter {
  _ScoreRingPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    // Background ring
    final bgPaint = Paint()
      ..color = AppTheme.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // start from top
      2 * math.pi * progress,
      false,
      fgPaint,
    );

    // Glow effect
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ════════════════════════════════════════════════
// Particle Painter (gold tier celebration)
// ════════════════════════════════════════════════

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0) return;

    final center = Offset(size.width / 2, size.height / 2);
    const particleCount = 12;

    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * math.pi;
      final distance =
          (40.0 + 50.0 * Curves.easeOut.transform(progress));
      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      final particleRadius = 3.0 * (1.0 - progress * 0.5);

      final dx = center.dx + distance * math.cos(angle);
      final dy = center.dy + distance * math.sin(angle);

      final paint = Paint()
        ..color = color.withValues(alpha: opacity * 0.8)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dx, dy), particleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
