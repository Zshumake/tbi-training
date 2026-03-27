import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/anatomy/hemorrhage_layers.dart';
import '../../../data/models/infographic_model.dart';
import 'anatomy_layer_viewer.dart';

class InfographicViewer extends StatelessWidget {
  final Infographic infographic;

  const InfographicViewer({super.key, required this.infographic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: Text(infographic.title),
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: infographic.assetPath.endsWith('.svg')
                ? SvgPicture.asset(
                    infographic.assetPath,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    infographic.assetPath,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
    );
  }
}

class InfographicGallery extends StatelessWidget {
  final String? moduleId;
  final InfographicCategory? category;
  final String title;

  const InfographicGallery({
    super.key,
    this.moduleId,
    this.category,
    this.title = 'Infographics',
  });

  List<Infographic> get _infographics {
    if (moduleId != null) return InfographicData.getByModule(moduleId!);
    if (category != null) return InfographicData.getByCategory(category!);
    return InfographicData.all;
  }

  /// IDs of infographics that have an interactive layer view available.
  static const _layerViewIds = {'hemorrhage-types'};

  void _onInfographicTap(BuildContext context, Infographic item) {
    if (_layerViewIds.contains(item.id)) {
      _showViewChoiceSheet(context, item);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InfographicViewer(infographic: item),
        ),
      );
    }
  }

  void _showViewChoiceSheet(BuildContext context, Infographic item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppTheme.surfaceElevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.textSecondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Choose a view mode',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                // Static SVG option
                _ViewChoiceTile(
                  icon: Icons.image_rounded,
                  color: AppTheme.primaryCyan,
                  title: 'Static Diagram',
                  subtitle: 'View the full SVG infographic',
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            InfographicViewer(infographic: item),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // Interactive layer option
                _ViewChoiceTile(
                  icon: Icons.layers_rounded,
                  color: AppTheme.secondaryAmber,
                  title: 'Interactive Layers',
                  subtitle:
                      'Peel away anatomy layers with annotations',
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AnatomyLayerViewer(
                          diagram: hemorrhageLayersDiagram,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _infographics;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: Text(title),
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                'No infographics available',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _InfographicCard(
                  infographic: item,
                  onTap: () => _onInfographicTap(context, item),
                );
              },
            ),
    );
  }
}

class _InfographicCard extends StatelessWidget {
  final Infographic infographic;
  final VoidCallback onTap;

  const _InfographicCard({required this.infographic, required this.onTap});

  Color get _categoryColor {
    switch (infographic.category) {
      case InfographicCategory.flowchart:
        return AppTheme.accent;
      case InfographicCategory.anatomy:
        return AppTheme.dangerRed;
      case InfographicCategory.summary:
        return AppTheme.accentAmber;
    }
  }

  String get _categoryLabel {
    switch (infographic.category) {
      case InfographicCategory.flowchart:
        return 'ALGORITHM';
      case InfographicCategory.anatomy:
        return 'ANATOMY';
      case InfographicCategory.summary:
        return 'SUMMARY';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _categoryColor.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: _categoryColor.withValues(alpha: 0.08),
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
                color: _categoryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _categoryColor.withValues(alpha: 0.3)),
              ),
              child: Icon(infographic.icon, color: _categoryColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _categoryLabel,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: _categoryColor,
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
              color: _categoryColor.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewChoiceTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ViewChoiceTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: color.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
