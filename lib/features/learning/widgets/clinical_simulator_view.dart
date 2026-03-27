import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/clinical_scenario_model.dart';

/// A full-screen clinical decision simulator that walks the user through
/// a branching patient scenario with timed choices and animated vitals.
class ClinicalSimulatorView extends StatefulWidget {
  const ClinicalSimulatorView({super.key, required this.scenario});

  final ClinicalScenario scenario;

  @override
  State<ClinicalSimulatorView> createState() => _ClinicalSimulatorViewState();
}

class _ClinicalSimulatorViewState extends State<ClinicalSimulatorView>
    with TickerProviderStateMixin {
  // ── State ──
  late ScenarioStep _currentStep;
  int _currentStepIndex = 0;
  int? _selectedChoiceIndex;
  bool _hasAnswered = false;
  bool _showingResults = false;

  // Tracking
  int _correctCount = 0;
  int _totalSteps = 0;
  final Stopwatch _stopwatch = Stopwatch();
  final List<_StepResult> _results = [];

  // Timer
  Timer? _countdownTimer;
  int _secondsRemaining = 0;

  // Animation controllers
  late AnimationController _vitalsAnimController;
  late AnimationController _shakeController;
  late AnimationController _pulseController;
  late AnimationController _feedbackController;
  late Animation<double> _shakeAnimation;
  late Animation<double> _pulseAnimation;

  // Vitals animation values
  VitalSigns? _previousVitals;
  VitalSigns? _targetVitals;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.scenario.steps.first;
    _stopwatch.start();

    _vitalsAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _startTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _stopwatch.stop();
    _vitalsAnimController.dispose();
    _shakeController.dispose();
    _pulseController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    if (_currentStep.timeLimit != null) {
      _secondsRemaining = _currentStep.timeLimit!;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          _secondsRemaining--;
          if (_secondsRemaining <= 10 && _secondsRemaining > 0) {
            _pulseController.forward().then((_) {
              if (mounted) _pulseController.reverse();
            });
            HapticFeedback.lightImpact();
          }
          if (_secondsRemaining <= 0) {
            timer.cancel();
            if (!_hasAnswered) {
              _onTimeUp();
            }
          }
        });
      });
    }
  }

  void _onTimeUp() {
    // Auto-select: treat as wrong with no selection
    _hasAnswered = true;
    _selectedChoiceIndex = null;
    _countdownTimer?.cancel();
    _feedbackController.forward();

    final correctChoice =
        _currentStep.choices.firstWhere((c) => c.isCorrect);
    _results.add(_StepResult(
      stepId: _currentStep.id,
      wasCorrect: false,
      selectedText: 'Time expired',
      correctText: correctChoice.text,
      explanation: correctChoice.explanation,
    ));
    _totalSteps++;

    setState(() {});
  }

  void _onChoiceSelected(int index) {
    if (_hasAnswered) return;

    _countdownTimer?.cancel();
    _hasAnswered = true;
    _selectedChoiceIndex = index;

    final choice = _currentStep.choices[index];

    if (choice.isCorrect) {
      _correctCount++;
      HapticFeedback.mediumImpact();
    } else {
      _shakeController.forward().then((_) {
        if (mounted) _shakeController.reset();
      });
      HapticFeedback.heavyImpact();
    }

    _totalSteps++;
    _results.add(_StepResult(
      stepId: _currentStep.id,
      wasCorrect: choice.isCorrect,
      selectedText: choice.text,
      correctText:
          _currentStep.choices.firstWhere((c) => c.isCorrect).text,
      explanation: choice.explanation,
    ));

    // Animate vitals change
    if (choice.updatedVitals != null) {
      _previousVitals = _currentStep.vitals;
      _targetVitals = choice.updatedVitals;
      _vitalsAnimController.forward(from: 0);
    }

    _feedbackController.forward(from: 0);
    setState(() {});
  }

  void _goToNextStep() {
    if (_selectedChoiceIndex == null) {
      // Time expired -- find the correct choice's next step
      final correctChoice =
          _currentStep.choices.firstWhere((c) => c.isCorrect);
      _advanceToStep(correctChoice.nextStepId, correctChoice.updatedVitals);
      return;
    }

    final choice = _currentStep.choices[_selectedChoiceIndex!];
    _advanceToStep(choice.nextStepId, choice.updatedVitals);
  }

  void _advanceToStep(String? nextStepId, VitalSigns? newVitals) {
    if (nextStepId == null) {
      // End of scenario
      _stopwatch.stop();
      setState(() => _showingResults = true);
      return;
    }

    final nextStep = widget.scenario.stepById(nextStepId);
    if (nextStep == null) {
      _stopwatch.stop();
      setState(() => _showingResults = true);
      return;
    }

    setState(() {
      _currentStep = nextStep;
      _currentStepIndex++;
      _selectedChoiceIndex = null;
      _hasAnswered = false;
      _previousVitals = null;
      _targetVitals = null;
      _feedbackController.reset();
    });
    _startTimer();
  }

  // ── Build ──

  @override
  Widget build(BuildContext context) {
    if (_showingResults) {
      return _buildResultsScreen();
    }
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppTheme.textSecondary),
          onPressed: () => _showExitConfirmation(context),
        ),
        title: Text(
          'Step ${_currentStepIndex + 1} of ${widget.scenario.steps.length}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          if (_currentStep.timeLimit != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildTimerBadge(),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  // Patient banner
                  _buildPatientBanner(),
                  const SizedBox(height: 12),

                  // Vitals monitor
                  _buildVitalsMonitor(),
                  const SizedBox(height: 16),

                  // Narrative
                  _buildNarrativeCard(),
                  const SizedBox(height: 12),

                  // Imaging finding
                  if (_currentStep.imagingFinding != null) ...[
                    _buildImagingCard(),
                    const SizedBox(height: 16),
                  ],

                  // Timer arc (if timed)
                  if (_currentStep.timeLimit != null && !_hasAnswered)
                    _buildTimerArc(),

                  if (_currentStep.timeLimit != null && !_hasAnswered)
                    const SizedBox(height: 16),

                  // Choices
                  ..._buildChoiceCards(),

                  // Feedback card
                  if (_hasAnswered) ...[
                    const SizedBox(height: 16),
                    _buildFeedbackCard(),
                    const SizedBox(height: 16),
                    _buildNextButton(),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Widgets ──

  Widget _buildPatientBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.acuteColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.acuteColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.emergency_rounded,
              color: AppTheme.acuteColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.scenario.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.scenario.patientSummary,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalsMonitor() {
    final vitals = _currentStep.vitals;
    return AnimatedBuilder(
      animation: _vitalsAnimController,
      builder: (context, _) {
        final t = _vitalsAnimController.value;
        final displayVitals = _interpolateVitals(t);
        final v = displayVitals ?? vitals;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.monitor_heart_rounded,
                      color: AppTheme.dangerRed.withValues(alpha: 0.8),
                      size: 16),
                  const SizedBox(width: 6),
                  const Text(
                    'VITALS MONITOR',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textSecondary,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _VitalTile(
                      label: 'HR', value: '${v.hr}', unit: 'bpm',
                      isAbnormal: v.hr < 50 || v.hr > 100),
                  _VitalTile(
                      label: 'BP',
                      value: '${v.sbp}/${v.dbp}',
                      unit: 'mmHg',
                      isAbnormal: v.sbp > 160 || v.sbp < 90),
                  _VitalTile(
                      label: 'RR', value: '${v.rr}', unit: '/min',
                      isAbnormal: v.rr < 10 || v.rr > 20),
                  _VitalTile(
                      label: 'SpO2', value: '${v.spo2}', unit: '%',
                      isAbnormal: v.spo2 < 95),
                  if (v.icp != null)
                    _VitalTile(
                        label: 'ICP',
                        value: '${v.icp}',
                        unit: 'mmHg',
                        isAbnormal: v.icp! > 20),
                  if (v.cpp != null)
                    _VitalTile(
                        label: 'CPP',
                        value: '${v.cpp}',
                        unit: 'mmHg',
                        isAbnormal: v.cpp! < 60),
                  if (v.temp != null)
                    _VitalTile(
                        label: 'Temp',
                        value: v.temp!.toStringAsFixed(1),
                        unit: '\u00B0C',
                        isAbnormal: v.temp! > 38.0 || v.temp! < 36.0),
                  if (v.gcs != null)
                    _VitalTile(
                        label: 'GCS',
                        value: '${v.gcs}',
                        unit: '/15',
                        isAbnormal: v.gcs! <= 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  VitalSigns? _interpolateVitals(double t) {
    if (_previousVitals == null || _targetVitals == null) return null;
    final p = _previousVitals!;
    final n = _targetVitals!;
    int lerp(int a, int b) => (a + (b - a) * t).round();
    double lerpD(double a, double b) => a + (b - a) * t;

    return VitalSigns(
      hr: lerp(p.hr, n.hr),
      sbp: lerp(p.sbp, n.sbp),
      dbp: lerp(p.dbp, n.dbp),
      rr: lerp(p.rr, n.rr),
      spo2: lerp(p.spo2, n.spo2),
      icp: (p.icp != null && n.icp != null) ? lerp(p.icp!, n.icp!) : n.icp,
      cpp: (p.cpp != null && n.cpp != null) ? lerp(p.cpp!, n.cpp!) : n.cpp,
      temp: (p.temp != null && n.temp != null)
          ? lerpD(p.temp!, n.temp!)
          : n.temp,
      gcs: (p.gcs != null && n.gcs != null) ? lerp(p.gcs!, n.gcs!) : n.gcs,
    );
  }

  Widget _buildNarrativeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border, width: 1),
      ),
      child: Text(
        _currentStep.narrative,
        style: const TextStyle(
          fontSize: 15,
          color: AppTheme.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildImagingCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.pearlBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.accentAmber.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.biotech_rounded,
              color: AppTheme.accentAmber.withValues(alpha: 0.9), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IMAGING / CLINICAL FINDING',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.accentAmber.withValues(alpha: 0.9),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentStep.imagingFinding!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBadge() {
    final isUrgent = _secondsRemaining <= 10;
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isUrgent ? _pulseAnimation.value : 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isUrgent
                  ? AppTheme.dangerRed.withValues(alpha: 0.2)
                  : AppTheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isUrgent
                    ? AppTheme.dangerRed
                    : AppTheme.border,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer_rounded,
                  size: 14,
                  color: isUrgent
                      ? AppTheme.dangerRed
                      : AppTheme.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_secondsRemaining}s',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isUrgent
                        ? AppTheme.dangerRed
                        : AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimerArc() {
    final total = _currentStep.timeLimit!;
    final fraction = _secondsRemaining / total;
    final isUrgent = _secondsRemaining <= 10;

    return Center(
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, _) {
          return SizedBox(
            width: 64,
            height: 64,
            child: CustomPaint(
              painter: _TimerArcPainter(
                fraction: fraction,
                isUrgent: isUrgent,
                pulseScale: isUrgent ? _pulseAnimation.value : 1.0,
              ),
              child: Center(
                child: Text(
                  '$_secondsRemaining',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: isUrgent
                        ? AppTheme.dangerRed
                        : AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildChoiceCards() {
    const labels = ['A', 'B', 'C', 'D'];
    return List.generate(_currentStep.choices.length, (i) {
      final choice = _currentStep.choices[i];
      final isSelected = _selectedChoiceIndex == i;
      final showCorrect = _hasAnswered && choice.isCorrect;
      final showWrong = _hasAnswered && isSelected && !choice.isCorrect;

      Color borderColor = AppTheme.border;
      if (showCorrect) borderColor = AppTheme.successGreen;
      if (showWrong) borderColor = AppTheme.dangerRed;

      Widget card = AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: showCorrect
              ? AppTheme.successGreen.withValues(alpha: 0.08)
              : showWrong
                  ? AppTheme.dangerRed.withValues(alpha: 0.08)
                  : AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: showCorrect || showWrong ? 2 : 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: showCorrect
                    ? AppTheme.successGreen.withValues(alpha: 0.2)
                    : showWrong
                        ? AppTheme.dangerRed.withValues(alpha: 0.2)
                        : AppTheme.surfaceElevated,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: showCorrect
                        ? AppTheme.successGreen
                        : showWrong
                            ? AppTheme.dangerRed
                            : AppTheme.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                choice.text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _hasAnswered && !isSelected && !choice.isCorrect
                      ? AppTheme.textSecondary.withValues(alpha: 0.5)
                      : AppTheme.textPrimary,
                  height: 1.4,
                ),
              ),
            ),
            if (showCorrect)
              const Icon(Icons.check_circle_rounded,
                  color: AppTheme.successGreen, size: 20),
            if (showWrong)
              const Icon(Icons.cancel_rounded,
                  color: AppTheme.dangerRed, size: 20),
          ],
        ),
      );

      // Shake animation for wrong answer
      if (showWrong) {
        card = AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            final dx = math.sin(_shakeAnimation.value * math.pi * 4) * 8;
            return Transform.translate(offset: Offset(dx, 0), child: child);
          },
          child: card,
        );
      }

      return GestureDetector(
        onTap: _hasAnswered ? null : () => _onChoiceSelected(i),
        child: card,
      );
    });
  }

  Widget _buildFeedbackCard() {
    final choice = _selectedChoiceIndex != null
        ? _currentStep.choices[_selectedChoiceIndex!]
        : _currentStep.choices.firstWhere((c) => c.isCorrect);
    final wasCorrect = _selectedChoiceIndex != null ? choice.isCorrect : false;
    final timedOut = _selectedChoiceIndex == null;

    return AnimatedBuilder(
      animation: _feedbackController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + 0.1 * _feedbackController.value,
          child: Opacity(
            opacity: _feedbackController.value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: wasCorrect
              ? AppTheme.successGreen.withValues(alpha: 0.08)
              : AppTheme.dangerRed.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: wasCorrect
                ? AppTheme.successGreen.withValues(alpha: 0.3)
                : AppTheme.dangerRed.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  wasCorrect
                      ? Icons.check_circle_rounded
                      : timedOut
                          ? Icons.timer_off_rounded
                          : Icons.info_outline_rounded,
                  color: wasCorrect
                      ? AppTheme.successGreen
                      : AppTheme.dangerRed,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  wasCorrect
                      ? 'Correct!'
                      : timedOut
                          ? 'Time Expired'
                          : 'Incorrect',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: wasCorrect
                        ? AppTheme.successGreen
                        : AppTheme.dangerRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Consequence
            Text(
              choice.consequence,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            // Teaching point
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.background.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TEACHING POINT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accent,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    choice.explanation,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textPrimary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    final isLastStep = _currentStep.choices.every((c) => c.nextStepId == null);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _goToNextStep,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accent,
          foregroundColor: const Color(0xFF003544),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: Text(
          isLastStep ? 'View Results' : 'Next Step',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ── Results Screen ──

  Widget _buildResultsScreen() {
    final elapsed = _stopwatch.elapsed;
    final minutes = elapsed.inMinutes;
    final seconds = elapsed.inSeconds % 60;
    final percentage =
        _totalSteps > 0 ? (_correctCount / _totalSteps * 100).round() : 0;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: const Text(
          'Scenario Complete',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Score card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.border, width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    widget.scenario.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Score circle
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: percentage >= 80
                          ? AppTheme.successGreen.withValues(alpha: 0.12)
                          : percentage >= 60
                              ? AppTheme.accentAmber.withValues(alpha: 0.12)
                              : AppTheme.dangerRed.withValues(alpha: 0.12),
                      border: Border.all(
                        color: percentage >= 80
                            ? AppTheme.successGreen
                            : percentage >= 60
                                ? AppTheme.accentAmber
                                : AppTheme.dangerRed,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$percentage%',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: percentage >= 80
                              ? AppTheme.successGreen
                              : percentage >= 60
                                  ? AppTheme.accentAmber
                                  : AppTheme.dangerRed,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ResultStat(
                          label: 'Correct',
                          value: '$_correctCount/$_totalSteps'),
                      _ResultStat(
                          label: 'Time',
                          value: '${minutes}m ${seconds}s'),
                      _ResultStat(
                          label: 'Steps',
                          value: '$_totalSteps'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Teaching summary
            const Text(
              'TEACHING SUMMARY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.textSecondary,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(_results.length, (i) {
              final r = _results[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: r.wasCorrect
                        ? AppTheme.successGreen.withValues(alpha: 0.3)
                        : AppTheme.dangerRed.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          r.wasCorrect
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          size: 16,
                          color: r.wasCorrect
                              ? AppTheme.successGreen
                              : AppTheme.dangerRed,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Step ${i + 1}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Your answer: ${r.selectedText}',
                      style: TextStyle(
                        fontSize: 12,
                        color: r.wasCorrect
                            ? AppTheme.textSecondary
                            : AppTheme.dangerRed.withValues(alpha: 0.8),
                        height: 1.4,
                      ),
                    ),
                    if (!r.wasCorrect) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Correct: ${r.correctText}',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              AppTheme.successGreen.withValues(alpha: 0.8),
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      r.explanation,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  foregroundColor: const Color(0xFF003544),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Exit Scenario?',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'Your progress will not be saved.',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: AppTheme.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Exit',
                style: TextStyle(color: AppTheme.dangerRed)),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Supporting Widgets
// ════════════════════════════════════════════════════════════

class _VitalTile extends StatelessWidget {
  const _VitalTile({
    required this.label,
    required this.value,
    required this.unit,
    required this.isAbnormal,
  });

  final String label;
  final String value;
  final String unit;
  final bool isAbnormal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isAbnormal
              ? AppTheme.dangerRed.withValues(alpha: 0.5)
              : AppTheme.border,
          width: 1,
        ),
        boxShadow: isAbnormal
            ? [
                BoxShadow(
                  color: AppTheme.dangerRed.withValues(alpha: 0.15),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: isAbnormal
                  ? AppTheme.dangerRed.withValues(alpha: 0.8)
                  : AppTheme.textSecondary,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isAbnormal ? AppTheme.dangerRed : AppTheme.textPrimary,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 9,
              color: isAbnormal
                  ? AppTheme.dangerRed.withValues(alpha: 0.6)
                  : AppTheme.textSecondary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultStat extends StatelessWidget {
  const _ResultStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _StepResult {
  final String stepId;
  final bool wasCorrect;
  final String selectedText;
  final String correctText;
  final String explanation;

  const _StepResult({
    required this.stepId,
    required this.wasCorrect,
    required this.selectedText,
    required this.correctText,
    required this.explanation,
  });
}

// ════════════════════════════════════════════════════════════
// Timer Arc Painter
// ════════════════════════════════════════════════════════════

class _TimerArcPainter extends CustomPainter {
  final double fraction;
  final bool isUrgent;
  final double pulseScale;

  _TimerArcPainter({
    required this.fraction,
    required this.isUrgent,
    required this.pulseScale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background arc
    final bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = AppTheme.border;
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc
    final fgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = isUrgent ? AppTheme.dangerRed : AppTheme.accent;

    final sweepAngle = 2 * math.pi * fraction;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_TimerArcPainter oldDelegate) =>
      fraction != oldDelegate.fraction ||
      isUrgent != oldDelegate.isUrgent ||
      pulseScale != oldDelegate.pulseScale;
}
