import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/anatomy/hemorrhage_layers.dart';
import '../../../data/models/anatomy_3d_model.dart';
import '../../../data/models/anatomy_layer_model.dart';
import '../../../data/models/infographic_model.dart';
import 'anatomy_layer_viewer.dart';
import 'infographic_viewer.dart';
import 'sketchfab_viewer.dart';

/// Gallery screen showing all anatomy-related visual resources.
///
/// Three tabs:
///   1. **3D Models** -- Sketchfab brain models
///   2. **Diagrams** -- Infographics in the anatomy category
///   3. **Layers** -- Interactive layer diagrams (e.g. hemorrhage types)
class AnatomyGalleryView extends StatelessWidget {
  /// Optional module filter. When null, all modules are shown.
  final String? moduleId;

  const AnatomyGalleryView({super.key, this.moduleId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          backgroundColor: AppTheme.background,
          title: const Text('3D Anatomy'),
          bottom: TabBar(
            indicatorColor: AppTheme.primaryCyan,
            indicatorWeight: 3,
            labelColor: AppTheme.primaryCyan,
            unselectedLabelColor: AppTheme.textSecondary,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: '3D Models'),
              Tab(text: 'Diagrams'),
              Tab(text: 'Layers'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ModelsTab(moduleId: moduleId),
            _DiagramsTab(moduleId: moduleId),
            _LayersTab(moduleId: moduleId),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Tab 1 -- 3D Models
// ════════════════════════════════════════════════

class _ModelsTab extends StatelessWidget {
  final String? moduleId;
  const _ModelsTab({this.moduleId});

  @override
  Widget build(BuildContext context) {
    final models = moduleId != null
        ? Anatomy3DData.getByModule(moduleId!)
        : Anatomy3DData.all;

    if (models.isEmpty) {
      return const _EmptyState(message: 'No 3D models for this module');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: models.length,
      itemBuilder: (context, index) {
        final model = models[index];
        return _Anatomy3DCard(
          model: model,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SketchfabViewer(model: model),
            ),
          ),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════
// Tab 2 -- Diagrams (anatomy infographics)
// ════════════════════════════════════════════════

class _DiagramsTab extends StatelessWidget {
  final String? moduleId;
  const _DiagramsTab({this.moduleId});

  @override
  Widget build(BuildContext context) {
    List<Infographic> items =
        InfographicData.getByCategory(InfographicCategory.anatomy);
    if (moduleId != null) {
      items = items.where((i) => i.moduleId == moduleId).toList();
    }

    if (items.isEmpty) {
      return const _EmptyState(message: 'No anatomy diagrams available');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _DiagramCard(
          infographic: item,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => InfographicViewer(infographic: item),
            ),
          ),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════
// Tab 3 -- Interactive Layers
// ════════════════════════════════════════════════

class _LayersTab extends StatelessWidget {
  final String? moduleId;
  const _LayersTab({this.moduleId});

  /// Available interactive layer diagrams.
  List<AnatomyDiagram> get _diagrams {
    final all = [hemorrhageLayersDiagram];
    if (moduleId == null) return all;
    return all.where((d) => d.id.contains(moduleId!)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final diagrams = _diagrams;

    if (diagrams.isEmpty && moduleId != null) {
      // Show all when module filter yields nothing
      return _buildList(context, [hemorrhageLayersDiagram]);
    }
    if (diagrams.isEmpty) {
      return const _EmptyState(message: 'No interactive layers available');
    }

    return _buildList(context, diagrams);
  }

  Widget _buildList(BuildContext context, List<AnatomyDiagram> diagrams) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: diagrams.length,
      itemBuilder: (context, index) {
        final diagram = diagrams[index];
        return _LayerCard(
          diagram: diagram,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AnatomyLayerViewer(diagram: diagram),
            ),
          ),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════
// Cards
// ════════════════════════════════════════════════

/// Card for a 3D Sketchfab model.
class _Anatomy3DCard extends StatelessWidget {
  final Anatomy3DModel model;
  final VoidCallback onTap;

  const _Anatomy3DCard({required this.model, required this.onTap});

  Color get _accentColor {
    switch (model.moduleId) {
      case 'pathophysiology':
        return AppTheme.pathophysColor;
      case 'neuroimaging':
        return AppTheme.imagingColor;
      case 'acute-management':
        return AppTheme.acuteColor;
      case 'disorders-of-consciousness':
        return AppTheme.docColor;
      case 'concussion-mtbi':
        return AppTheme.concussionColor;
      default:
        return AppTheme.primaryCyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _accentColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: icon + title
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Icon(Icons.view_in_ar_rounded,
                      color: color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3D MODEL',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        model.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: color.withValues(alpha: 0.5),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Topic chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: model.relevantTopics
                  .take(3)
                  .map((topic) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: color.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          topic,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: color.withValues(alpha: 0.9),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card for an anatomy infographic diagram.
class _DiagramCard extends StatelessWidget {
  final Infographic infographic;
  final VoidCallback onTap;

  const _DiagramCard({required this.infographic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const color = AppTheme.dangerRed;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Icon(infographic.icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ANATOMY DIAGRAM',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    infographic.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    infographic.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: color.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card for an interactive layer diagram.
class _LayerCard extends StatelessWidget {
  final AnatomyDiagram diagram;
  final VoidCallback onTap;

  const _LayerCard({required this.diagram, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const color = AppTheme.secondaryAmber;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: const Icon(Icons.layers_rounded,
                  color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INTERACTIVE LAYERS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    diagram.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    diagram.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: color.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Empty state
// ════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final String message;
  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.view_in_ar_rounded,
            size: 48,
            color: AppTheme.textSecondary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
