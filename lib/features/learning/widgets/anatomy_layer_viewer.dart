import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/anatomy_layer_model.dart';

/// Interactive anatomy layer viewer that lets users peel away
/// concentric anatomical layers, revealing structures and
/// annotations progressively.
class AnatomyLayerViewer extends StatefulWidget {
  final AnatomyDiagram diagram;

  const AnatomyLayerViewer({super.key, required this.diagram});

  @override
  State<AnatomyLayerViewer> createState() => _AnatomyLayerViewerState();
}

class _AnatomyLayerViewerState extends State<AnatomyLayerViewer>
    with TickerProviderStateMixin {
  /// Which layers are currently visible, keyed by layer order.
  late Map<int, bool> _layerVisibility;

  /// Animation controllers for each layer, keyed by layer order.
  late Map<int, AnimationController> _layerAnimations;

  /// The currently selected layer (for description card).
  int? _selectedLayerOrder;

  /// The currently tapped annotation (for tooltip).
  LayerAnnotation? _activeAnnotation;

  /// Pulsing animation for annotation dots.
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    final layers = widget.diagram.layers;
    _layerVisibility = {for (final l in layers) l.order: true};
    _layerAnimations = {
      for (final l in layers)
        l.order: AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
          value: 1.0, // start fully visible
        ),
    };

    // Default to outermost layer selected
    if (layers.isNotEmpty) {
      _selectedLayerOrder = layers
          .reduce((a, b) => a.order < b.order ? a : b)
          .order;
    }

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    for (final c in _layerAnimations.values) {
      c.dispose();
    }
    _pulseController.dispose();
    super.dispose();
  }

  List<AnatomyLayer> get _sortedLayers {
    final layers = List<AnatomyLayer>.from(widget.diagram.layers);
    layers.sort((a, b) => a.order.compareTo(b.order));
    return layers;
  }

  void _toggleLayer(int order) {
    final current = _layerVisibility[order] ?? false;
    setState(() {
      _layerVisibility[order] = !current;
      _selectedLayerOrder = order;
      _activeAnnotation = null;
    });

    final controller = _layerAnimations[order];
    if (controller == null) return;

    if (current) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  void _peelOutermostLayer() {
    // Find outermost visible layer and hide it
    final sorted = _sortedLayers;
    for (final layer in sorted) {
      if (_layerVisibility[layer.order] == true) {
        _toggleLayer(layer.order);
        return;
      }
    }
  }

  void _revealAllLayers() {
    setState(() {
      for (final key in _layerVisibility.keys) {
        _layerVisibility[key] = true;
      }
      _activeAnnotation = null;
    });
    for (final c in _layerAnimations.values) {
      c.forward();
    }
  }

  AnatomyLayer? get _selectedLayer {
    if (_selectedLayerOrder == null) return null;
    try {
      return widget.diagram.layers
          .firstWhere((l) => l.order == _selectedLayerOrder);
    } catch (_) {
      return null;
    }
  }

  /// Returns the most specific board pearl whose required layers are
  /// all currently visible.
  BoardPearl? get _activePearl {
    final visibleOrders = _layerVisibility.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toSet();

    BoardPearl? best;
    int bestSpecificity = -1;

    for (final pearl in widget.diagram.boardPearls) {
      final required = pearl.requiredVisibleLayers.toSet();
      if (required.every(visibleOrders.contains)) {
        // Prefer more-specific pearls (more required layers)
        if (required.length > bestSpecificity) {
          bestSpecificity = required.length;
          best = pearl;
        }
      }
    }
    return best;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: Text(widget.diagram.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers_rounded),
            tooltip: 'Reveal all layers',
            onPressed: _revealAllLayers,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main diagram area
            Expanded(
              child: Row(
                children: [
                  // Diagram
                  Expanded(
                    child: GestureDetector(
                      onTap: _peelOutermostLayer,
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Center(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return _DiagramCanvas(
                                layers: _sortedLayers,
                                visibility: _layerVisibility,
                                animations: _layerAnimations,
                                selectedOrder: _selectedLayerOrder,
                                pulseAnimation: _pulseAnimation,
                                activeAnnotation: _activeAnnotation,
                                onAnnotationTap: (annotation) {
                                  setState(() {
                                    _activeAnnotation =
                                        _activeAnnotation == annotation
                                            ? null
                                            : annotation;
                                  });
                                },
                                constraints: constraints,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Layer stepper on right
                  _LayerStepper(
                    layers: _sortedLayers,
                    visibility: _layerVisibility,
                    selectedOrder: _selectedLayerOrder,
                    onLayerTap: _toggleLayer,
                  ),
                ],
              ),
            ),
            // Annotation tooltip
            if (_activeAnnotation != null) _AnnotationTooltip(
              annotation: _activeAnnotation!,
              onDismiss: () => setState(() => _activeAnnotation = null),
            ),
            // Bottom info card
            _BottomInfoCard(
              layer: _selectedLayer,
              pearl: _activePearl,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Diagram Canvas — draws concentric ellipses via CustomPainter
// ─────────────────────────────────────────────────────────────

class _DiagramCanvas extends StatelessWidget {
  final List<AnatomyLayer> layers;
  final Map<int, bool> visibility;
  final Map<int, AnimationController> animations;
  final int? selectedOrder;
  final Animation<double> pulseAnimation;
  final LayerAnnotation? activeAnnotation;
  final ValueChanged<LayerAnnotation> onAnnotationTap;
  final BoxConstraints constraints;

  const _DiagramCanvas({
    required this.layers,
    required this.visibility,
    required this.animations,
    required this.selectedOrder,
    required this.pulseAnimation,
    required this.activeAnnotation,
    required this.onAnnotationTap,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final size = math.min(constraints.maxWidth - 32, constraints.maxHeight - 32);
    final canvasSize = math.max(size, 200.0);

    return SizedBox(
      width: canvasSize,
      height: canvasSize,
      child: Stack(
        children: [
          // Paint the ellipses
          ...layers.reversed.map((layer) {
            final controller = animations[layer.order];
            if (controller == null) return const SizedBox.shrink();

            return AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final value = controller.value;
                if (value == 0) return const SizedBox.shrink();

                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.95 + 0.05 * value,
                    child: CustomPaint(
                      size: Size(canvasSize, canvasSize),
                      painter: _LayerEllipsePainter(
                        layer: layer,
                        totalLayers: layers.length,
                        isSelected: layer.order == selectedOrder,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          // Annotation dots for visible layers
          ...layers.expand((layer) {
            final isVisible = visibility[layer.order] == true;
            if (!isVisible) return <Widget>[];

            return layer.annotations.map((annotation) {
              final dx = annotation.x * canvasSize;
              final dy = annotation.y * canvasSize;

              return Positioned(
                left: dx - 10,
                top: dy - 10,
                child: AnimatedBuilder(
                  animation: pulseAnimation,
                  builder: (context, child) {
                    final isActive = activeAnnotation == annotation;
                    return GestureDetector(
                      onTap: () => onAnnotationTap(annotation),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? layer.color
                              : layer.color.withValues(
                                  alpha: pulseAnimation.value * 0.6,
                                ),
                          border: Border.all(
                            color: layer.color,
                            width: isActive ? 2.0 : 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: layer.color.withValues(
                                alpha: pulseAnimation.value * 0.4,
                              ),
                              blurRadius: isActive ? 8 : 4,
                            ),
                          ],
                        ),
                        child: isActive
                            ? const Icon(
                                Icons.close,
                                size: 10,
                                color: AppTheme.background,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              );
            });
          }),
          // Center label
          Positioned.fill(
            child: Center(
              child: IgnorePointer(
                child: Text(
                  'Tap to peel layers',
                  style: TextStyle(
                    color: AppTheme.textSecondary.withValues(alpha: 0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Custom painter for a single layer ellipse
// ─────────────────────────────────────────────────────────────

class _LayerEllipsePainter extends CustomPainter {
  final AnatomyLayer layer;
  final int totalLayers;
  final bool isSelected;

  _LayerEllipsePainter({
    required this.layer,
    required this.totalLayers,
    required this.isSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Each deeper layer is slightly smaller
    final fraction = 1.0 - (layer.order / (totalLayers + 1)) * 0.6;
    final rx = size.width / 2 * fraction * 0.9;
    final ry = size.height / 2 * fraction * 0.9;

    final rect = Rect.fromCenter(center: center, width: rx * 2, height: ry * 2);

    // Fill
    final fillPaint = Paint()
      ..color = layer.color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    canvas.drawOval(rect, fillPaint);

    // Stroke
    final strokePaint = Paint()
      ..color = isSelected
          ? layer.color
          : layer.color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSelected ? 2.5 : 1.5;
    canvas.drawOval(rect, strokePaint);

    // Layer name along the top of the ellipse
    final textPainter = TextPainter(
      text: TextSpan(
        text: layer.name,
        style: TextStyle(
          color: layer.color.withValues(alpha: isSelected ? 1.0 : 0.7),
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - ry - 16),
    );
  }

  @override
  bool shouldRepaint(_LayerEllipsePainter oldDelegate) =>
      oldDelegate.isSelected != isSelected ||
      oldDelegate.layer.order != layer.order;
}

// ─────────────────────────────────────────────────────────────
// Layer stepper — vertical list of layer names on the right
// ─────────────────────────────────────────────────────────────

class _LayerStepper extends StatelessWidget {
  final List<AnatomyLayer> layers;
  final Map<int, bool> visibility;
  final int? selectedOrder;
  final ValueChanged<int> onLayerTap;

  const _LayerStepper({
    required this.layers,
    required this.visibility,
    required this.selectedOrder,
    required this.onLayerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          // "Layers" label
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'LAYERS',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...layers.map((layer) {
            final isVisible = visibility[layer.order] == true;
            final isSelected = layer.order == selectedOrder;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Tooltip(
                message: layer.name,
                preferBelow: false,
                child: GestureDetector(
                  onTap: () => onLayerTap(layer.order),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isVisible
                          ? layer.color.withValues(alpha: 0.2)
                          : AppTheme.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? layer.color
                            : isVisible
                                ? layer.color.withValues(alpha: 0.4)
                                : AppTheme.border,
                        width: isSelected ? 2.0 : 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${layer.order}',
                        style: TextStyle(
                          color: isVisible
                              ? layer.color
                              : AppTheme.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Annotation tooltip — slides up when an annotation is tapped
// ─────────────────────────────────────────────────────────────

class _AnnotationTooltip extends StatelessWidget {
  final LayerAnnotation annotation;
  final VoidCallback onDismiss;

  const _AnnotationTooltip({
    required this.annotation,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryCyan.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.push_pin_rounded,
                    size: 14, color: AppTheme.primaryCyan),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    annotation.label,
                    style: const TextStyle(
                      color: AppTheme.primaryCyan,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(Icons.close, size: 16,
                      color: AppTheme.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              annotation.detail,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Bottom info card — current layer description + board pearl
// ─────────────────────────────────────────────────────────────

class _BottomInfoCard extends StatelessWidget {
  final AnatomyLayer? layer;
  final BoardPearl? pearl;

  const _BottomInfoCard({
    required this.layer,
    required this.pearl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(color: AppTheme.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Layer info
          if (layer != null) ...[
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: layer!.color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  layer!.name,
                  style: TextStyle(
                    color: layer!.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              layer!.description,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
          // Board pearl
          if (pearl != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.pearlBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppTheme.pearlBorder.withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_rounded,
                          size: 14, color: AppTheme.secondaryAmber),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          pearl!.title,
                          style: const TextStyle(
                            color: AppTheme.secondaryAmber,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pearl!.content,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
