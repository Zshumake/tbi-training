import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/progress_service.dart';

// ════════════════════════════════════════════════════════════════
// Medication-Indication Matching Grid
// ════════════════════════════════════════════════════════════════

class _MedPair {
  final String medication;
  final String indication;
  const _MedPair(this.medication, this.indication);
}

class _Round {
  final String title;
  final Color accentColor;
  final List<_MedPair> pairs;
  final String boardPearl;

  const _Round({
    required this.title,
    required this.accentColor,
    required this.pairs,
    required this.boardPearl,
  });
}

class MedMatchingView extends StatefulWidget {
  const MedMatchingView({super.key});

  @override
  State<MedMatchingView> createState() => _MedMatchingViewState();
}

class _MedMatchingViewState extends State<MedMatchingView> {
  static final List<_Round> _rounds = [
    _Round(
      title: 'Round 1: Recovery Agents',
      accentColor: AppTheme.pharmacologyColor,
      pairs: const [
        _MedPair('Amantadine', 'Disorders of consciousness / arousal'),
        _MedPair('Methylphenidate', 'Attention / processing speed'),
        _MedPair('Donepezil', 'Memory (moderate-severe TBI)'),
        _MedPair('Modafinil', 'Excessive daytime sleepiness'),
        _MedPair('Bromocriptine', 'Executive function / initiation'),
      ],
      boardPearl:
          'Amantadine is the only medication with Level B evidence (Giacino 2012 NEJM trial) '
          'for accelerating recovery in disorders of consciousness after TBI. '
          'Start 100 mg BID, titrate to 200 mg BID over 2 weeks.',
    ),
    _Round(
      title: 'Round 2: Agitation & Behavioral',
      accentColor: AppTheme.agitationColor,
      pairs: const [
        _MedPair('Propranolol', 'Agitation (best Cochrane evidence)'),
        _MedPair('Valproic acid', 'Mood stabilization / agitation'),
        _MedPair('Trazodone', 'Agitation + sleep disturbance'),
        _MedPair('Quetiapine', 'Agitation with psychotic features'),
        _MedPair('DDAVP', 'Diabetes insipidus'),
      ],
      boardPearl:
          'Beta-blockers (propranolol) have the strongest evidence for agitation in TBI per Cochrane review. '
          'They reduce sympathetic hyperactivity (paroxysmal sympathetic hyperactivity / storming) '
          'and do not impair cognition like benzodiazepines.',
    ),
    _Round(
      title: 'Round 3: Medications to AVOID',
      accentColor: AppTheme.dangerRed,
      pairs: const [
        _MedPair('Haloperidol', 'AVOID: impairs motor recovery'),
        _MedPair('Phenytoin (chronic)', 'AVOID: cognitive impairment'),
        _MedPair('Benzodiazepines', 'AVOID: impairs new learning'),
        _MedPair('Diphenhydramine', 'AVOID: anticholinergic, paradoxical agitation'),
        _MedPair('Metoclopramide', 'AVOID: EPS, use ondansetron instead'),
      ],
      boardPearl:
          'The "no-no" list for TBI: D2 blockers (haloperidol, metoclopramide), '
          'benzodiazepines, anticholinergics, and chronic phenytoin all impair neural recovery. '
          'Phenytoin prophylaxis is only indicated for 7 days post-injury.',
    ),
  ];

  int _roundIndex = 0;
  late List<String> _shuffledMeds;
  late List<String> _shuffledIndications;
  final Map<String, String> _matched = {}; // indication -> medication
  final Set<String> _correctMatches = {};
  String? _flashWrongIndication;
  int _totalCorrect = 0;
  bool _roundComplete = false;
  bool _showResults = false;

  _Round get _currentRound => _rounds[_roundIndex];

  @override
  void initState() {
    super.initState();
    _shuffleRound();
  }

  void _shuffleRound() {
    final rng = Random();
    _shuffledMeds = _currentRound.pairs.map((p) => p.medication).toList()
      ..shuffle(rng);
    _shuffledIndications =
        _currentRound.pairs.map((p) => p.indication).toList()..shuffle(rng);
    _matched.clear();
    _correctMatches.clear();
    _roundComplete = false;
    _flashWrongIndication = null;
  }

  String? _correctMedForIndication(String indication) {
    for (final pair in _currentRound.pairs) {
      if (pair.indication == indication) return pair.medication;
    }
    return null;
  }

  bool _isMedUsed(String med) => _matched.containsValue(med);

  void _handleDrop(String medication, String indication) {
    final correct = _correctMedForIndication(indication);
    if (correct == medication) {
      HapticFeedback.mediumImpact();
      setState(() {
        _matched[indication] = medication;
        _correctMatches.add(indication);
        _totalCorrect++;
        if (_correctMatches.length == _currentRound.pairs.length) {
          _roundComplete = true;
        }
      });
    } else {
      HapticFeedback.heavyImpact();
      setState(() => _flashWrongIndication = indication);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) setState(() => _flashWrongIndication = null);
      });
    }
  }

  void _nextRound() {
    if (_roundIndex >= _rounds.length - 1) {
      ProgressService.recordQuizResult(_totalCorrect, _rounds.length * 5);
      ProgressService.recordStudySession();
      setState(() => _showResults = true);
      return;
    }
    setState(() {
      _roundIndex++;
      _shuffleRound();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showResults) return _buildResultsScreen();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('Med Matching  (${_roundIndex + 1}/${_rounds.length})'),
        backgroundColor: AppTheme.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Round title
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _currentRound.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _currentRound.accentColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  _currentRound.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _currentRound.accentColor,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Drag each medication to its correct indication',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 16),

              // Medication chips (draggable)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: _shuffledMeds.map((med) {
                  final used = _isMedUsed(med);
                  if (used) {
                    return _MedChipPlaceholder(label: med);
                  }
                  return Draggable<String>(
                    data: med,
                    feedback: Material(
                      color: Colors.transparent,
                      child: _MedChip(
                        label: med,
                        color: _currentRound.accentColor,
                        isDragging: true,
                      ),
                    ),
                    childWhenDragging: _MedChipPlaceholder(label: med),
                    child: _MedChip(
                      label: med,
                      color: _currentRound.accentColor,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Indication drop targets
              ..._shuffledIndications.map((indication) {
                final matchedMed = _matched[indication];
                final isCorrect = _correctMatches.contains(indication);
                final isFlashingWrong = _flashWrongIndication == indication;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DragTarget<String>(
                    onWillAcceptWithDetails: (_) =>
                        !isCorrect,
                    onAcceptWithDetails: (details) =>
                        _handleDrop(details.data, indication),
                    builder: (context, candidateData, rejectedData) {
                      final isHovering = candidateData.isNotEmpty;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? AppTheme.successGreen.withValues(alpha: 0.1)
                              : isFlashingWrong
                                  ? AppTheme.dangerRed.withValues(alpha: 0.15)
                                  : isHovering
                                      ? AppTheme.primaryCyan
                                          .withValues(alpha: 0.08)
                                      : AppTheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isCorrect
                                ? AppTheme.successGreen
                                : isFlashingWrong
                                    ? AppTheme.dangerRed
                                    : isHovering
                                        ? AppTheme.primaryCyan
                                        : AppTheme.border,
                            width: isCorrect || isFlashingWrong ? 1.5 : 1,
                            style: isCorrect
                                ? BorderStyle.solid
                                : BorderStyle.solid,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (isCorrect)
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  color: AppTheme.successGreen,
                                  size: 20,
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    indication,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isCorrect
                                          ? AppTheme.textPrimary
                                          : AppTheme.textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                  if (matchedMed != null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      matchedMed,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.successGreen,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            if (!isCorrect)
                              Icon(
                                Icons.drag_indicator_rounded,
                                color: AppTheme.textSecondary
                                    .withValues(alpha: 0.4),
                                size: 20,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Score + board pearl when round complete
              if (_roundComplete) ...[
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
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_rounded,
                            color: AppTheme.secondaryAmber,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'BOARD PEARL',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.secondaryAmber,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _currentRound.boardPearl,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textPrimary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _nextRound,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppTheme.primaryCyan.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _roundIndex < _rounds.length - 1
                            ? 'Next Round'
                            : 'View Results',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryCyan,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final total = _rounds.length * 5;
    final pct = ((_totalCorrect / total) * 100).round();
    final color = pct >= 80
        ? AppTheme.successGreen
        : pct >= 60
            ? AppTheme.secondaryAmber
            : AppTheme.dangerRed;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Med Matching Results'),
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
                '$_totalCorrect / $total Matched',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$pct% across ${_rounds.length} rounds',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryCyan.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryCyan,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Draggable medication chip ──

class _MedChip extends StatelessWidget {
  const _MedChip({
    required this.label,
    required this.color,
    this.isDragging = false,
  });

  final String label;
  final Color color;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDragging
            ? color.withValues(alpha: 0.2)
            : AppTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: isDragging ? 0.6 : 0.35),
          width: 1.5,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _MedChipPlaceholder extends StatelessWidget {
  const _MedChipPlaceholder({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.border.withValues(alpha: 0.3),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.textSecondary.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
