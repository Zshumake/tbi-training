import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';

// ════════════════════════════════════════════════════════════════
// Data Models
// ════════════════════════════════════════════════════════════════

class CTFinding {
  const CTFinding({
    required this.name,
    required this.description,
    required this.targetZone,
    required this.color,
    required this.boardPearl,
  });

  final String name;
  final String description;
  final Rect targetZone; // Normalized 0-1 coordinates
  final Color color;
  final String boardPearl;
}

class CTCase {
  const CTCase({
    required this.title,
    required this.clinicalContext,
    required this.findings,
  });

  final String title;
  final String clinicalContext;
  final List<CTFinding> findings;
}

// ════════════════════════════════════════════════════════════════
// Case Data
// ════════════════════════════════════════════════════════════════

class CTCaseData {
  static const List<CTCase> cases = [
    CTCase(
      title: 'Case 1: Right Temporal EDH',
      clinicalContext:
          '32 y/o male, fall from ladder. Brief LOC, lucid interval, '
          'then rapid decline. Right pupil fixed and dilated. GCS 7.',
      findings: [
        CTFinding(
          name: 'Epidural Hematoma',
          description:
              'Biconvex (lens-shaped) hyperdensity in the right temporal '
              'region (viewer left = patient right by radiologic convention). '
              'Does not cross suture lines. Typical middle meningeal '
              'artery tear.',
          targetZone: Rect.fromLTWH(0.16, 0.32, 0.22, 0.30),
          color: Color(0xFFF87171),
          boardPearl:
              'EDH is biconvex and does NOT cross suture lines. The "lucid '
              'interval" occurs in ~20-50% of cases. Surgical evacuation '
              'is indicated when thickness >15 mm or midline shift >5 mm. '
              'Outcome is excellent with rapid intervention.',
        ),
      ],
    ),
    CTCase(
      title: 'Case 2: Left Acute SDH',
      clinicalContext:
          '78 y/o female on warfarin, ground-level fall. Progressive '
          'headache and confusion over 2 hours. Left-sided scalp hematoma. '
          'INR 3.4. GCS 11.',
      findings: [
        CTFinding(
          name: 'Acute Subdural Hematoma',
          description:
              'Crescent-shaped hyperdensity along the left cerebral '
              'convexity (viewer right = patient left by radiologic '
              'convention). Crosses suture lines freely. Effaced sulci '
              'and compressed left lateral ventricle indicate mass effect.',
          targetZone: Rect.fromLTWH(0.74, 0.18, 0.18, 0.55),
          color: Color(0xFFFB923C),
          boardPearl:
              'Acute SDH is crescent-shaped and crosses suture lines '
              '(unlike EDH). Bridging vein rupture is the typical mechanism. '
              'Mortality is 40-60% in severe cases. Reverse anticoagulation '
              'immediately. Surgery when thickness >10 mm or midline shift '
              '>5 mm.',
        ),
      ],
    ),
    CTCase(
      title: 'Case 3: Bifrontal Contusions',
      clinicalContext:
          '45 y/o male, high-speed MVC with frontal impact. GCS 9. '
          'Bilateral periorbital ecchymosis ("raccoon eyes"). Agitated '
          'and combative on arrival.',
      findings: [
        CTFinding(
          name: 'Left Frontal Contusion',
          description:
              'Mixed-density lesion in the left frontal lobe (viewer '
              'right = patient left). Surrounding edema. Typical coup '
              'injury location from frontal impact.',
          targetZone: Rect.fromLTWH(0.52, 0.12, 0.22, 0.22),
          color: Color(0xFF60A5FA),
          boardPearl:
              'Contusions are bruises of the brain parenchyma, often at '
              'frontal and temporal poles (coup/contrecoup). They may '
              '"blossom" (expand) over 24-72 hours -- repeat CT if '
              'neurological decline. Frontal contusions explain behavioral '
              'disinhibition and agitation.',
        ),
        CTFinding(
          name: 'Right Frontal Contusion',
          description:
              'Mixed-density lesion in the right frontal lobe (viewer '
              'left = patient right). Coup injury pattern (frontal '
              'impact) with petechial hemorrhages and perilesional edema.',
          targetZone: Rect.fromLTWH(0.26, 0.12, 0.22, 0.22),
          color: Color(0xFF38BDF8),
          boardPearl:
              'Bifrontal contusions classically follow frontal impact '
              '(coup) with possible occipital contrecoup. They are the '
              'pathologic substrate of post-TBI executive dysfunction, '
              'disinhibition, and emotional lability. Hemorrhagic '
              'progression of contusion (HPC) occurs in ~50% of cases '
              'within 24-72 hours.',
        ),
      ],
    ),
  ];
}

// ════════════════════════════════════════════════════════════════
// Main Widget
// ════════════════════════════════════════════════════════════════

class CTLabelChallenge extends StatefulWidget {
  const CTLabelChallenge({super.key});

  @override
  State<CTLabelChallenge> createState() => _CTLabelChallengeState();
}

class _CTLabelChallengeState extends State<CTLabelChallenge>
    with TickerProviderStateMixin {
  // State
  int _currentCaseIndex = 0;
  final Set<int> _foundFindings = {};
  final List<_TapMarker> _markers = [];
  bool _showingPearls = false;
  bool _showingFinalResults = false;

  // Scoring
  final Stopwatch _stopwatch = Stopwatch();
  int _totalTaps = 0;
  final List<_CaseResult> _caseResults = [];

  // Animations
  late AnimationController _markerController;
  late AnimationController _pearlController;

  CTCase get _currentCase => CTCaseData.cases[_currentCaseIndex];
  bool get _allFound => _foundFindings.length == _currentCase.findings.length;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _markerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _pearlController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _markerController.dispose();
    _pearlController.dispose();
    _stopwatch.stop();
    super.dispose();
  }

  void _handleTap(TapDownDetails details, Size canvasSize) {
    if (_showingPearls || _showingFinalResults) return;

    final normalizedX = details.localPosition.dx / canvasSize.width;
    final normalizedY = details.localPosition.dy / canvasSize.height;
    _totalTaps++;

    // Check each unfound finding
    int? hitIndex;
    for (int i = 0; i < _currentCase.findings.length; i++) {
      if (_foundFindings.contains(i)) continue;
      final zone = _currentCase.findings[i].targetZone;
      if (zone.contains(Offset(normalizedX, normalizedY))) {
        hitIndex = i;
        break;
      }
    }

    setState(() {
      if (hitIndex != null) {
        _foundFindings.add(hitIndex);
        _markers.add(_TapMarker(
          position: Offset(normalizedX, normalizedY),
          isCorrect: true,
          label: _currentCase.findings[hitIndex].name,
        ));
        HapticFeedback.mediumImpact();
      } else {
        _markers.add(_TapMarker(
          position: Offset(normalizedX, normalizedY),
          isCorrect: false,
          label: 'Try again',
        ));
        HapticFeedback.lightImpact();
      }
    });

    _markerController.forward(from: 0);

    // Check if all found
    if (_allFound) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        setState(() => _showingPearls = true);
        _pearlController.forward(from: 0);
      });
    }
  }

  void _nextCase() {
    _caseResults.add(_CaseResult(
      caseName: _currentCase.title,
      findingsFound: _foundFindings.length,
      totalFindings: _currentCase.findings.length,
      taps: _totalTaps,
    ));

    if (_currentCaseIndex < CTCaseData.cases.length - 1) {
      setState(() {
        _currentCaseIndex++;
        _foundFindings.clear();
        _markers.clear();
        _showingPearls = false;
        _totalTaps = 0;
      });
    } else {
      _stopwatch.stop();
      setState(() => _showingFinalResults = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showingFinalResults) {
      return _buildResultsScreen();
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('CT Scan Challenge'),
        backgroundColor: AppTheme.background,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Case ${_currentCaseIndex + 1}/${CTCaseData.cases.length}',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Title + Context
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentCase.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _currentCase.clinicalContext,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Score bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.pin_drop_rounded,
                      size: 16, color: AppTheme.primaryCyan),
                  const SizedBox(width: 6),
                  Text(
                    '${_foundFindings.length}/${_currentCase.findings.length} findings identified',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryCyan,
                    ),
                  ),
                  const Spacer(),
                  if (_totalTaps > 0)
                    Text(
                      '$_totalTaps taps',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // CT Scan Canvas
            Expanded(
              child: _showingPearls
                  ? _buildPearlsView()
                  : _buildScanCanvas(),
            ),

            // Next Case button when pearls are showing
            if (_showingPearls)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _nextCase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryCyan,
                      foregroundColor: AppTheme.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _currentCaseIndex < CTCaseData.cases.length - 1
                          ? 'Next Case'
                          : 'View Results',
                      style: const TextStyle(
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
    );
  }

  Widget _buildScanCanvas() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(
            constraints.maxWidth,
            constraints.maxHeight,
          );
          return GestureDetector(
            onTapDown: (details) => _handleTap(details, size),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0A0E14),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.border,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CustomPaint(
                  size: size,
                  painter: _CTScanPainter(
                    currentCase: _currentCase,
                    foundFindings: _foundFindings,
                    markers: _markers,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPearlsView() {
    return AnimatedBuilder(
      animation: _pearlController,
      builder: (context, child) {
        return Opacity(
          opacity: _pearlController.value.clamp(0.0, 1.0),
          child: child,
        );
      },
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        itemCount: _currentCase.findings.length,
        itemBuilder: (context, index) {
          final finding = _currentCase.findings[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.pearlBackground,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: finding.color.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: AppTheme.successGreen, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        finding.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: finding.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  finding.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.pearlBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppTheme.pearlBorder.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb_rounded,
                          color: AppTheme.secondaryAmber, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          finding.boardPearl,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textPrimary,
                            height: 1.5,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultsScreen() {
    // Add the last case result if not already added
    if (_caseResults.length < CTCaseData.cases.length) {
      _caseResults.add(_CaseResult(
        caseName: _currentCase.title,
        findingsFound: _foundFindings.length,
        totalFindings: _currentCase.findings.length,
        taps: _totalTaps,
      ));
    }

    final totalFound = _caseResults.fold<int>(
        0, (sum, r) => sum + r.findingsFound);
    final totalFindings = _caseResults.fold<int>(
        0, (sum, r) => sum + r.totalFindings);
    final elapsed = _stopwatch.elapsed;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: AppTheme.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Icon(
                totalFound == totalFindings
                    ? Icons.emoji_events_rounded
                    : Icons.analytics_rounded,
                size: 64,
                color: totalFound == totalFindings
                    ? AppTheme.secondaryAmber
                    : AppTheme.primaryCyan,
              ),
              const SizedBox(height: 16),
              Text(
                '$totalFound / $totalFindings Findings',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Completed in ${elapsed.inMinutes}m ${elapsed.inSeconds % 60}s',
                style: const TextStyle(
                  fontSize: 15,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: ListView.builder(
                  itemCount: _caseResults.length,
                  itemBuilder: (context, index) {
                    final r = _caseResults[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppTheme.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            r.findingsFound == r.totalFindings
                                ? Icons.check_circle_rounded
                                : Icons.radio_button_unchecked,
                            color: r.findingsFound == r.totalFindings
                                ? AppTheme.successGreen
                                : AppTheme.textSecondary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.caseName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                Text(
                                  '${r.findingsFound}/${r.totalFindings} found '
                                  'in ${r.taps} taps',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryCyan,
                    foregroundColor: AppTheme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
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
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Tap Marker Data
// ════════════════════════════════════════════════════════════════

class _TapMarker {
  const _TapMarker({
    required this.position,
    required this.isCorrect,
    required this.label,
  });

  final Offset position; // Normalized 0-1
  final bool isCorrect;
  final String label;
}

class _CaseResult {
  const _CaseResult({
    required this.caseName,
    required this.findingsFound,
    required this.totalFindings,
    required this.taps,
  });

  final String caseName;
  final int findingsFound;
  final int totalFindings;
  final int taps;
}

// ════════════════════════════════════════════════════════════════
// CT Scan Custom Painter
// ════════════════════════════════════════════════════════════════

class _CTScanPainter extends CustomPainter {
  _CTScanPainter({
    required this.currentCase,
    required this.foundFindings,
    required this.markers,
  });

  final CTCase currentCase;
  final Set<int> foundFindings;
  final List<_TapMarker> markers;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final skullRx = size.width * 0.42;
    final skullRy = size.height * 0.44;

    // Dark CT background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF050810),
    );

    // Skull outline
    final skullPaint = Paint()
      ..color = const Color(0xFF3A3A3A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawOval(
      Rect.fromCenter(center: center, width: skullRx * 2, height: skullRy * 2),
      skullPaint,
    );

    // Skull bone fill (bright ring)
    final bonePaint = Paint()
      ..color = const Color(0xFF4A4A4A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawOval(
      Rect.fromCenter(center: center, width: skullRx * 2, height: skullRy * 2),
      bonePaint,
    );

    // Brain parenchyma fill
    final brainPaint = Paint()
      ..color = const Color(0xFF2A2A2A)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: (skullRx - 6) * 2,
        height: (skullRy - 6) * 2,
      ),
      brainPaint,
    );

    // Falx cerebri (midline)
    final falxPaint = Paint()
      ..color = const Color(0xFF4A4A4A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(center.dx, center.dy - skullRy * 0.85),
      Offset(center.dx, center.dy + skullRy * 0.3),
      falxPaint,
    );

    // Ventricles (butterfly shape)
    _drawVentricles(canvas, center, size);

    // Sulci pattern
    _drawSulci(canvas, center, skullRx, skullRy);

    // Draw pathology
    for (int i = 0; i < currentCase.findings.length; i++) {
      final finding = currentCase.findings[i];
      _drawPathology(canvas, size, finding, foundFindings.contains(i));
    }

    // Draw tap markers
    for (final marker in markers) {
      _drawMarker(canvas, size, marker);
    }
  }

  void _drawVentricles(Canvas canvas, Offset center, Size size) {
    final ventPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;

    // Left lateral ventricle
    final leftVent = Path();
    leftVent.moveTo(center.dx - 4, center.dy - size.height * 0.08);
    leftVent.cubicTo(
      center.dx - size.width * 0.08, center.dy - size.height * 0.1,
      center.dx - size.width * 0.12, center.dy - size.height * 0.02,
      center.dx - size.width * 0.06, center.dy + size.height * 0.04,
    );
    leftVent.cubicTo(
      center.dx - size.width * 0.02, center.dy + size.height * 0.02,
      center.dx - 2, center.dy - size.height * 0.04,
      center.dx - 4, center.dy - size.height * 0.08,
    );
    canvas.drawPath(leftVent, ventPaint);

    // Right lateral ventricle
    final rightVent = Path();
    rightVent.moveTo(center.dx + 4, center.dy - size.height * 0.08);
    rightVent.cubicTo(
      center.dx + size.width * 0.08, center.dy - size.height * 0.1,
      center.dx + size.width * 0.12, center.dy - size.height * 0.02,
      center.dx + size.width * 0.06, center.dy + size.height * 0.04,
    );
    rightVent.cubicTo(
      center.dx + size.width * 0.02, center.dy + size.height * 0.02,
      center.dx + 2, center.dy - size.height * 0.04,
      center.dx + 4, center.dy - size.height * 0.08,
    );
    canvas.drawPath(rightVent, ventPaint);
  }

  void _drawSulci(
      Canvas canvas, Offset center, double skullRx, double skullRy) {
    final sulciPaint = Paint()
      ..color = const Color(0xFF222222)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Radial sulci lines
    for (double angle = -2.8; angle < -0.3; angle += 0.35) {
      final innerR = 0.3;
      final outerR = 0.85;
      canvas.drawLine(
        Offset(
          center.dx + math.cos(angle) * skullRx * innerR,
          center.dy + math.sin(angle) * skullRy * innerR,
        ),
        Offset(
          center.dx + math.cos(angle) * skullRx * outerR,
          center.dy + math.sin(angle) * skullRy * outerR,
        ),
        sulciPaint,
      );
    }
    for (double angle = -2.8 + math.pi; angle < -0.3 + math.pi;
        angle += 0.35) {
      final innerR = 0.3;
      final outerR = 0.85;
      canvas.drawLine(
        Offset(
          center.dx + math.cos(angle) * skullRx * innerR,
          center.dy + math.sin(angle) * skullRy * innerR,
        ),
        Offset(
          center.dx + math.cos(angle) * skullRx * outerR,
          center.dy + math.sin(angle) * skullRy * outerR,
        ),
        sulciPaint,
      );
    }
  }

  void _drawPathology(
      Canvas canvas, Size size, CTFinding finding, bool found) {
    final rect = Rect.fromLTWH(
      finding.targetZone.left * size.width,
      finding.targetZone.top * size.height,
      finding.targetZone.width * size.width,
      finding.targetZone.height * size.height,
    );

    final pathPaint = Paint()
      ..color = const Color(0xFFBBBBBB).withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    // Draw the pathology shape based on name
    if (finding.name.contains('Epidural')) {
      // Biconvex / lens shape
      final path = Path();
      path.moveTo(rect.centerLeft.dx + 4, rect.centerLeft.dy);
      path.quadraticBezierTo(
        rect.center.dx,
        rect.top,
        rect.centerRight.dx - 4,
        rect.centerRight.dy,
      );
      path.quadraticBezierTo(
        rect.center.dx,
        rect.bottom,
        rect.centerLeft.dx + 4,
        rect.centerLeft.dy,
      );
      canvas.drawPath(path, pathPaint);
    } else if (finding.name.contains('Subdural')) {
      // Crescent shape along convexity
      final path = Path();
      path.moveTo(rect.left + 4, rect.top);
      path.quadraticBezierTo(
        rect.left - 2,
        rect.centerLeft.dy,
        rect.left + 4,
        rect.bottom,
      );
      path.quadraticBezierTo(
        rect.left + rect.width * 0.6,
        rect.centerLeft.dy,
        rect.left + 4,
        rect.top,
      );
      canvas.drawPath(path, pathPaint);
    } else if (finding.name.contains('Contusion')) {
      // Irregular mixed density
      final cPaint = Paint()
        ..color = const Color(0xFF999999).withValues(alpha: 0.6)
        ..style = PaintingStyle.fill;
      canvas.drawOval(rect.deflate(rect.width * 0.1), cPaint);

      // Petechial spots
      final spotPaint = Paint()
        ..color = const Color(0xFFCCCCCC).withValues(alpha: 0.8)
        ..style = PaintingStyle.fill;
      final rng = math.Random(finding.name.hashCode);
      for (int i = 0; i < 6; i++) {
        canvas.drawCircle(
          Offset(
            rect.left + rng.nextDouble() * rect.width,
            rect.top + rng.nextDouble() * rect.height,
          ),
          2 + rng.nextDouble() * 3,
          spotPaint,
        );
      }
    }

    // If found, draw a highlight outline
    if (found) {
      final highlightPaint = Paint()
        ..color = finding.color.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRect(rect, highlightPaint);
    }
  }

  void _drawMarker(Canvas canvas, Size size, _TapMarker marker) {
    final pos = Offset(
      marker.position.dx * size.width,
      marker.position.dy * size.height,
    );

    final markerColor =
        marker.isCorrect ? const Color(0xFF34D399) : const Color(0xFFEF4444);

    // Outer glow
    canvas.drawCircle(
      pos,
      14,
      Paint()..color = markerColor.withValues(alpha: 0.25),
    );

    // Inner circle
    canvas.drawCircle(
      pos,
      6,
      Paint()..color = markerColor,
    );

    // Center dot
    canvas.drawCircle(
      pos,
      2.5,
      Paint()..color = Colors.white,
    );

    // Label background
    final textSpan = TextSpan(
      text: marker.label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        backgroundColor: markerColor.withValues(alpha: 0.85),
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    final labelOffset = Offset(
      (pos.dx - textPainter.width / 2)
          .clamp(4, size.width - textPainter.width - 4),
      pos.dy - 24,
    );

    // Label background rect
    final bgRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        labelOffset.dx - 4,
        labelOffset.dy - 2,
        textPainter.width + 8,
        textPainter.height + 4,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(
      bgRect,
      Paint()..color = markerColor.withValues(alpha: 0.85),
    );

    textPainter.paint(canvas, labelOffset);
  }

  @override
  bool shouldRepaint(covariant _CTScanPainter oldDelegate) => true;
}
