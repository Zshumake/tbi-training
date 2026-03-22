import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../data/module_data.dart';
import '../../data/quiz_banks/tbi_quiz_bank.dart';
import '../../data/quiz_banks/notebooklm_acute_mgmt_flashcards.dart';
import '../../data/quiz_banks/notebooklm_pathophys_flashcards.dart';
import '../../data/quiz_banks/notebooklm_classification_flashcards.dart';
import '../../data/quiz_banks/notebooklm_fundamentals_flashcards.dart';
import '../../data/models/podcast_model.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/content_card.dart';
import '../../core/widgets/quiz_session_view.dart';
import 'widgets/flashcard_view.dart';
import 'module_content_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final AnimationController _staggerController;
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

    // Stagger entrance animation
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();
  }

  @override
  void dispose() {
    _glowController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modules = ModuleData.standardModules;
    final totalQuestions = TBIQuizBank.allQuestions.length;
    const totalDecks = 4;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Hero Header ──
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: AppTheme.background,
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroHeader(
                moduleCount: modules.length,
                questionCount: totalQuestions,
                deckCount: totalDecks,
                glowAnimation: _glowAnimation,
              ),
              title: const Text(
                'TBI Training',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),

          // ── Quick Actions Row ──
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
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
                    const SizedBox(width: 16),
                  ],
                ),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final module = modules[index];
                // Stagger: each card is delayed by 80ms
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
                          builder: (context) =>
                              ModuleContentScreen(module: module),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: modules.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // ── Bottom Sheet: Flashcard Picker ──
  void _showFlashcardPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceElevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              'Choose Flashcard Deck',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Bottom Sheet: Podcast Picker ──
  void _showPodcastPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceElevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
  });

  final int moduleCount;
  final int questionCount;
  final int deckCount;
  final Animation<double> glowAnimation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Gradient mesh background
        CustomPaint(painter: _MeshGradientPainter()),
        // Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TBI Training',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textPrimary,
                    letterSpacing: -1.5,
                    height: 1.1,
                  ),
                ),
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
                const SizedBox(height: 18),
                // Stats row - glass chips
                Row(
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
                  ],
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
  @override
  void paint(Canvas canvas, Size size) {
    // Base background
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = AppTheme.background,
    );

    // Mesh blob 1 - deep teal, top-right
    final paint1 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.7, -0.6),
        radius: 0.8,
        colors: [
          const Color(0xFF0D4F5A).withValues(alpha: 0.6),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint1);

    // Mesh blob 2 - dark blue, center-left
    final paint2 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.5, -0.2),
        radius: 0.9,
        colors: [
          const Color(0xFF152040).withValues(alpha: 0.7),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint2);

    // Mesh blob 3 - subtle cyan highlight, top-center
    final paint3 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.2, -0.8),
        radius: 0.5,
        colors: [
          const Color(0xFF22D3EE).withValues(alpha: 0.06),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint3);

    // Mesh blob 4 - deep slate, bottom
    final paint4 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, 0.8),
        radius: 0.6,
        colors: [
          const Color(0xFF1A1F2E).withValues(alpha: 0.9),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
      onTap: onTap,
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

