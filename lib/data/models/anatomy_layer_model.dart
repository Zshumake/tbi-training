import 'package:flutter/material.dart';

/// Represents a complete layered anatomy diagram with multiple
/// peelable layers and their associated annotations.
class AnatomyDiagram {
  final String id;
  final String title;
  final String description;
  final List<AnatomyLayer> layers;
  final List<BoardPearl> boardPearls;

  const AnatomyDiagram({
    required this.id,
    required this.title,
    required this.description,
    required this.layers,
    this.boardPearls = const [],
  });
}

/// A single anatomical layer in the diagram, drawn as a concentric
/// shape that the user can reveal or hide.
class AnatomyLayer {
  /// Display name, e.g., "Skull", "Dura Mater"
  final String name;

  /// Clinical significance text
  final String description;

  /// Tint color for the layer ellipse
  final Color color;

  /// Annotation pins placed on this layer
  final List<LayerAnnotation> annotations;

  /// Stacking order: 0 = outermost, higher = deeper
  final int order;

  const AnatomyLayer({
    required this.name,
    required this.description,
    required this.color,
    required this.order,
    this.annotations = const [],
  });
}

/// A pin on a layer that shows clinical detail when tapped.
class LayerAnnotation {
  /// Short label shown beside the dot
  final String label;

  /// Expanded detail text
  final String detail;

  /// Relative X position (0.0 - 1.0)
  final double x;

  /// Relative Y position (0.0 - 1.0)
  final double y;

  const LayerAnnotation({
    required this.label,
    required this.detail,
    required this.x,
    required this.y,
  });
}

/// A board-relevant pearl that appears when specific layers
/// are visible together, enabling comparison teaching.
class BoardPearl {
  /// Which layer orders must be visible for this pearl to show
  final List<int> requiredVisibleLayers;

  /// Pearl title
  final String title;

  /// Pearl content
  final String content;

  const BoardPearl({
    required this.requiredVisibleLayers,
    required this.title,
    required this.content,
  });
}
