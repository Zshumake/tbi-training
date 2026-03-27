import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import '../../core/services/progress_service.dart';
import '../../data/module_data.dart';
import '../../data/quiz_banks/all_quiz_banks.dart';
import '../../data/quiz_banks/all_flashcard_banks.dart';
import '../../data/models/podcast_model.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/content_card.dart';
import '../../core/widgets/quiz_session_view.dart';
import '../../data/models/flashcard_model.dart';
import 'widgets/flashcard_view.dart';
import 'widgets/infographic_viewer.dart';
import '../../data/models/infographic_model.dart';
import '../../data/models/anatomy_3d_model.dart';
import '../../data/scenarios/icp_crisis_scenario.dart';
import 'widgets/anatomy_gallery_view.dart';
import 'widgets/clinical_simulator_view.dart';
import 'widgets/complication_timeline.dart';
import 'widgets/ct_label_challenge.dart';
import 'widgets/gcs_builder_view.dart';
import 'widgets/injury_cascade_view.dart';
import 'widgets/med_matching_view.dart';
import 'widgets/pattern_recognition_view.dart';
import '../../core/services/srs_service.dart';
import 'module_content_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final AnimationController _staggerController;
  late final AnimationController _breathController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    // Glow accent animation (continuous)
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Breathing ambient background animation (continuous)
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Stagger entrance animation
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();
  }

  @override
  void dispose() {
    _glowController.dispose();
    _breathController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modules = ModuleData.standardModules;
    final totalQuestions = TBIQuizBank.allQuestions.length;
    const totalDecks = 13;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Hero Header ──
          SliverAppBar(
            expandedHeight: Responsive.value<double>(
              context,
              phone: 240,
              tablet: 200,
              desktop: 180,
            ),
            pinned: true,
            backgroundColor: AppTheme.background,
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroHeader(
                moduleCount: modules.length,
                questionCount: totalQuestions,
                deckCount: totalDecks,
                glowAnimation: _glowAnimation,
                breathAnimation: _breathController,
              ),
              title: Text(
                'TBI Training',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: Responsive.value<double>(
                    context,
                    phone: 18,
                    tablet: 20,
                    desktop: 22,
                  ),
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),

          // ── Quick Actions Row ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                Responsive.contentPadding(context).left,
                16,
                Responsive.isPhone(context) ? 0 : Responsive.contentPadding(context).right,
                0,
              ),
              child: Responsive.isPhone(context)
                  ? SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildQuickActionCards(context, totalDecks),
                      ),
                    )
                  : Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _buildQuickActionCards(context, totalDecks),
                    ),
            ),
          ),

          // ── Section Header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCyan,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryCyan.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'LEARNING PATHWAY',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textSecondary.withValues(alpha: 0.9),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Module Cards with stagger ──
          SliverPadding(
            padding: Responsive.contentPadding(context),
            sliver: _buildModuleSliver(context, modules),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // ── Module grid/list sliver ──
  Widget _buildModuleSliver(BuildContext context, List modules) {
    final columns = Responsive.gridColumns(context);

    Widget buildCard(int index) {
      final module = modules[index];
      final startFraction = (index * 0.06).clamp(0.0, 0.7);
      final endFraction = (startFraction + 0.3).clamp(0.0, 1.0);
      final animation = CurvedAnimation(
        parent: _staggerController,
        curve: Interval(startFraction, endFraction, curve: Curves.easeOutCubic),
      );

      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 30 * (1 - animation.value)),
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          );
        },
        child: ContentCard(
          module: module,
          index: index,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModuleContentScreen(module: module),
              ),
            );
          },
        ),
      );
    }

    if (columns == 1) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => buildCard(index),
          childCount: modules.length,
        ),
      );
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.8,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => buildCard(index),
        childCount: modules.length,
      ),
    );
  }

  // ── Quick Action Cards builder ──
  List<Widget> _buildQuickActionCards(BuildContext context, int totalDecks) {
    return [
      _QuickActionCard(
        icon: Icons.quiz_rounded,
        label: 'Board Quiz',
        sublabel: '10 random Qs',
        color: AppTheme.primaryCyan,
        onTap: () {
          final questions = TBIQuizBank.getRandomQuiz(10);
          if (questions.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizSessionView(
                  questions: questions,
                  title: 'Board Review Quiz',
                ),
              ),
            );
          }
        },
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.style_rounded,
        label: 'Flashcards',
        sublabel: '$totalDecks decks',
        color: AppTheme.secondaryAmber,
        onTap: () => _showFlashcardPicker(context),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.headset_rounded,
        label: 'Podcasts',
        sublabel: '${PodcastData.episodes.length} episodes',
        color: AppTheme.pathophysColor,
        onTap: () => _showPodcastPicker(context),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.image_rounded,
        label: 'Infographics',
        sublabel: '${InfographicData.all.length} visuals',
        color: AppTheme.concussionColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const InfographicGallery(title: 'All Infographics'),
          ),
        ),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.emergency_rounded,
        label: 'Clinical Sim',
        sublabel: 'ICP Crisis',
        color: AppTheme.acuteColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ClinicalSimulatorView(
              scenario: ICPCrisisScenario.scenario,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.view_in_ar_rounded,
        label: '3D Anatomy',
        sublabel: '${Anatomy3DData.all.length} models',
        color: AppTheme.imagingColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AnatomyGalleryView(),
          ),
        ),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.bolt_rounded,
        label: 'Injury Cascade',
        sublabel: '7-stage animation',
        color: AppTheme.pathophysColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const InjuryCascadeView(),
          ),
        ),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.psychology_alt_rounded,
        label: 'Pattern Dx',
        sublabel: '6 cases',
        color: AppTheme.agitationColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PatternRecognitionView(),
          ),
        ),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.calculate_rounded,
        label: 'GCS Builder',
        sublabel: '5 cases',
        color: AppTheme.classificationColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const GCSBuilderView(),
          ),
        ),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.medication_rounded,
        label: 'Med Matching',
        sublabel: '3 rounds',
        color: AppTheme.pharmacologyColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MedMatchingView(),
          ),
        ),
      ),
      const SizedBox(width: 12),
      _DailyReviewCard(
        onTap: (dueItems) => _launchDailyReview(context, dueItems),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.radar_rounded,
        label: 'CT Challenge',
        sublabel: '3 cases',
        color: AppTheme.imagingColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CTLabelChallenge(),
          ),
        ),
      ),
      const SizedBox(width: 12),
      _QuickActionCard(
        icon: Icons.timeline_rounded,
        label: 'Complications',
        sublabel: 'Timeline scrub',
        color: AppTheme.complicationsColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ComplicationTimeline(),
          ),
        ),
      ),
      if (Responsive.isPhone(context)) const SizedBox(width: 16),
    ];
  }

  void _launchDailyReview(BuildContext context, List<String> dueItemIds) {
    // Convert due item IDs back to flashcards
    final allCards = <Flashcard>[
      ...NotebookLMAcuteMgmtFlashcards.cards,
      ...NotebookLMPathophysFlashcards.cards,
      ...NotebookLMClassificationFlashcards.cards,
      ...NotebookLMFundamentalsFlashcards.cards,
      ...NotebookLMNeuroimagingFlashcards.cards,
      ...NotebookLMDOCFlashcards.cards,
      ...NotebookLMComplicationsFlashcards.cards,
      ...NotebookLMPharmacologyFlashcards.cards,
      ...NotebookLMAgitationFlashcards.cards,
      ...NotebookLMSpasticityFlashcards.cards,
      ...NotebookLMNeuroendocrineFlashcards.cards,
      ...NotebookLMPediatricGeriatricFlashcards.cards,
      ...NotebookLMRehabContinuumFlashcards.cards,
    ];

    // Match due item IDs to flashcards by front text hash
    final dueCards = <Flashcard>[];
    final dueSet = dueItemIds.toSet();
    for (final card in allCards) {
      final id = 'fc_${card.front.hashCode}';
      if (dueSet.contains(id)) {
        dueCards.add(card);
      }
    }

    if (dueCards.isEmpty) return;
    dueCards.shuffle();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FlashcardView(
          cards: dueCards,
          title: 'Daily Review (${dueCards.length} due)',
        ),
      ),
    );
  }

  int _totalFlashcardCount() {
    return NotebookLMAcuteMgmtFlashcards.cards.length +
        NotebookLMPathophysFlashcards.cards.length +
        NotebookLMClassificationFlashcards.cards.length +
        NotebookLMFundamentalsFlashcards.cards.length +
        NotebookLMNeuroimagingFlashcards.cards.length +
        NotebookLMDOCFlashcards.cards.length +
        NotebookLMComplicationsFlashcards.cards.length +
        NotebookLMPharmacologyFlashcards.cards.length +
        NotebookLMAgitationFlashcards.cards.length +
        NotebookLMSpasticityFlashcards.cards.length +
        NotebookLMNeuroendocrineFlashcards.cards.length +
        NotebookLMPediatricGeriatricFlashcards.cards.length +
        NotebookLMRehabContinuumFlashcards.cards.length;
  }

  // ── Bottom Sheet: Flashcard Picker ──
  void _showFlashcardPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceElevated,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Choose Flashcard Deck (${_totalFlashcardCount()} cards total)',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              // Shuffle All Decks tile
              _FlashcardDeckTile(
                icon: Icons.shuffle_rounded,
                color: AppTheme.primaryCyan,
                title: 'Shuffle All Decks',
                count: _totalFlashcardCount(),
                onTap: () {
                  Navigator.pop(ctx);
                  final allCards = <Flashcard>[
                    ...NotebookLMAcuteMgmtFlashcards.cards,
                    ...NotebookLMPathophysFlashcards.cards,
                    ...NotebookLMClassificationFlashcards.cards,
                    ...NotebookLMFundamentalsFlashcards.cards,
                    ...NotebookLMNeuroimagingFlashcards.cards,
                    ...NotebookLMDOCFlashcards.cards,
                    ...NotebookLMComplicationsFlashcards.cards,
                    ...NotebookLMPharmacologyFlashcards.cards,
                    ...NotebookLMAgitationFlashcards.cards,
                    ...NotebookLMSpasticityFlashcards.cards,
                    ...NotebookLMNeuroendocrineFlashcards.cards,
                    ...NotebookLMPediatricGeriatricFlashcards.cards,
                    ...NotebookLMRehabContinuumFlashcards.cards,
                  ]..shuffle();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: allCards,
                        title: 'All Decks (Shuffled)',
                      ),
                    ),
                  );
                },
              ),
              const Divider(color: AppTheme.border, height: 1),
              const SizedBox(height: 8),
              _FlashcardDeckTile(
                icon: Icons.local_hospital_rounded,
                color: AppTheme.acuteColor,
                title: 'Acute Management',
                count: NotebookLMAcuteMgmtFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMAcuteMgmtFlashcards.cards,
                        title: 'Acute Management Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.psychology_rounded,
                color: AppTheme.pathophysColor,
                title: 'Pathophysiology',
                count: NotebookLMPathophysFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMPathophysFlashcards.cards,
                        title: 'Pathophysiology Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.assessment_rounded,
                color: AppTheme.classificationColor,
                title: 'Classification & Severity',
                count: NotebookLMClassificationFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMClassificationFlashcards.cards,
                        title: 'Classification Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.menu_book_rounded,
                color: AppTheme.fundamentalsColor,
                title: 'TBI Fundamentals',
                count: NotebookLMFundamentalsFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMFundamentalsFlashcards.cards,
                        title: 'TBI Fundamentals Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.image_search_rounded,
                color: AppTheme.imagingColor,
                title: 'Neuroimaging',
                count: NotebookLMNeuroimagingFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMNeuroimagingFlashcards.cards,
                        title: 'Neuroimaging Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.visibility_rounded,
                color: AppTheme.docColor,
                title: 'Disorders of Consciousness',
                count: NotebookLMDOCFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMDOCFlashcards.cards,
                        title: 'Disorders of Consciousness Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.healing_rounded,
                color: AppTheme.complicationsColor,
                title: 'Medical Complications',
                count: NotebookLMComplicationsFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMComplicationsFlashcards.cards,
                        title: 'Medical Complications Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.medication_rounded,
                color: AppTheme.pharmacologyColor,
                title: 'Pharmacology',
                count: NotebookLMPharmacologyFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMPharmacologyFlashcards.cards,
                        title: 'Pharmacology Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.warning_amber_rounded,
                color: AppTheme.agitationColor,
                title: 'Agitation & Behavioral',
                count: NotebookLMAgitationFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMAgitationFlashcards.cards,
                        title: 'Agitation & Behavioral Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.accessibility_new_rounded,
                color: AppTheme.spasticityColor,
                title: 'Spasticity & Motor',
                count: NotebookLMSpasticityFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMSpasticityFlashcards.cards,
                        title: 'Spasticity & Motor Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.bloodtype_rounded,
                color: AppTheme.neuroendocrineColor,
                title: 'Neuroendocrine',
                count: NotebookLMNeuroendocrineFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMNeuroendocrineFlashcards.cards,
                        title: 'Neuroendocrine Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.child_care_rounded,
                color: AppTheme.pediatricColor,
                title: 'Pediatric & Geriatric',
                count: NotebookLMPediatricGeriatricFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMPediatricGeriatricFlashcards.cards,
                        title: 'Pediatric & Geriatric Flashcards',
                      ),
                    ),
                  );
                },
              ),
              _FlashcardDeckTile(
                icon: Icons.route_rounded,
                color: AppTheme.rehabColor,
                title: 'Rehabilitation Continuum',
                count: NotebookLMRehabContinuumFlashcards.cards.length,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardView(
                        cards: NotebookLMRehabContinuumFlashcards.cards,
                        title: 'Rehabilitation Continuum Flashcards',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ── Bottom Sheet: Podcast Picker ──
  void _showPodcastPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceElevated,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Podcast',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              ...PodcastData.episodes.map(
                (ep) => ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.headset_rounded,
                      color: AppTheme.primaryCyan,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    ep.title,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final player = AudioPlayer();
                    await player.setAsset(ep.assetPath);
                    await player.play();
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Hero Header with gradient mesh
// ════════════════════════════════════════════════

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.moduleCount,
    required this.questionCount,
    required this.deckCount,
    required this.glowAnimation,
    required this.breathAnimation,
  });

  final int moduleCount;
  final int questionCount;
  final int deckCount;
  final Animation<double> glowAnimation;
  final Animation<double> breathAnimation;

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning, Doctor';
    if (hour < 17) return 'Good Afternoon, Doctor';
    return 'Good Evening, Doctor';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Gradient mesh background with breathing animation
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: breathAnimation,
            builder: (context, _) {
              return CustomPaint(
                painter: _MeshGradientPainter(breathPhase: breathAnimation.value),
              );
            },
          ),
        ),
        // Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time-of-day greeting
                Text(
                  _greeting(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Builder(builder: (context) {
                  return Text(
                    'TBI Training',
                    style: TextStyle(
                      fontSize: Responsive.value<double>(
                        context,
                        phone: 28,
                        tablet: 32,
                        desktop: 36,
                      ),
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textPrimary,
                      letterSpacing: -1.5,
                      height: 1.1,
                    ),
                  );
                }),
                const SizedBox(height: 4),
                // Animated glow line
                AnimatedBuilder(
                  animation: glowAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 60,
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppTheme.primaryCyan
                            .withValues(alpha: glowAnimation.value),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryCyan
                                .withValues(alpha: glowAnimation.value * 0.6),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  'Traumatic Brain Injury Board Review',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textSecondary.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 14),
                // Stats row - glass chips with gamification
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _GlassChip(
                        label: '$moduleCount Modules',
                        color: AppTheme.primaryCyan,
                      ),
                      const SizedBox(width: 8),
                      _GlassChip(
                        label: '$questionCount Questions',
                        color: AppTheme.secondaryAmber,
                      ),
                      const SizedBox(width: 8),
                      _GlassChip(
                        label: '$deckCount Decks',
                        color: AppTheme.successGreen,
                      ),
                      const SizedBox(width: 8),
                      const _StreakChip(),
                      const SizedBox(width: 8),
                      const _XPChip(),
                      const SizedBox(width: 8),
                      _ProgressRingChip(
                        studied: ProgressService.visitedModules.length,
                        total: moduleCount,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════
// Mesh Gradient Painter (dark blues / teals)
// ════════════════════════════════════════════════

class _MeshGradientPainter extends CustomPainter {
  _MeshGradientPainter({this.breathPhase = 0.0});

  final double breathPhase;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final double t = breathPhase * 2 * math.pi;

    // Base background
    canvas.drawRect(rect, Paint()..color = AppTheme.background);

    // Mesh blob 1 - deep teal, top-right (frequency: 1.0)
    final dx1 = 0.07 * math.sin(t * 1.0);
    final dy1 = 0.05 * math.cos(t * 1.0);
    final paint1 = Paint()
      ..shader = RadialGradient(
        center: Alignment(0.7 + dx1, -0.6 + dy1),
        radius: 0.8,
        colors: [
          const Color(0xFF0D4F5A).withValues(alpha: 0.6),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, paint1);

    // Mesh blob 2 - dark blue, center-left (frequency: 0.7)
    final dx2 = 0.08 * math.cos(t * 0.7);
    final dy2 = 0.06 * math.sin(t * 0.7);
    final paint2 = Paint()
      ..shader = RadialGradient(
        center: Alignment(-0.5 + dx2, -0.2 + dy2),
        radius: 0.9,
        colors: [
          const Color(0xFF152040).withValues(alpha: 0.7),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, paint2);

    // Mesh blob 3 - subtle cyan highlight, top-center (frequency: 1.3)
    final dx3 = 0.06 * math.sin(t * 1.3);
    final dy3 = 0.05 * math.cos(t * 1.3);
    final paint3 = Paint()
      ..shader = RadialGradient(
        center: Alignment(0.2 + dx3, -0.8 + dy3),
        radius: 0.5,
        colors: [
          const Color(0xFF22D3EE).withValues(alpha: 0.06),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, paint3);

    // Mesh blob 4 - deep slate, bottom (frequency: 0.5)
    final dx4 = 0.1 * math.cos(t * 0.5);
    final dy4 = 0.07 * math.sin(t * 0.5);
    final paint4 = Paint()
      ..shader = RadialGradient(
        center: Alignment(0.0 + dx4, 0.8 + dy4),
        radius: 0.6,
        colors: [
          const Color(0xFF1A1F2E).withValues(alpha: 0.9),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, paint4);
  }

  @override
  bool shouldRepaint(covariant _MeshGradientPainter oldDelegate) =>
      oldDelegate.breathPhase != breathPhase;
}

// ════════════════════════════════════════════════
// Streak Chip with animated flame glow
// ════════════════════════════════════════════════

class _StreakChip extends StatefulWidget {
  const _StreakChip();

  static int get streak => ProgressService.streak;

  @override
  State<_StreakChip> createState() => _StreakChipState();
}

class _StreakChipState extends State<_StreakChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _glowAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    if (_StreakChip.streak > 0) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streak = _StreakChip.streak;
    const flameColor = Color(0xFFFF6B35);

    return AnimatedBuilder(
      animation: _glowAnim,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: flameColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: flameColor.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: streak > 0
                ? [
                    BoxShadow(
                      color: flameColor
                          .withValues(alpha: _glowAnim.value * 0.3),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_fire_department_rounded,
                size: 14,
                color: streak > 0
                    ? flameColor.withValues(alpha: _glowAnim.value)
                    : flameColor.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 4),
              Text(
                '$streak Day Streak',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: flameColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════
// XP Points Chip
// ════════════════════════════════════════════════

class _XPChip extends StatelessWidget {
  const _XPChip();

  static int get xp => ProgressService.xp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.secondaryAmber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.secondaryAmber.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            size: 14,
            color: AppTheme.secondaryAmber,
          ),
          const SizedBox(width: 4),
          Text(
            '$xp XP',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.secondaryAmber,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Progress Ring Chip (modules studied)
// ════════════════════════════════════════════════

class _ProgressRingChip extends StatelessWidget {
  const _ProgressRingChip({required this.studied, required this.total});
  final int studied;
  final int total;

  @override
  Widget build(BuildContext context) {
    final fraction = total > 0 ? studied / total : 0.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryCyan.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.primaryCyan.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              value: fraction,
              strokeWidth: 2.5,
              backgroundColor: AppTheme.border,
              valueColor: const AlwaysStoppedAnimation(AppTheme.primaryCyan),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$studied/$total',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryCyan,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Glass Morphism Chip
// ════════════════════════════════════════════════

class _GlassChip extends StatelessWidget {
  const _GlassChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Quick Action Card (glass style)
// ════════════════════════════════════════════════

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String sublabel;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const Spacer(),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              sublabel,
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Flashcard Deck Tile (for bottom sheet)
// ════════════════════════════════════════════════

class _FlashcardDeckTile extends StatelessWidget {
  const _FlashcardDeckTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.count,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final String title;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        '$count cards',
        style: const TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 12,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: color.withValues(alpha: 0.5),
      ),
      onTap: onTap,
    );
  }
}

// ════════════════════════════════════════════════
// Daily Review Card (SRS-powered)
// ════════════════════════════════════════════════

class _DailyReviewCard extends StatefulWidget {
  const _DailyReviewCard({required this.onTap});
  final void Function(List<String> dueItems) onTap;

  @override
  State<_DailyReviewCard> createState() => _DailyReviewCardState();
}

class _DailyReviewCardState extends State<_DailyReviewCard> {
  int _dueCount = 0;
  List<String> _dueItems = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadDueCount();
  }

  Future<void> _loadDueCount() async {
    final items = await SRSService.getDueItems();
    if (mounted) {
      setState(() {
        _dueItems = items;
        _dueCount = items.length;
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool allCaughtUp = _loaded && _dueCount == 0;
    final color = allCaughtUp ? AppTheme.successGreen : AppTheme.secondaryAmber;
    final sublabel = !_loaded
        ? 'Loading...'
        : allCaughtUp
            ? 'All caught up!'
            : '$_dueCount cards due';

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        if (_dueCount > 0) {
          widget.onTap(_dueItems);
        }
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                allCaughtUp
                    ? Icons.check_circle_rounded
                    : Icons.replay_rounded,
                color: color,
                size: 20,
              ),
            ),
            const Spacer(),
            Text(
              'Daily Review',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              sublabel,
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
