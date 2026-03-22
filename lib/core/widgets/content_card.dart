import 'package:flutter/material.dart';
import '../../data/models/module_model.dart';
import '../../core/theme/app_theme.dart';

class ContentCard extends StatelessWidget {
  final ModuleModel module;
  final int index;
  final VoidCallback onTap;

  const ContentCard({
    super.key,
    required this.module,
    required this.index,
    required this.onTap,
  });

  Color get _moduleColor {
    const colors = [
      AppTheme.fundamentalsColor,
      AppTheme.pathophysColor,
      AppTheme.classificationColor,
      AppTheme.imagingColor,
      AppTheme.acuteColor,
      AppTheme.docColor,
      AppTheme.complicationsColor,
      AppTheme.pharmacologyColor,
      AppTheme.agitationColor,
      AppTheme.spasticityColor,
      AppTheme.neuroendocrineColor,
      AppTheme.concussionColor,
      AppTheme.pediatricColor,
      AppTheme.rehabColor,
    ];
    return colors[index % colors.length];
  }

  IconData get _moduleIcon {
    const icons = [
      Icons.menu_book_rounded,
      Icons.psychology_rounded,
      Icons.assessment_rounded,
      Icons.image_search_rounded,
      Icons.local_hospital_rounded,
      Icons.visibility_rounded,
      Icons.warning_amber_rounded,
      Icons.medication_rounded,
      Icons.emoji_people_rounded,
      Icons.accessibility_new_rounded,
      Icons.science_rounded,
      Icons.sports_football_rounded,
      Icons.child_care_rounded,
      Icons.trending_up_rounded,
    ];
    return icons[index % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _moduleColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: color.withValues(alpha: 0.12),
          highlightColor: color.withValues(alpha: 0.06),
          child: Ink(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.border.withValues(alpha: 0.6),
                width: 1,
              ),
              boxShadow: [
                // Subtle color glow
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
                // Depth shadow
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  // Left accent strip
                  Container(
                    width: 5,
                    height: 130,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          color,
                          color.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                  // Icon container
                  Container(
                    width: 68,
                    height: 130,
                    alignment: Alignment.center,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: color.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        _moduleIcon,
                        color: color,
                        size: 24,
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Module number label
                          Text(
                            'MODULE ${index + 1}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: color,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Title
                          Text(
                            module.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Description
                          Text(
                            module.description,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Highlight chips
                          if (module.highlights.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children:
                                  module.highlights.take(3).map((highlight) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: color.withValues(alpha: 0.15),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Text(
                                    highlight,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: color.withValues(alpha: 0.9),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  // Arrow
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: color.withValues(alpha: 0.4),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
