import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../core/services/progress_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/quiz_model.dart';
import '../../core/widgets/quiz_session_view.dart';
import '../../data/models/flashcard_model.dart';
import '../../data/models/infographic_model.dart';
import '../../data/models/module_model.dart';
import '../../data/models/podcast_model.dart';
import '../../data/models/topic_content_model.dart';
import '../../data/module_contents/acute_management_content.dart';
import '../../data/module_contents/agitation_content.dart';
import '../../data/module_contents/classification_severity_content.dart';
import '../../data/module_contents/concussion_content.dart';
import '../../data/module_contents/doc_content.dart';
import '../../data/module_contents/medical_complications_content.dart';
import '../../data/module_contents/neuroendocrine_content.dart';
import '../../data/module_contents/neuroimaging_content.dart';
import '../../data/module_contents/pathophysiology_content.dart';
import '../../data/module_contents/pediatric_geriatric_content.dart';
import '../../data/module_contents/pharmacology_content.dart';
import '../../data/module_contents/rehab_continuum_content.dart';
import '../../data/module_contents/spasticity_content.dart';
import '../../data/module_contents/tbi_fundamentals_content.dart';
import '../../data/quiz_banks/all_flashcard_banks.dart';
import '../../data/quiz_banks/all_quiz_banks.dart';
import 'topic_content_view.dart';
import 'widgets/flashcard_view.dart';
import 'widgets/infographic_viewer.dart';

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

  /// Returns the flashcard deck for this module, or null if none exists.
  List<Flashcard>? _getFlashcards() {
    switch (module.id) {
      case 'tbi-fundamentals':
        return NotebookLMFundamentalsFlashcards.cards;
      case 'pathophysiology':
        return NotebookLMPathophysFlashcards.cards;
      case 'classification-severity':
        return NotebookLMClassificationFlashcards.cards;
      case 'neuroimaging':
        return NotebookLMNeuroimagingFlashcards.cards;
      case 'acute-management':
        return NotebookLMAcuteMgmtFlashcards.cards;
      case 'disorders-of-consciousness':
        return NotebookLMDOCFlashcards.cards;
      case 'medical-complications':
        return NotebookLMComplicationsFlashcards.cards;
      case 'pharmacology':
        return NotebookLMPharmacologyFlashcards.cards;
      case 'agitation-behavioral':
        return NotebookLMAgitationFlashcards.cards;
      case 'spasticity-motor':
        return NotebookLMSpasticityFlashcards.cards;
      case 'neuroendocrine':
        return NotebookLMNeuroendocrineFlashcards.cards;
      case 'pediatric-geriatric':
        return NotebookLMPediatricGeriatricFlashcards.cards;
      case 'rehab-continuum':
        return NotebookLMRehabContinuumFlashcards.cards;
      default:
        return null;
    }
  }

  /// Returns the podcast episode for this module, or null if none exists.
  PodcastEpisode? _getPodcastEpisode() {
    try {
      return PodcastData.episodes.firstWhere(
        (ep) => ep.moduleId == module.id,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ProgressService.markModuleVisited(module.id);
    final topicData = _getTopicData();
    final moduleColor = _getModuleColor();
    final quizQuestions = TBIQuizBank.getQuestionsForModule(module.id);
    final flashcards = _getFlashcards();
    final podcastEpisode = _getPodcastEpisode();
    final infographics = InfographicData.getByModule(module.id);

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
      body: Column(
        children: [
          Expanded(
            child: topicData != null
                ? TopicContentView(topicData: topicData)
                : _buildComingSoon(moduleColor),
          ),
          _ModuleActionBar(
            moduleColor: moduleColor,
            moduleTitle: module.title,
            quizQuestions: quizQuestions,
            flashcards: flashcards,
            podcastEpisode: podcastEpisode,
            infographics: infographics,
          ),
        ],
      ),
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

// =============================================================================
// Glass-morphism bottom action bar
// =============================================================================

class _ModuleActionBar extends StatelessWidget {
  const _ModuleActionBar({
    required this.moduleColor,
    required this.moduleTitle,
    required this.quizQuestions,
    required this.flashcards,
    required this.podcastEpisode,
    required this.infographics,
  });

  final Color moduleColor;
  final String moduleTitle;
  final List<QuizQuestion> quizQuestions;
  final List<Flashcard>? flashcards;
  final PodcastEpisode? podcastEpisode;
  final List<Infographic> infographics;

  @override
  Widget build(BuildContext context) {
    final hasQuiz = quizQuestions.isNotEmpty;
    final hasFlashcards = flashcards != null && flashcards!.isNotEmpty;
    final hasPodcast = podcastEpisode != null;
    final hasVisuals = infographics.isNotEmpty;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppTheme.surfaceElevated.withValues(alpha: 0.9),
            border: const Border(
              top: BorderSide(color: AppTheme.border, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                icon: Icons.quiz_rounded,
                label: 'Quiz',
                color: moduleColor,
                enabled: hasQuiz,
                onTap: () => _openQuiz(context),
              ),
              _ActionButton(
                icon: Icons.style_rounded,
                label: 'Flashcards',
                color: moduleColor,
                enabled: hasFlashcards,
                onTap: () => _openFlashcards(context),
              ),
              _ActionButton(
                icon: Icons.headset_rounded,
                label: 'Podcast',
                color: moduleColor,
                enabled: hasPodcast,
                onTap: () => _playPodcast(context),
              ),
              _ActionButton(
                icon: Icons.image_rounded,
                label: 'Visuals',
                color: moduleColor,
                enabled: hasVisuals,
                onTap: () => _openVisuals(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizSessionView(
          questions: List.from(quizQuestions),
          title: '$moduleTitle Quiz',
        ),
      ),
    );
  }

  void _openFlashcards(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FlashcardView(
          cards: flashcards!,
          title: '$moduleTitle Flashcards',
        ),
      ),
    );
  }

  void _playPodcast(BuildContext context) async {
    final player = AudioPlayer();
    try {
      await player.setAsset(podcastEpisode!.assetPath);
      await player.play();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Now playing: ${podcastEpisode!.title}'),
            backgroundColor: AppTheme.surfaceElevated,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not play podcast: $e'),
            backgroundColor: AppTheme.dangerRed,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _openVisuals(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InfographicGallery(
          moduleId: infographics.first.moduleId,
          title: '$moduleTitle Visuals',
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor =
        enabled ? color : AppTheme.textSecondary.withValues(alpha: 0.3);
    final textColor =
        enabled ? color : AppTheme.textSecondary.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
