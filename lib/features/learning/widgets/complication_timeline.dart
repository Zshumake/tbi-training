import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';

// ════════════════════════════════════════════════════════════════
// Data Model
// ════════════════════════════════════════════════════════════════

class TimelineComplication {
  const TimelineComplication({
    required this.name,
    required this.description,
    required this.onsetDay,
    required this.peakDay,
    required this.resolutionDay,
    required this.color,
    required this.icon,
    required this.boardPearl,
  });

  final String name;
  final String description;
  final double onsetDay;
  final double peakDay;
  final double resolutionDay;
  final Color color;
  final IconData icon;
  final String boardPearl;
}

// ════════════════════════════════════════════════════════════════
// Complication Data (real clinical timing)
// ════════════════════════════════════════════════════════════════

class ComplicationData {
  static const List<TimelineComplication> complications = [
    TimelineComplication(
      name: 'Cerebral Edema',
      description:
          'Cytotoxic and vasogenic edema causing increased ICP. '
          'Peak swelling typically at 48-72 hours post-injury.',
      onsetDay: 0,
      peakDay: 4,
      resolutionDay: 10,
      color: Color(0xFFF87171),
      icon: Icons.warning_rounded,
      boardPearl:
          'Cerebral edema peaks at 3-5 days post-TBI. ICP monitoring is '
          'indicated for GCS <=8 with abnormal CT. Target ICP <22 mmHg '
          'and CPP 60-70 mmHg. Osmolar therapy (mannitol or hypertonic '
          'saline) is first-line for acute ICP crises.',
    ),
    TimelineComplication(
      name: 'Early Post-Traumatic Seizures',
      description:
          'Seizures occurring within 7 days of injury. Risk factors: '
          'GCS <10, cortical contusion, depressed skull fracture, SDH, '
          'EDH, penetrating injury.',
      onsetDay: 0,
      peakDay: 2,
      resolutionDay: 7,
      color: Color(0xFFFBBF24),
      icon: Icons.flash_on_rounded,
      boardPearl:
          'Seizure prophylaxis with levetiracetam or phenytoin is '
          'recommended for 7 days post-severe TBI (BTF guidelines). '
          'Early seizures do NOT predict late epilepsy. Phenytoin and '
          'levetiracetam are equally effective for early seizure prevention.',
    ),
    TimelineComplication(
      name: 'Paroxysmal Sympathetic Hyperactivity',
      description:
          'Episodic tachycardia, hypertension, tachypnea, diaphoresis, '
          'posturing, and hyperthermia. Previously called "sympathetic '
          'storming." Seen in severe DAI.',
      onsetDay: 5,
      peakDay: 10,
      resolutionDay: 28,
      color: Color(0xFFE879F9),
      icon: Icons.monitor_heart_rounded,
      boardPearl:
          'PSH is diagnosed using the PSH-Assessment Measure (PSH-AM). '
          'Treatment ladder: remove noxious stimuli first, then gabapentin, '
          'propranolol, bromocriptine, and opioids. Dantrolene for severe '
          'posturing. Benzodiazepines can worsen cognitive recovery.',
    ),
    TimelineComplication(
      name: 'SIADH / Cerebral Salt Wasting',
      description:
          'Hyponatremia from SIADH (euvolemic, fluid restrict) or CSW '
          '(hypovolemic, salt replace). Both cause Na <135, but volume '
          'status differs.',
      onsetDay: 3,
      peakDay: 8,
      resolutionDay: 21,
      color: Color(0xFF60A5FA),
      icon: Icons.water_drop_rounded,
      boardPearl:
          'Key distinction: SIADH = euvolemic/hypervolemic, low urine output, '
          'treat with fluid restriction. CSW = hypovolemic, high urine output, '
          'treat with isotonic or hypertonic saline replacement. Both cause '
          'concentrated urine and low serum Na. Check volume status and urine Na.',
    ),
    TimelineComplication(
      name: 'DVT / Pulmonary Embolism',
      description:
          'Venous thromboembolism from immobility, hypercoagulable state, '
          'and endothelial injury. PE is a leading cause of preventable '
          'death in TBI.',
      onsetDay: 3,
      peakDay: 10,
      resolutionDay: 90,
      color: Color(0xFFEF4444),
      icon: Icons.bloodtype_rounded,
      boardPearl:
          'Chemical DVT prophylaxis (LMWH or UFH) should start within '
          '24-72 hours if hemorrhage is stable on repeat CT. Mechanical '
          'prophylaxis (SCDs) from admission. Screen with duplex ultrasound '
          'if high risk. IVC filter only when anticoagulation is absolutely '
          'contraindicated.',
    ),
    TimelineComplication(
      name: 'Late Post-Traumatic Seizures',
      description:
          'Seizures occurring >7 days post-injury. Represents post-traumatic '
          'epilepsy. Risk increases with penetrating injury, SDH, and '
          'early seizures in some populations.',
      onsetDay: 7,
      peakDay: 30,
      resolutionDay: 180,
      color: Color(0xFFFB923C),
      icon: Icons.flash_on_rounded,
      boardPearl:
          'Anticonvulsant prophylaxis beyond 7 days is NOT recommended '
          '(does not prevent epileptogenesis). If PTE develops, treat with '
          'standard AEDs (levetiracetam, lamotrigine, lacosamide preferred '
          'for fewer cognitive side effects). Risk of PTE: 2% mild, 5% '
          'moderate, 10-15% severe, 50% penetrating TBI.',
    ),
    TimelineComplication(
      name: 'Heterotopic Ossification',
      description:
          'Abnormal bone formation in periarticular soft tissues, '
          'most commonly hip, elbow, shoulder, and knee. Causes pain '
          'and decreased ROM.',
      onsetDay: 28,
      peakDay: 75,
      resolutionDay: 180,
      color: Color(0xFF2DD4BF),
      icon: Icons.accessibility_new_rounded,
      boardPearl:
          'HO screen with triple-phase bone scan (most sensitive early) or '
          'alkaline phosphatase. X-ray lags 4-6 weeks. Prophylaxis: '
          'indomethacin or etidronate in high-risk patients. Surgical '
          'excision only after maturation (18-24 months). Aggressive ROM '
          'does NOT cause HO but maintain gentle stretching.',
    ),
    TimelineComplication(
      name: 'Posttraumatic Hydrocephalus',
      description:
          'Communicating hydrocephalus from impaired CSF reabsorption. '
          'Presents as declining cognition, gait apraxia, and urinary '
          'incontinence (Hakim triad).',
      onsetDay: 14,
      peakDay: 35,
      resolutionDay: 120,
      color: Color(0xFF818CF8),
      icon: Icons.water_rounded,
      boardPearl:
          'Suspect PTH when a patient reaches a plateau then declines. '
          'Ventriculomegaly out of proportion to atrophy on CT/MRI. '
          'High-volume LP (30-50 mL) is both diagnostic and therapeutic -- '
          'if the patient improves, VP shunt is indicated. Risk factors: '
          'SAH, IVH, decompressive craniectomy.',
    ),
    TimelineComplication(
      name: 'Neuroendocrine Dysfunction',
      description:
          'Pituitary dysfunction affecting GH, gonadotropins, ACTH, '
          'and/or TSH. Often under-recognized. Screen at 3 and 12 months.',
      onsetDay: 30,
      peakDay: 90,
      resolutionDay: 180,
      color: Color(0xFFC084FC),
      icon: Icons.biotech_rounded,
      boardPearl:
          'Pituitary dysfunction occurs in 25-50% of moderate-severe TBI. '
          'GH deficiency is most common, followed by gonadotropin deficiency. '
          'Screen with AM cortisol, TSH/free T4, testosterone/estradiol, '
          'IGF-1, and prolactin. GH stimulation testing is the gold standard '
          'for GH deficiency. Treat adrenal insufficiency before thyroid.',
    ),
    TimelineComplication(
      name: 'Spasticity',
      description:
          'Velocity-dependent increase in muscle tone from upper motor '
          'neuron injury. Interferes with function, positioning, hygiene, '
          'and causes pain.',
      onsetDay: 7,
      peakDay: 60,
      resolutionDay: 180,
      color: Color(0xFF38BDF8),
      icon: Icons.fitness_center_rounded,
      boardPearl:
          'Treat spasticity only when it is functionally limiting -- some '
          'tone is beneficial (standing, transfers). Treatment ladder: '
          'stretching/positioning, oral agents (tizanidine, baclofen, '
          'dantrolene), botulinum toxin for focal spasticity, intrathecal '
          'baclofen for diffuse spasticity. Avoid benzodiazepines (sedation, '
          'cognitive impairment).',
    ),
  ];
}

// ════════════════════════════════════════════════════════════════
// Timeline Scrubber Widget
// ════════════════════════════════════════════════════════════════

class ComplicationTimeline extends StatefulWidget {
  const ComplicationTimeline({super.key});

  @override
  State<ComplicationTimeline> createState() => _ComplicationTimelineState();
}

class _ComplicationTimelineState extends State<ComplicationTimeline>
    with TickerProviderStateMixin {
  // The total range is 0 to 180 days (6 months)
  static const double _maxDays = 180;

  double _currentDay = 0;
  int? _expandedIndex;
  bool _autoPlaying = false;

  late AnimationController _autoPlayController;
  late AnimationController _cardFadeController;

  @override
  void initState() {
    super.initState();
    _autoPlayController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addListener(() {
        setState(() {
          _currentDay = _autoPlayController.value * _maxDays;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _autoPlaying = false);
        }
      });

    _cardFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _autoPlayController.dispose();
    _cardFadeController.dispose();
    super.dispose();
  }

  void _toggleAutoPlay() {
    setState(() {
      if (_autoPlaying) {
        _autoPlayController.stop();
        _autoPlaying = false;
      } else {
        _autoPlaying = true;
        if (_currentDay >= _maxDays - 1) {
          _currentDay = 0;
          _autoPlayController.forward(from: 0);
        } else {
          _autoPlayController.forward(from: _currentDay / _maxDays);
        }
      }
    });
  }

  /// Returns an opacity 0-1 for how "active" a complication is at the current day.
  double _activityLevel(TimelineComplication c) {
    if (_currentDay < c.onsetDay || _currentDay > c.resolutionDay) return 0;

    if (_currentDay <= c.peakDay) {
      // Fade in from onset to peak
      final range = c.peakDay - c.onsetDay;
      if (range <= 0) return 1.0;
      return ((_currentDay - c.onsetDay) / range).clamp(0.0, 1.0);
    } else {
      // Fade out from peak to resolution
      final range = c.resolutionDay - c.peakDay;
      if (range <= 0) return 1.0;
      return (1.0 - ((_currentDay - c.peakDay) / range)).clamp(0.0, 1.0);
    }
  }

  String _dayLabel(double day) {
    if (day < 1) return 'Day 0';
    if (day < 7) return 'Day ${day.round()}';
    if (day < 14) return 'Week 1, Day ${(day - 7).round()}';
    if (day < 30) return 'Week ${(day / 7).floor()}';
    if (day < 60) return 'Month 1';
    if (day < 90) return 'Month 2';
    if (day < 120) return 'Month 3';
    if (day < 150) return 'Month 4';
    return 'Month ${(day / 30).floor()}';
  }

  @override
  Widget build(BuildContext context) {
    // Sort complications by activity level (most active on top)
    final activeComplications = <_ActiveComplication>[];
    for (int i = 0; i < ComplicationData.complications.length; i++) {
      final c = ComplicationData.complications[i];
      final level = _activityLevel(c);
      if (level > 0.01) {
        activeComplications.add(_ActiveComplication(
          index: i,
          complication: c,
          activityLevel: level,
        ));
      }
    }
    activeComplications.sort((a, b) => b.activityLevel.compareTo(a.activityLevel));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Complication Timeline'),
        backgroundColor: AppTheme.background,
        actions: [
          IconButton(
            onPressed: _toggleAutoPlay,
            icon: Icon(
              _autoPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: AppTheme.primaryCyan,
            ),
            tooltip: _autoPlaying ? 'Pause' : 'Auto-play',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Current time label
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      _dayLabel(_currentDay),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryCyan,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${activeComplications.length} active complication${activeComplications.length == 1 ? '' : 's'}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Complication cards
            Expanded(
              child: activeComplications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timeline_rounded,
                            size: 48,
                            color: AppTheme.textSecondary.withValues(alpha: 0.4),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _currentDay < 0.5
                                ? 'Drag the timeline to begin'
                                : 'No active complications at this time point',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: activeComplications.length,
                      itemBuilder: (context, index) {
                        final ac = activeComplications[index];
                        final isExpanded = _expandedIndex == ac.index;
                        return _ComplicationCard(
                          complication: ac.complication,
                          activityLevel: ac.activityLevel,
                          isExpanded: isExpanded,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _expandedIndex =
                                  isExpanded ? null : ac.index;
                            });
                          },
                        );
                      },
                    ),
            ),

            // Timeline scrubber
            _buildTimeline(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(
            color: AppTheme.border.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Activity heat strip
          SizedBox(
            height: 20,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, 20),
                  painter: _TimelineHeatPainter(
                    complications: ComplicationData.complications,
                    maxDays: _maxDays,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 4),

          // Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppTheme.primaryCyan.withValues(alpha: 0.6),
              inactiveTrackColor: AppTheme.border,
              thumbColor: AppTheme.primaryCyan,
              overlayColor: AppTheme.primaryCyan.withValues(alpha: 0.15),
              trackHeight: 4,
              thumbShape: const _GlowThumbShape(thumbRadius: 12),
            ),
            child: Slider(
              value: _currentDay,
              min: 0,
              max: _maxDays,
              onChanged: (v) {
                if (_autoPlaying) {
                  _autoPlayController.stop();
                  _autoPlaying = false;
                }
                setState(() => _currentDay = v);
              },
            ),
          ),

          // Time labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _TimeLabel('Day 0'),
                _TimeLabel('Wk 1'),
                _TimeLabel('Wk 2'),
                _TimeLabel('Mo 1'),
                _TimeLabel('Mo 2'),
                _TimeLabel('Mo 3'),
                _TimeLabel('Mo 6'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Supporting Widgets
// ════════════════════════════════════════════════════════════════

class _ActiveComplication {
  const _ActiveComplication({
    required this.index,
    required this.complication,
    required this.activityLevel,
  });

  final int index;
  final TimelineComplication complication;
  final double activityLevel;
}

class _ComplicationCard extends StatelessWidget {
  const _ComplicationCard({
    required this.complication,
    required this.activityLevel,
    required this.isExpanded,
    required this.onTap,
  });

  final TimelineComplication complication;
  final double activityLevel;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final glowAlpha = (activityLevel * 0.3).clamp(0.0, 0.3);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: (0.3 + activityLevel * 0.7).clamp(0.0, 1.0),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border(
              left: BorderSide(
                color: complication.color,
                width: 4,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: complication.color.withValues(alpha: glowAlpha),
                blurRadius: activityLevel * 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    complication.icon,
                    color: complication.color,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      complication.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  // Activity indicator
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: complication.color.withValues(
                        alpha: activityLevel,
                      ),
                      boxShadow: activityLevel > 0.7
                          ? [
                              BoxShadow(
                                color: complication.color.withValues(alpha: 0.5),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                complication.description,
                maxLines: isExpanded ? 10 : 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                  height: 1.5,
                ),
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
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
                          complication.boardPearl,
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
                const SizedBox(height: 8),
                // Timing bar
                Row(
                  children: [
                    const Icon(Icons.schedule_rounded,
                        size: 14, color: AppTheme.textSecondary),
                    const SizedBox(width: 6),
                    Text(
                      'Onset: Day ${complication.onsetDay.round()}  |  '
                      'Peak: Day ${complication.peakDay.round()}  |  '
                      'Resolves: Day ${complication.resolutionDay.round()}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeLabel extends StatelessWidget {
  const _TimeLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppTheme.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Custom Thumb Shape with Glow
// ════════════════════════════════════════════════════════════════

class _GlowThumbShape extends SliderComponentShape {
  const _GlowThumbShape({required this.thumbRadius});

  final double thumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final color = sliderTheme.thumbColor ?? AppTheme.primaryCyan;

    // Outer glow
    canvas.drawCircle(
      center,
      thumbRadius + 4,
      Paint()
        ..color = color.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Main circle
    canvas.drawCircle(
      center,
      thumbRadius - 2,
      Paint()..color = color,
    );

    // Inner highlight
    canvas.drawCircle(
      center,
      thumbRadius - 6,
      Paint()..color = Colors.white.withValues(alpha: 0.3),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Heat-Map Painter (shows density of complications over time)
// ════════════════════════════════════════════════════════════════

class _TimelineHeatPainter extends CustomPainter {
  _TimelineHeatPainter({
    required this.complications,
    required this.maxDays,
  });

  final List<TimelineComplication> complications;
  final double maxDays;

  @override
  void paint(Canvas canvas, Size size) {
    const int segments = 90;
    final segW = size.width / segments;

    for (int i = 0; i < segments; i++) {
      final day = (i / segments) * maxDays;
      double totalActivity = 0;
      Color blendedColor = Colors.transparent;
      int activeCount = 0;

      for (final c in complications) {
        if (day < c.onsetDay || day > c.resolutionDay) continue;

        double level;
        if (day <= c.peakDay) {
          final range = c.peakDay - c.onsetDay;
          level = range <= 0 ? 1.0 : ((day - c.onsetDay) / range).clamp(0.0, 1.0);
        } else {
          final range = c.resolutionDay - c.peakDay;
          level = range <= 0 ? 1.0 : (1.0 - ((day - c.peakDay) / range)).clamp(0.0, 1.0);
        }

        if (level > 0.01) {
          totalActivity += level;
          blendedColor = Color.lerp(blendedColor, c.color, 0.3) ?? c.color;
          activeCount++;
        }
      }

      if (activeCount > 0) {
        final intensity = (totalActivity / 3).clamp(0.0, 1.0);
        canvas.drawRect(
          Rect.fromLTWH(i * segW, 0, segW + 1, size.height),
          Paint()
            ..color = blendedColor.withValues(alpha: intensity * 0.5),
        );
      }
    }

    // Rounded clip border
    final borderPaint = Paint()
      ..color = AppTheme.border.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(4),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimelineHeatPainter oldDelegate) => false;
}
