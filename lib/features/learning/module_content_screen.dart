import 'package:flutter/material.dart';
import '../../data/models/module_model.dart';
import '../../data/module_contents/tbi_fundamentals_content.dart';
import '../../data/module_contents/pathophysiology_content.dart';
import '../../data/module_contents/classification_severity_content.dart';
import '../../data/module_contents/neuroimaging_content.dart';
import '../../data/module_contents/acute_management_content.dart';
import '../../data/module_contents/doc_content.dart';
import '../../data/module_contents/medical_complications_content.dart';
import '../../data/module_contents/pharmacology_content.dart';
import '../../data/module_contents/agitation_content.dart';
import '../../data/module_contents/spasticity_content.dart';
import '../../data/module_contents/neuroendocrine_content.dart';
import '../../data/module_contents/concussion_content.dart';
import '../../data/module_contents/pediatric_geriatric_content.dart';
import '../../data/module_contents/rehab_continuum_content.dart';
import 'topic_content_view.dart';
import '../../data/models/topic_content_model.dart';
import '../../core/theme/app_theme.dart';

class ModuleContentScreen extends StatelessWidget {
  final ModuleModel module;

  const ModuleContentScreen({super.key, required this.module});

  TopicData? _getTopicData() {
    switch (module.id) {
      case 'tbi-fundamentals':
        return tbiFundamentalsContent;
      case 'pathophysiology':
        return pathophysiologyContent;
      case 'classification-severity':
        return classificationSeverityContent;
      case 'neuroimaging':
        return neuroimagingContent;
      case 'acute-management':
        return acuteManagementContent;
      case 'disorders-of-consciousness':
        return docContent;
      case 'medical-complications':
        return medicalComplicationsContent;
      case 'pharmacology':
        return pharmacologyContent;
      case 'agitation-behavioral':
        return agitationContent;
      case 'spasticity-motor':
        return spasticityContent;
      case 'neuroendocrine':
        return neuroendocrineContent;
      case 'concussion-mtbi':
        return concussionContent;
      case 'pediatric-geriatric':
        return pediatricGeriatricContent;
      case 'rehab-continuum':
        return rehabContinuumContent;
      default:
        return null;
    }
  }

  Color _getModuleColor() {
    switch (module.id) {
      case 'tbi-fundamentals':
        return AppTheme.fundamentalsColor;
      case 'pathophysiology':
        return AppTheme.pathophysColor;
      case 'classification-severity':
        return AppTheme.classificationColor;
      case 'neuroimaging':
        return AppTheme.imagingColor;
      case 'acute-management':
        return AppTheme.acuteColor;
      case 'disorders-of-consciousness':
        return AppTheme.docColor;
      case 'medical-complications':
        return AppTheme.complicationsColor;
      case 'pharmacology':
        return AppTheme.pharmacologyColor;
      case 'agitation-behavioral':
        return AppTheme.agitationColor;
      case 'spasticity-motor':
        return AppTheme.spasticityColor;
      case 'neuroendocrine':
        return AppTheme.neuroendocrineColor;
      case 'concussion-mtbi':
        return AppTheme.concussionColor;
      case 'pediatric-geriatric':
        return AppTheme.pediatricColor;
      case 'rehab-continuum':
        return AppTheme.rehabColor;
      default:
        return AppTheme.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topicData = _getTopicData();
    final moduleColor = _getModuleColor();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: Text(module.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  moduleColor.withValues(alpha: 0.0),
                  moduleColor,
                  moduleColor.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
      ),
      body: topicData != null
          ? TopicContentView(topicData: topicData)
          : _buildComingSoon(moduleColor),
    );
  }

  Widget _buildComingSoon(Color moduleColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction_rounded,
              size: 64,
              color: moduleColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              module.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Content coming soon!',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              module.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
