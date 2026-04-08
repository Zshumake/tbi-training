import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/progress_service.dart';

// ════════════════════════════════════════════════════════════════
// GCS Component Builder - Interactive GCS scoring trainer
// ════════════════════════════════════════════════════════════════

class GCSCase {
  final String vignette;
  final int correctE;
  final String correctELabel;
  final int correctV; // -1 means "T" (intubated)
  final String correctVLabel;
  final int correctM;
  final String correctMLabel;
  final bool isIntubated;

  const GCSCase({
    required this.vignette,
    required this.correctE,
    required this.correctELabel,
    required this.correctV,
    required this.correctVLabel,
    required this.correctM,
    required this.correctMLabel,
    this.isIntubated = false,
  });

  int get totalGCS => correctE + (isIntubated ? 0 : correctV) + correctM;

  String get gcsString {
    final vStr = isIntubated ? 'T' : '$correctV';
    final total = isIntubated ? '${correctE + correctM}T' : '$totalGCS';
    return 'GCS = E$correctE + V$vStr + M$correctM = $total';
  }

  String get severity {
    final score = isIntubated ? correctE + correctM : totalGCS;
    if (isIntubated) {
      // With T, use E+M to approximate
      if (score <= 5) return 'Severe';
      if (score <= 9) return 'Moderate';
      return 'Mild';
    }
    if (score <= 8) return 'Severe';
    if (score <= 12) return 'Moderate';
    return 'Mild';
  }
}

class GCSBuilderView extends StatefulWidget {
  const GCSBuilderView({super.key});

  @override
  State<GCSBuilderView> createState() => _GCSBuilderViewState();
}

class _GCSBuilderViewState extends State<GCSBuilderView>
    with TickerProviderStateMixin {
  static const List<GCSCase> _cases = [
    GCSCase(
      vignette:
          '25-year-old female, motor vehicle collision. Opens eyes to pain, moans incomprehensibly, withdraws from pain.',
      correctE: 2,
      correctELabel: 'E2: To pressure',
      correctV: 2,
      correctVLabel: 'V2: Incomprehensible',
      correctM: 4,
      correctMLabel: 'M4: Flexion withdrawal',
    ),
    GCSCase(
      vignette:
          '62-year-old male, fall from standing. Eyes open spontaneously, confused speech, obeys commands.',
      correctE: 4,
      correctELabel: 'E4: Spontaneous',
      correctV: 4,
      correctVLabel: 'V4: Confused',
      correctM: 6,
      correctMLabel: 'M6: Obeys commands',
    ),
    GCSCase(
      vignette:
          '18-year-old male, assault with baseball bat. No eye opening, intubated, extension posturing to pain.',
      correctE: 1,
      correctELabel: 'E1: None',
      correctV: -1,
      correctVLabel: 'VT: Intubated',
      correctM: 2,
      correctMLabel: 'M2: Extension',
      isIntubated: true,
    ),
    GCSCase(
      vignette:
          '45-year-old female, bicycle crash without helmet. Eyes open to voice, oriented speech, follows commands on exam.',
      correctE: 3,
      correctELabel: 'E3: To voice',
      correctV: 5,
      correctVLabel: 'V5: Oriented',
      correctM: 6,
      correctMLabel: 'M6: Obeys commands',
    ),
    GCSCase(
      vignette:
          '30-year-old male, blast injury from IED. No eye opening, no verbal response, flexion withdrawal to pain.',
      correctE: 1,
      correctELabel: 'E1: None',
      correctV: 1,
      correctVLabel: 'V1: None',
      correctM: 4,
      correctMLabel: 'M4: Flexion withdrawal',
    ),
  ];

  int _caseIndex = 0;
  int? _selectedE;
  int? _selectedV; // -1 = T
  int? _selectedM;
  bool _submitted = false;
  int _correctCount = 0;
  bool _showResults = false;

  late AnimationController _flashController;
  late Animation<double> _flashAnimation;

  GCSCase get _currentCase => _cases[_caseIndex];

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _flashAnimation = CurvedAnimation(
      parent: _flashController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _flashController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _selectedE != null && _selectedV != null && _selectedM != null;

  bool get _eCorrect => _selectedE == _currentCase.correctE;
  bool get _vCorrect => _selectedV == _currentCase.correctV;
  bool get _mCorrect => _selectedM == _currentCase.correctM;
  bool get _allCorrect => _eCorrect && _vCorrect && _mCorrect;

  String get _runningTotal {
    final e = _selectedE ?? '_';
    final v = _selectedV == null
        ? '_'
        : (_selectedV == -1 ? 'T' : '$_selectedV');
    final m = _selectedM ?? '_';

    if (_selectedE != null && _selectedV != null && _selectedM != null) {
      if (_selectedV == -1) {
        return 'GCS = E$e + V$v + M$m = ${_selectedE! + _selectedM!}T';
      }
      final total = _selectedE! + _selectedV! + _selectedM!;
      return 'GCS = E$e + V$v + M$m = $total';
    }
    return 'GCS = E$e + V$v + M$m = __';
  }

  String _severityLabel(int? e, int? v, int? m) {
    if (e == null || v == null || m == null) return '';
    if (v == -1) {
      final score = e + m;
      if (score <= 5) return 'Severe';
      if (score <= 9) return 'Moderate';
      return 'Mild';
    }
    final total = e + v + m;
    if (total <= 8) return 'Severe';
    if (total <= 12) return 'Moderate';
    return 'Mild';
  }

  Color _severityColor(String severity) {
    switch (severity) {
      case 'Severe':
        return AppTheme.dangerRed;
      case 'Moderate':
        return AppTheme.secondaryAmber;
      case 'Mild':
        return AppTheme.successGreen;
      default:
        return AppTheme.textSecondary;
    }
  }

  void _submit() {
    if (!_canSubmit) return;
    setState(() {
      _submitted = true;
      if (_allCorrect) _correctCount++;
    });
    _flashController.forward(from: 0);
    HapticFeedback.mediumImpact();
  }

  void _nextCase() {
    if (_caseIndex >= _cases.length - 1) {
      // Show results
      ProgressService.recordQuizResult(_correctCount, _cases.length);
      ProgressService.recordStudySession();
      setState(() => _showResults = true);
      return;
    }
    setState(() {
      _caseIndex++;
      _selectedE = null;
      _selectedV = null;
      _selectedM = null;
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showResults) return _buildResultsScreen();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('GCS Builder  (${_caseIndex + 1}/${_cases.length})'),
        backgroundColor: AppTheme.background,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Vignette card
                  _buildVignetteCard(),
                  const SizedBox(height: 20),

                  // Three columns: E, V, M
                  _buildScoringColumns(),
                  const SizedBox(height: 20),

                  // Running total
                  _buildRunningTotal(),
                  const SizedBox(height: 16),

                  // Submit / Next button
                  if (!_submitted)
                    _buildActionButton(
                      'Submit Answer',
                      _canSubmit ? _submit : null,
                      AppTheme.primaryCyan,
                    )
                  else ...[
                    _buildFeedbackBanner(),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      _caseIndex < _cases.length - 1
                          ? 'Next Case'
                          : 'View Results',
                      _nextCase,
                      AppTheme.primaryCyan,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVignetteCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.secondaryAmber.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_rounded,
                color: AppTheme.secondaryAmber,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'CLINICAL VIGNETTE',
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
          Text(
            _currentCase.vignette,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppTheme.textPrimary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoringColumns() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildColumn(
            'Eye (E)',
            _eyeOptions(),
            _selectedE,
            (val) {
              if (!_submitted) setState(() => _selectedE = val);
            },
            _submitted ? _currentCase.correctE : null,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildColumn(
            'Verbal (V)',
            _currentCase.isIntubated ? _verbalIntubatedOptions() : _verbalOptions(),
            _selectedV,
            (val) {
              if (!_submitted) setState(() => _selectedV = val);
            },
            _submitted ? _currentCase.correctV : null,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildColumn(
            'Motor (M)',
            _motorOptions(),
            _selectedM,
            (val) {
              if (!_submitted) setState(() => _selectedM = val);
            },
            _submitted ? _currentCase.correctM : null,
          ),
        ),
      ],
    );
  }

  List<_GCSOption> _eyeOptions() => const [
        _GCSOption(4, 'E4: Spontaneous'),
        _GCSOption(3, 'E3: To voice'),
        _GCSOption(2, 'E2: To pressure'),
        _GCSOption(1, 'E1: None'),
      ];

  List<_GCSOption> _verbalOptions() => const [
        _GCSOption(5, 'V5: Oriented'),
        _GCSOption(4, 'V4: Confused'),
        _GCSOption(3, 'V3: Words'),
        _GCSOption(2, 'V2: Sounds'),
        _GCSOption(1, 'V1: None'),
      ];

  List<_GCSOption> _verbalIntubatedOptions() => const [
        _GCSOption(-1, 'VT: Intubated'),
      ];

  List<_GCSOption> _motorOptions() => const [
        _GCSOption(6, 'M6: Obeys'),
        _GCSOption(5, 'M5: Localizing'),
        _GCSOption(4, 'M4: Flexion'),
        _GCSOption(3, 'M3: Abnormal flexion'),
        _GCSOption(2, 'M2: Extension'),
        _GCSOption(1, 'M1: None'),
      ];

  Widget _buildColumn(
    String title,
    List<_GCSOption> options,
    int? selected,
    ValueChanged<int> onSelect,
    int? correctValue,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.textSecondary,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        ...options.map((opt) {
          final isSelected = selected == opt.value;
          final bool isCorrect = correctValue == opt.value;
          final bool isWrong =
              _submitted && isSelected && correctValue != opt.value;

          Color borderColor;
          Color bgColor;

          if (_submitted) {
            if (isCorrect) {
              borderColor = AppTheme.successGreen;
              bgColor = AppTheme.successGreen.withValues(alpha: 0.15);
            } else if (isWrong) {
              borderColor = AppTheme.dangerRed;
              bgColor = AppTheme.dangerRed.withValues(alpha: 0.15);
            } else if (isSelected) {
              borderColor = AppTheme.primaryCyan;
              bgColor = AppTheme.primaryCyan.withValues(alpha: 0.1);
            } else {
              borderColor = AppTheme.border;
              bgColor = AppTheme.surface;
            }
          } else {
            if (isSelected) {
              borderColor = AppTheme.primaryCyan;
              bgColor = AppTheme.primaryCyan.withValues(alpha: 0.1);
            } else {
              borderColor = AppTheme.border;
              bgColor = AppTheme.surface;
            }
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                onSelect(opt.value);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: borderColor, width: 1.5),
                  boxShadow: isSelected && !_submitted
                      ? [
                          BoxShadow(
                            color:
                                AppTheme.primaryCyan.withValues(alpha: 0.3),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  opt.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRunningTotal() {
    final severity = _severityLabel(_selectedE, _selectedV, _selectedM);
    final sevColor = _severityColor(severity);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _runningTotal,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
          ),
          if (severity.isNotEmpty)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: sevColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: sevColor.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                severity,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: sevColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeedbackBanner() {
    return AnimatedBuilder(
      animation: _flashAnimation,
      builder: (context, _) {
        final color =
            _allCorrect ? AppTheme.successGreen : AppTheme.dangerRed;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1 + _flashAnimation.value * 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _allCorrect
                        ? Icons.check_circle_rounded
                        : Icons.info_outline_rounded,
                    color: color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _allCorrect ? 'Correct!' : 'Not quite.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ],
              ),
              if (!_allCorrect) ...[
                const SizedBox(height: 8),
                Text(
                  'Correct answer: ${_currentCase.gcsString}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  'Severity: ${_currentCase.severity}',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
      String label, VoidCallback? onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: onTap != null
              ? color.withValues(alpha: 0.15)
              : AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: onTap != null
                ? color.withValues(alpha: 0.4)
                : AppTheme.border,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: onTap != null ? color : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final pct = ((_correctCount / _cases.length) * 100).round();
    final color = pct >= 80
        ? AppTheme.successGreen
        : pct >= 60
            ? AppTheme.secondaryAmber
            : AppTheme.dangerRed;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('GCS Builder Results'),
        backgroundColor: AppTheme.background,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                pct >= 80 ? Icons.emoji_events_rounded : Icons.school_rounded,
                color: color,
                size: 64,
              ),
              const SizedBox(height: 24),
              Text(
                '$_correctCount / ${_cases.length} Correct',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$pct%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.pearlBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.pearlBorder),
                ),
                child: const Text(
                  'Board Pearl: GCS Motor is the strongest single predictor of outcome. '
                  'Always note "T" for intubated patients - never assign V1 if the patient '
                  'cannot vocalize due to intubation.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildActionButton(
                'Done',
                () => Navigator.pop(context),
                AppTheme.primaryCyan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GCSOption {
  final int value;
  final String label;
  const _GCSOption(this.value, this.label);
}
