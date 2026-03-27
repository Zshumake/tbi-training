import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';

// =============================================================================
// Data Model
// =============================================================================

class _CascadeStage {
  const _CascadeStage({
    required this.name,
    required this.icon,
    required this.description,
    this.interventions = const [],
  });

  final String name;
  final IconData icon;
  final String description;
  final List<_Intervention> interventions;
}

class _Intervention {
  const _Intervention({
    required this.name,
    required this.mechanism,
    required this.target,
  });

  final String name;
  final String mechanism;
  final String target;
}

// =============================================================================
// Static Data
// =============================================================================

const List<_CascadeStage> _stages = [
  _CascadeStage(
    name: 'Mechanical Impact',
    icon: Icons.flash_on_rounded,
    description:
        'Primary injury: shearing forces tear axons, contusion of cortical '
        'tissue, and vascular disruption causes hemorrhage. This damage is '
        'immediate and irreversible at the moment of impact.',
  ),
  _CascadeStage(
    name: 'Ionic Flux',
    icon: Icons.bolt_rounded,
    description:
        'Massive neuronal depolarization triggers K+ efflux and Na+/Ca2+ '
        'influx through mechanically disrupted channels. Indiscriminate '
        'neurotransmitter release overwhelms synaptic machinery.',
    interventions: [
      _Intervention(
        name: 'Magnesium Sulfate',
        mechanism: 'NMDA receptor blockade limits Ca2+ influx',
        target: 'Ionic flux phase',
      ),
    ],
  ),
  _CascadeStage(
    name: 'Glutamate Excitotoxicity',
    icon: Icons.warning_rounded,
    description:
        'Excessive glutamate activates NMDA and AMPA receptors, causing '
        'unregulated Ca2+ influx. Sustained depolarization spreads injury '
        'to previously uninjured neurons in the penumbra.',
    interventions: [
      _Intervention(
        name: 'Amantadine',
        mechanism: 'Weak NMDA antagonist; reduces excitotoxic signaling',
        target: 'Glutamate cascade',
      ),
    ],
  ),
  _CascadeStage(
    name: 'Mitochondrial Failure',
    icon: Icons.battery_alert_rounded,
    description:
        'Intracellular Ca2+ overload damages mitochondrial membranes. ATP '
        'production collapses, Na+/K+-ATPase fails, and oxidative stress '
        'accelerates. The cell enters an energy crisis.',
    interventions: [
      _Intervention(
        name: 'Osmotic Therapy',
        mechanism:
            'Mannitol / hypertonic saline reduces cerebral edema and ICP',
        target: 'Cellular swelling from ATP failure',
      ),
    ],
  ),
  _CascadeStage(
    name: 'Free Radical Damage',
    icon: Icons.whatshot_rounded,
    description:
        'Reactive oxygen species (ROS) attack cell membranes via lipid '
        'peroxidation, damage DNA strands, and denature proteins. The '
        'antioxidant defense system is overwhelmed.',
    interventions: [
      _Intervention(
        name: 'Therapeutic Hypothermia',
        mechanism: 'Lowers metabolic rate, reduces ROS generation',
        target: 'Free radical production',
      ),
      _Intervention(
        name: 'Progesterone (investigational)',
        mechanism: 'Membrane stabilization, reduces oxidative stress',
        target: 'Lipid peroxidation',
      ),
    ],
  ),
  _CascadeStage(
    name: 'Neuroinflammation',
    icon: Icons.healing_rounded,
    description:
        'Microglial activation (M1 pro-inflammatory phenotype) releases '
        'cytokines (TNF-alpha, IL-1beta, IL-6). Blood-brain barrier '
        'breakdown causes vasogenic edema. Cytokine storm propagates injury.',
    interventions: [
      _Intervention(
        name: 'Decompressive Craniectomy',
        mechanism: 'Removes bone flap to allow brain expansion, lowers ICP',
        target: 'Refractory cerebral edema',
      ),
    ],
  ),
  _CascadeStage(
    name: 'Cell Death',
    icon: Icons.dangerous_rounded,
    description:
        'Apoptosis (programmed cell death via caspase activation) and '
        'necrosis converge. Wallerian degeneration of damaged axons. '
        'Initiates chronic neurodegeneration pathway (tau, TDP-43).',
  ),
];

// =============================================================================
// Main Widget
// =============================================================================

class InjuryCascadeView extends StatefulWidget {
  const InjuryCascadeView({super.key});

  @override
  State<InjuryCascadeView> createState() => _InjuryCascadeViewState();
}

class _InjuryCascadeViewState extends State<InjuryCascadeView>
    with TickerProviderStateMixin {
  int _currentStage = 0;
  bool _isPlaying = false;
  bool _showInterventions = false;
  Timer? _autoAdvanceTimer;

  // Glow animation for the active node
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  // Pulse animation for the energy wave
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _glowController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= _stages.length) return;
    HapticFeedback.selectionClick();
    setState(() => _currentStage = index);
  }

  void _restart() {
    _stopAutoPlay();
    _goTo(0);
  }

  void _next() {
    if (_currentStage < _stages.length - 1) _goTo(_currentStage + 1);
  }

  void _previous() {
    if (_currentStage > 0) _goTo(_currentStage - 1);
  }

  void _togglePlay() {
    HapticFeedback.selectionClick();
    if (_isPlaying) {
      _stopAutoPlay();
    } else {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    setState(() => _isPlaying = true);
    _autoAdvanceTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_currentStage < _stages.length - 1) {
        _goTo(_currentStage + 1);
      } else {
        _stopAutoPlay();
      }
    });
  }

  void _stopAutoPlay() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
    if (mounted) setState(() => _isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: const Text('Secondary Injury Cascade'),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Interventions',
                style: TextStyle(
                  fontSize: 12,
                  color: _showInterventions
                      ? AppTheme.successGreen
                      : AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: _showInterventions,
                onChanged: (v) => setState(() => _showInterventions = v),
                activeTrackColor: AppTheme.successGreen,
                inactiveThumbColor: AppTheme.textSecondary,
                inactiveTrackColor: AppTheme.border,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          _buildProgressBar(),
          // Cascade chain
          Expanded(child: _buildCascadeList()),
          // Controls
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            'Stage ${_currentStage + 1} of ${_stages.length}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_currentStage + 1) / _stages.length,
                backgroundColor: AppTheme.border,
                valueColor:
                    const AlwaysStoppedAnimation(AppTheme.primaryCyan),
                minHeight: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCascadeList() {
    return AnimatedBuilder(
      animation: Listenable.merge([_glowAnimation, _pulseController]),
      builder: (context, _) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          itemCount: _stages.length,
          itemBuilder: (context, index) {
            final stage = _stages[index];
            final isActive = index == _currentStage;
            final isCompleted = index < _currentStage;
            final isFuture = index > _currentStage;

            return Column(
              children: [
                // Connector line above (except first)
                if (index > 0)
                  _buildConnector(
                    completed: index <= _currentStage,
                    isActive: index == _currentStage,
                  ),
                // Stage node
                _buildStageNode(
                  stage: stage,
                  index: index,
                  isActive: isActive,
                  isCompleted: isCompleted,
                  isFuture: isFuture,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildConnector({required bool completed, required bool isActive}) {
    return SizedBox(
      height: 28,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: 3,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: completed
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.primaryCyan,
                      isActive
                          ? AppTheme.primaryCyan
                              .withValues(alpha: _glowAnimation.value)
                          : AppTheme.primaryCyan,
                    ],
                  )
                : null,
            color: completed ? null : AppTheme.border,
            boxShadow: completed
                ? [
                    BoxShadow(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                      blurRadius: 6,
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildStageNode({
    required _CascadeStage stage,
    required int index,
    required bool isActive,
    required bool isCompleted,
    required bool isFuture,
  }) {
    final nodeOpacity = isFuture ? 0.25 : 1.0;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: nodeOpacity,
      child: GestureDetector(
        onTap: isFuture ? null : () => _goTo(index),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main card
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.surfaceElevated
                      : AppTheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isActive
                        ? AppTheme.primaryCyan
                            .withValues(alpha: _glowAnimation.value)
                        : isCompleted
                            ? AppTheme.primaryCyan.withValues(alpha: 0.3)
                            : AppTheme.border,
                    width: isActive ? 1.5 : 1,
                  ),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryCyan.withValues(
                                alpha: _glowAnimation.value * 0.2),
                            blurRadius: 16,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Icon container
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppTheme.primaryCyan.withValues(alpha: 0.15)
                                : isCompleted
                                    ? AppTheme.primaryCyan
                                        .withValues(alpha: 0.08)
                                    : AppTheme.border.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            isCompleted && !isActive
                                ? Icons.check_circle_rounded
                                : stage.icon,
                            color: isActive
                                ? AppTheme.primaryCyan
                                : isCompleted
                                    ? AppTheme.primaryCyan
                                        .withValues(alpha: 0.7)
                                    : AppTheme.textSecondary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'STAGE ${index + 1}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: isActive
                                      ? AppTheme.primaryCyan
                                      : AppTheme.textSecondary,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                stage.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: isActive
                                      ? AppTheme.textPrimary
                                      : AppTheme.textPrimary
                                          .withValues(alpha: 0.8),
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Expanded description for active stage
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          stage.description,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                            height: 1.55,
                          ),
                        ),
                      ),
                      crossFadeState: isActive
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 350),
                    ),
                    // Intervention cards (inside main card)
                    if (_showInterventions &&
                        isActive &&
                        stage.interventions.isNotEmpty)
                      ...stage.interventions.map(
                        (intv) => _buildInterventionCard(intv),
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

  Widget _buildInterventionCard(_Intervention intv) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.successGreen.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.successGreen.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services_rounded,
                size: 16,
                color: AppTheme.successGreen.withValues(alpha: 0.9),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  intv.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.successGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            intv.mechanism,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary.withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Target: ${intv.target}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.successGreen.withValues(alpha: 0.7),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    final atStart = _currentStage == 0;
    final atEnd = _currentStage == _stages.length - 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated.withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ControlButton(
              icon: Icons.skip_previous_rounded,
              label: 'Restart',
              onTap: atStart ? null : _restart,
            ),
            _ControlButton(
              icon: Icons.chevron_left_rounded,
              label: 'Back',
              onTap: atStart ? null : _previous,
            ),
            _ControlButton(
              icon: _isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              label: _isPlaying ? 'Pause' : 'Play',
              primary: true,
              onTap: atEnd && !_isPlaying ? null : _togglePlay,
            ),
            _ControlButton(
              icon: Icons.chevron_right_rounded,
              label: 'Next',
              onTap: atEnd ? null : _next,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Control Button
// =============================================================================

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.primary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final color = enabled
        ? (primary ? AppTheme.primaryCyan : AppTheme.textPrimary)
        : AppTheme.textSecondary.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: primary && enabled
                    ? AppTheme.primaryCyan.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: primary && enabled
                    ? Border.all(
                        color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
