import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';

// =============================================================================
// Data Models
// =============================================================================

class VitalSignAnimation {
  const VitalSignAnimation({
    required this.hrStart,
    required this.hrEnd,
    required this.bpSysStart,
    required this.bpSysEnd,
    required this.bpDiaStart,
    required this.bpDiaEnd,
    required this.tempStart,
    required this.tempEnd,
    required this.rrStart,
    required this.rrEnd,
  });

  final int hrStart;
  final int hrEnd;
  final int bpSysStart;
  final int bpSysEnd;
  final int bpDiaStart;
  final int bpDiaEnd;
  final double tempStart;
  final double tempEnd;
  final int rrStart;
  final int rrEnd;
}

class PatternCase {
  const PatternCase({
    required this.scenarioText,
    required this.vitals,
    required this.observableSigns,
    required this.correctDiagnosis,
    required this.explanation,
    required this.distinguishingFeatures,
  });

  final String scenarioText;
  final VitalSignAnimation vitals;
  final List<String> observableSigns;
  final String correctDiagnosis; // 'agitation', 'seizure', 'psh'
  final String explanation;
  final List<String> distinguishingFeatures;
}

// =============================================================================
// Case Bank (6 cases: 2 agitation, 2 seizure, 2 PSH)
// =============================================================================

const List<PatternCase> _casesBank = [
  // ── Agitation Case 1 ──
  PatternCase(
    scenarioText:
        '32 y/o male, TBI day 14, Rancho IV. Nurse reports patient is '
        'pulling at IV lines and Foley catheter. Yells when staff approach. '
        'Opens eyes to voice and tracks movement.',
    vitals: VitalSignAnimation(
      hrStart: 82,
      hrEnd: 96,
      bpSysStart: 128,
      bpSysEnd: 138,
      bpDiaStart: 78,
      bpDiaEnd: 82,
      tempStart: 37.0,
      tempEnd: 37.2,
      rrStart: 16,
      rrEnd: 18,
    ),
    observableSigns: [
      'Patient pulling at IV tubing with purposeful movements',
      'Yelling incomprehensible words when touched',
      'Eyes open spontaneously, tracking nurse',
      'Withdraws limbs when restrained',
      'No diaphoresis or posturing noted',
    ],
    correctDiagnosis: 'agitation',
    explanation:
        'Purposeful interaction with environment (pulling lines, tracking '
        'movement, withdrawing from restraint) with near-normal vitals is '
        'classic Rancho IV agitated behavior, not PSH or seizure.',
    distinguishingFeatures: [
      'Purposeful, goal-directed behavior (pulling at lines)',
      'Responds to external stimuli (opens eyes to voice)',
      'Vitals near normal range -- no tachycardia >130 or fever',
      'No stereotyped posturing or rhythmic movements',
      'Consistent with Rancho Los Amigos Level IV',
    ],
  ),

  // ── Agitation Case 2 ──
  PatternCase(
    scenarioText:
        '45 y/o female, severe TBI post-EVD removal, day 21. Attempting to '
        'climb out of bed repeatedly. Hits nursing staff during care. Makes '
        'eye contact but does not follow commands.',
    vitals: VitalSignAnimation(
      hrStart: 78,
      hrEnd: 102,
      bpSysStart: 132,
      bpSysEnd: 142,
      bpDiaStart: 80,
      bpDiaEnd: 86,
      tempStart: 37.1,
      tempEnd: 37.3,
      rrStart: 14,
      rrEnd: 20,
    ),
    observableSigns: [
      'Repeatedly climbing over bed rails',
      'Strikes out at staff during repositioning',
      'Makes eye contact but does not follow commands',
      'Movements are variable and non-stereotyped',
      'Calms briefly with familiar voice from family member',
    ],
    correctDiagnosis: 'agitation',
    explanation:
        'Non-purposeful but variable, non-stereotyped aggression that '
        'responds to environmental modification is agitation. Vitals are '
        'mildly elevated but not in PSH range. No rhythmic activity.',
    distinguishingFeatures: [
      'Variable, non-stereotyped motor activity',
      'Responds to environmental changes (calms with family voice)',
      'No sustained tachycardia, fever, or diaphoresis',
      'Behavior is reactive to stimulation',
      'No postictal period or loss of awareness',
    ],
  ),

  // ── Seizure Case 1 ──
  PatternCase(
    scenarioText:
        '28 y/o male, severe TBI day 7, known bifrontal contusions. Nurse '
        'calls urgently: patient is shaking. On arrival you observe '
        'generalized rhythmic jerking of all extremities.',
    vitals: VitalSignAnimation(
      hrStart: 88,
      hrEnd: 125,
      bpSysStart: 130,
      bpSysEnd: 172,
      bpDiaStart: 80,
      bpDiaEnd: 95,
      tempStart: 37.1,
      tempEnd: 37.8,
      rrStart: 16,
      rrEnd: 28,
    ),
    observableSigns: [
      'Bilateral tonic extension followed by rhythmic clonic jerking',
      'Eyes deviated upward, unresponsive to voice',
      'Jaw clenched, blood-tinged saliva at lips',
      'Episode lasts approximately 90 seconds then stops abruptly',
      'Post-event: flaccid, unresponsive, shallow breathing',
    ],
    correctDiagnosis: 'seizure',
    explanation:
        'Generalized tonic-clonic activity with loss of awareness, eye '
        'deviation, a discrete start/stop, and postictal unresponsiveness '
        'is a classic generalized seizure.',
    distinguishingFeatures: [
      'Rhythmic tonic-clonic movements with clear evolution',
      'Loss of awareness and eye deviation',
      'Discrete episode with clear start and stop',
      'Postictal period (flaccid, unresponsive after event)',
      'Tongue/cheek bite (blood-tinged saliva)',
    ],
  ),

  // ── Seizure Case 2 ──
  PatternCase(
    scenarioText:
        '55 y/o female, TBI day 4, left temporal contusion with thin SDH. '
        'During morning assessment, patient suddenly stops responding. Right '
        'arm begins rhythmic jerking.',
    vitals: VitalSignAnimation(
      hrStart: 76,
      hrEnd: 112,
      bpSysStart: 134,
      bpSysEnd: 158,
      bpDiaStart: 82,
      bpDiaEnd: 92,
      tempStart: 37.0,
      tempEnd: 37.4,
      rrStart: 14,
      rrEnd: 22,
    ),
    observableSigns: [
      'Right arm: rhythmic clonic jerking at 3 Hz frequency',
      'Head and eyes deviated to the right',
      'Patient does not respond to name or commands',
      'Left arm and legs initially still, then subtle bilateral involvement',
      'Urinary incontinence noted during event',
    ],
    correctDiagnosis: 'seizure',
    explanation:
        'Focal-onset seizure (left temporal lesion causing right-sided '
        'symptoms) with secondary generalization. Forced eye/head deviation, '
        'rhythmic clonic jerking, and incontinence are classic.',
    distinguishingFeatures: [
      'Focal onset with secondary generalization (Jacksonian march)',
      'Rhythmic clonic activity at consistent frequency',
      'Forced head/eye deviation (versive seizure)',
      'Loss of consciousness with incontinence',
      'Localizing value: right-sided signs from left temporal lesion',
    ],
  ),

  // ── PSH Case 1 ──
  PatternCase(
    scenarioText:
        '22 y/o male, severe DAI, GCS 6T, TBI day 10. During tracheostomy '
        'suctioning, nursing observes sudden onset of posturing, sweating, '
        'and dramatic vital sign changes.',
    vitals: VitalSignAnimation(
      hrStart: 92,
      hrEnd: 148,
      bpSysStart: 130,
      bpSysEnd: 195,
      bpDiaStart: 78,
      bpDiaEnd: 110,
      tempStart: 37.2,
      tempEnd: 39.1,
      rrStart: 18,
      rrEnd: 32,
    ),
    observableSigns: [
      'Bilateral extensor posturing (decerebrate pattern)',
      'Profuse diaphoresis -- sheets visibly damp',
      'Skin flushed, pupils dilated bilaterally',
      'Episode triggered by tracheal suctioning',
      'Resolves gradually over 20 minutes after stimulus removed',
    ],
    correctDiagnosis: 'psh',
    explanation:
        'Classic paroxysmal sympathetic hyperactivity: stimulus-triggered '
        'stereotyped posturing with massive sympathetic discharge '
        '(HR >130, fever >38.5, diaphoresis, hypertension). Gradual '
        'resolution after removing the noxious trigger.',
    distinguishingFeatures: [
      'Triggered by noxious stimulus (suctioning)',
      'Stereotyped posturing (decerebrate), not variable movements',
      'Tachycardia >130 bpm with hypertension >180 systolic',
      'Fever >38.5C, profuse diaphoresis, pupil dilation',
      'Gradual resolution when trigger removed (no postictal period)',
    ],
  ),

  // ── PSH Case 2 ──
  PatternCase(
    scenarioText:
        '38 y/o female, severe TBI with brainstem contusion, GCS 5T, day '
        '18. During bed bath and repositioning, patient develops dramatic '
        'posturing episodes with vital sign instability.',
    vitals: VitalSignAnimation(
      hrStart: 88,
      hrEnd: 142,
      bpSysStart: 125,
      bpSysEnd: 188,
      bpDiaStart: 75,
      bpDiaEnd: 105,
      tempStart: 37.4,
      tempEnd: 38.8,
      rrStart: 16,
      rrEnd: 34,
    ),
    observableSigns: [
      'Bilateral upper extremity flexion, lower extremity extension (decorticate)',
      'Profuse sweating and facial flushing',
      'Tachypnea with labored breathing pattern',
      'No eye deviation or rhythmic movements',
      'Multiple similar episodes daily, each triggered by care activities',
    ],
    correctDiagnosis: 'psh',
    explanation:
        'Recurrent, stimulus-provoked paroxysms with stereotyped posturing, '
        'sympathetic surge (tachycardia, hypertension, hyperthermia, '
        'diaphoresis, tachypnea), and history of multiple similar episodes '
        'triggered by care = PSH.',
    distinguishingFeatures: [
      'Recurrent stereotyped episodes triggered by care activities',
      'Sympathetic storm: HR >130, BP >180, temp >38.5, diaphoresis',
      'Posturing pattern (decorticate) rather than seizure-like jerking',
      'No loss of awareness beyond baseline (already GCS 5T)',
      'Multiple daily episodes with consistent trigger-response pattern',
    ],
  ),
];

// =============================================================================
// Answer button colors
// =============================================================================

const Color _agitationColor = Color(0xFFFB923C); // orange
const Color _seizureColor = Color(0xFF818CF8); // indigo
const Color _pshColor = Color(0xFFEF4444); // red

// =============================================================================
// Main Widget
// =============================================================================

class PatternRecognitionView extends StatefulWidget {
  const PatternRecognitionView({super.key});

  @override
  State<PatternRecognitionView> createState() =>
      _PatternRecognitionViewState();
}

class _PatternRecognitionViewState extends State<PatternRecognitionView>
    with TickerProviderStateMixin {
  late List<PatternCase> _cases;
  int _caseIndex = 0;
  bool _hasAnswered = false;
  String? _selectedAnswer;
  bool _showingSummary = false;

  // Scoring
  int _correctCount = 0;
  final List<double> _responseTimes = [];
  final Stopwatch _caseStopwatch = Stopwatch();

  // Timer
  static const int _timerSeconds = 30;
  int _secondsRemaining = _timerSeconds;
  Timer? _countdownTimer;

  // Vitals animation
  late AnimationController _vitalsAnimController;
  late Animation<double> _vitalsProgress;

  // Sign reveal
  int _revealedSigns = 0;
  Timer? _signRevealTimer;

  // Feedback animation
  late AnimationController _feedbackController;

  @override
  void initState() {
    super.initState();
    _cases = List.of(_casesBank)..shuffle();

    _vitalsAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _vitalsProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _vitalsAnimController, curve: Curves.easeInOut),
    );

    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _startCase();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _signRevealTimer?.cancel();
    _vitalsAnimController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _startCase() {
    _hasAnswered = false;
    _selectedAnswer = null;
    _secondsRemaining = _timerSeconds;
    _revealedSigns = 0;
    _caseStopwatch
      ..reset()
      ..start();

    _vitalsAnimController
      ..reset()
      ..forward();

    // Start countdown timer
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _secondsRemaining--;
        if (_secondsRemaining <= 0) {
          timer.cancel();
          if (!_hasAnswered) {
            _submitAnswer(null); // Time ran out
          }
        }
      });
    });

    // Reveal observable signs one at a time over 5 seconds
    _signRevealTimer?.cancel();
    final totalSigns = _cases[_caseIndex].observableSigns.length;
    final interval = totalSigns > 0 ? 5000 ~/ totalSigns : 1000;
    _signRevealTimer = Timer.periodic(
      Duration(milliseconds: interval),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          _revealedSigns++;
          if (_revealedSigns >= totalSigns) timer.cancel();
        });
      },
    );
  }

  void _submitAnswer(String? answer) {
    if (_hasAnswered) return;
    HapticFeedback.mediumImpact();
    _caseStopwatch.stop();
    _countdownTimer?.cancel();
    _signRevealTimer?.cancel();

    final currentCase = _cases[_caseIndex];
    final isCorrect = answer == currentCase.correctDiagnosis;

    setState(() {
      _hasAnswered = true;
      _selectedAnswer = answer;
      _revealedSigns = currentCase.observableSigns.length;
      if (isCorrect) _correctCount++;
      _responseTimes.add(_caseStopwatch.elapsedMilliseconds / 1000.0);
    });

    _feedbackController
      ..reset()
      ..forward();
  }

  void _nextCase() {
    if (_caseIndex < _cases.length - 1) {
      setState(() => _caseIndex++);
      _startCase();
    } else {
      setState(() => _showingSummary = true);
    }
  }

  void _restart() {
    setState(() {
      _cases.shuffle();
      _caseIndex = 0;
      _correctCount = 0;
      _responseTimes.clear();
      _showingSummary = false;
    });
    _startCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: const Text('Pattern Recognition'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Case ${_caseIndex + 1}/${_cases.length}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _showingSummary ? _buildSummary() : _buildCaseView(),
    );
  }

  // ── Case View ──

  Widget _buildCaseView() {
    final currentCase = _cases[_caseIndex];

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 8),
              // Timer arc
              _buildTimer(),
              const SizedBox(height: 16),
              // Scenario narrative
              _buildScenarioPanel(currentCase),
              const SizedBox(height: 16),
              // Vitals panel
              _buildVitalsPanel(currentCase),
              const SizedBox(height: 16),
              // Observable signs
              _buildObservableSignsPanel(currentCase),
              const SizedBox(height: 16),
              // Feedback (after answering)
              if (_hasAnswered) _buildFeedback(currentCase),
              const SizedBox(height: 16),
            ],
          ),
        ),
        // Answer buttons or Next button
        _hasAnswered ? _buildNextBar() : _buildAnswerButtons(),
      ],
    );
  }

  Widget _buildTimer() {
    final fraction = _secondsRemaining / _timerSeconds;
    final isUrgent = _secondsRemaining <= 10;
    final color =
        _hasAnswered ? AppTheme.textSecondary : (isUrgent ? AppTheme.dangerRed : AppTheme.primaryCyan);

    return Center(
      child: SizedBox(
        width: 64,
        height: 64,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: _hasAnswered ? 0.0 : fraction,
              strokeWidth: 4,
              backgroundColor: AppTheme.border,
              valueColor: AlwaysStoppedAnimation(color),
            ),
            Text(
              _hasAnswered ? '--' : '$_secondsRemaining',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioPanel(PatternCase pc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description_rounded,
                  size: 16, color: AppTheme.primaryCyan),
              SizedBox(width: 8),
              Text(
                'CLINICAL SCENARIO',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryCyan,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            pc.scenarioText,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textPrimary,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalsPanel(PatternCase pc) {
    return AnimatedBuilder(
      animation: _vitalsProgress,
      builder: (context, _) {
        final t = _hasAnswered ? 1.0 : _vitalsProgress.value;
        final v = pc.vitals;

        final hr = _lerpInt(v.hrStart, v.hrEnd, t);
        final bpSys = _lerpInt(v.bpSysStart, v.bpSysEnd, t);
        final bpDia = _lerpInt(v.bpDiaStart, v.bpDiaEnd, t);
        final temp = _lerpDouble(v.tempStart, v.tempEnd, t);
        final rr = _lerpInt(v.rrStart, v.rrEnd, t);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.monitor_heart_rounded,
                      size: 16, color: AppTheme.secondaryAmber),
                  SizedBox(width: 8),
                  Text(
                    'VITAL SIGNS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.secondaryAmber,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _VitalTile(
                    label: 'HR',
                    value: '$hr',
                    unit: 'bpm',
                    isAbnormal: hr > 120,
                  )),
                  Expanded(
                      child: _VitalTile(
                    label: 'BP',
                    value: '$bpSys/$bpDia',
                    unit: 'mmHg',
                    isAbnormal: bpSys > 160,
                  )),
                  Expanded(
                      child: _VitalTile(
                    label: 'Temp',
                    value: temp.toStringAsFixed(1),
                    unit: 'C',
                    isAbnormal: temp > 38.5,
                  )),
                  Expanded(
                      child: _VitalTile(
                    label: 'RR',
                    value: '$rr',
                    unit: '/min',
                    isAbnormal: rr > 24,
                  )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildObservableSignsPanel(PatternCase pc) {
    final signs = pc.observableSigns;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.visibility_rounded,
                  size: 16, color: AppTheme.pathophysColor),
              SizedBox(width: 8),
              Text(
                'OBSERVABLE SIGNS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.pathophysColor,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...List.generate(signs.length, (i) {
            final visible = i < _revealedSigns;
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: visible ? 1.0 : 0.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '\u2022  ',
                      style: TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14),
                    ),
                    Expanded(
                      child: Text(
                        signs[i],
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textPrimary,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeedback(PatternCase pc) {
    final isCorrect = _selectedAnswer == pc.correctDiagnosis;
    final feedbackColor =
        isCorrect ? AppTheme.successGreen : AppTheme.dangerRed;

    return AnimatedBuilder(
      animation: _feedbackController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + 0.05 * _feedbackController.value,
          child: Opacity(
            opacity: _feedbackController.value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: feedbackColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: feedbackColor.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isCorrect
                      ? Icons.check_circle_rounded
                      : Icons.cancel_rounded,
                  color: feedbackColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isCorrect ? 'Correct!' : 'Incorrect',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: feedbackColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _colorForDiagnosis(pc.correctDiagnosis)
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _labelForDiagnosis(pc.correctDiagnosis),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _colorForDiagnosis(pc.correctDiagnosis),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              pc.explanation,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textPrimary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'DISTINGUISHING FEATURES',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.textSecondary,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            ...pc.distinguishingFeatures.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_right_rounded,
                        size: 18,
                        color: feedbackColor.withValues(alpha: 0.7)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        f,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated.withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _AnswerButton(
                label: 'Agitation',
                color: _agitationColor,
                onTap: () => _submitAnswer('agitation'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _AnswerButton(
                label: 'Seizure',
                color: _seizureColor,
                onTap: () => _submitAnswer('seizure'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _AnswerButton(
                label: 'PSH',
                color: _pshColor,
                onTap: () => _submitAnswer('psh'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextBar() {
    final isLast = _caseIndex == _cases.length - 1;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated.withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _nextCase,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryCyan.withValues(alpha: 0.15),
              foregroundColor: AppTheme.primaryCyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                ),
              ),
              elevation: 0,
            ),
            child: Text(
              isLast ? 'View Results' : 'Next Case',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Summary ──

  Widget _buildSummary() {
    final avgTime = _responseTimes.isNotEmpty
        ? _responseTimes.reduce((a, b) => a + b) / _responseTimes.length
        : 0.0;
    final percentage =
        _cases.isNotEmpty ? (_correctCount / _cases.length * 100).round() : 0;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              percentage >= 80
                  ? Icons.emoji_events_rounded
                  : percentage >= 50
                      ? Icons.thumb_up_rounded
                      : Icons.refresh_rounded,
              size: 56,
              color: percentage >= 80
                  ? AppTheme.secondaryAmber
                  : percentage >= 50
                      ? AppTheme.primaryCyan
                      : AppTheme.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              '$_correctCount / ${_cases.length}',
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: AppTheme.textPrimary,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$percentage% Correct',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer_rounded,
                      size: 18, color: AppTheme.primaryCyan),
                  const SizedBox(width: 8),
                  Text(
                    'Avg Response: ${avgTime.toStringAsFixed(1)}s',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton(
                onPressed: _restart,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppTheme.primaryCyan.withValues(alpha: 0.15),
                  foregroundColor: AppTheme.primaryCyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                    ),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──

  int _lerpInt(int a, int b, double t) => (a + (b - a) * t).round();
  double _lerpDouble(double a, double b, double t) => a + (b - a) * t;

  Color _colorForDiagnosis(String d) {
    switch (d) {
      case 'agitation':
        return _agitationColor;
      case 'seizure':
        return _seizureColor;
      case 'psh':
        return _pshColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _labelForDiagnosis(String d) {
    switch (d) {
      case 'agitation':
        return 'Agitation';
      case 'seizure':
        return 'Seizure';
      case 'psh':
        return 'PSH';
      default:
        return d;
    }
  }
}

// =============================================================================
// Vital Tile
// =============================================================================

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
    final color = isAbnormal ? AppTheme.dangerRed : AppTheme.textPrimary;

    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color,
            letterSpacing: -0.5,
          ),
          child: Text(value),
        ),
        Text(
          unit,
          style: TextStyle(
            fontSize: 10,
            color: isAbnormal
                ? AppTheme.dangerRed.withValues(alpha: 0.7)
                : AppTheme.textSecondary,
          ),
        ),
        if (isAbnormal)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.dangerRed,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.dangerRed.withValues(alpha: 0.5),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// =============================================================================
// Answer Button
// =============================================================================

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(alpha: 0.35),
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}
