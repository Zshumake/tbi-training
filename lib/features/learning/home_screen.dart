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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modules = ModuleData.standardModules;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with gradient
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryNavy,
                      Color(0xFF2D4A7A),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          'TBI Training',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Traumatic Brain Injury Rotation & Board Review',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Progress indicator
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.accentTeal.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppTheme.accentTeal.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Text(
                                '${modules.length} Modules',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.accentTeal,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.warningAmber.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppTheme.warningAmber.withValues(alpha: 0.4),
                                ),
                              ),
                              child: const Text(
                                'Board Ready',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.warningAmber,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: const Text(
                'TBI Training',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ),
          ),
          // Quiz button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: GestureDetector(
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
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.accentTeal, Color(0xFF0D7377)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accentTeal.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.quiz_rounded, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Board Review Quiz',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '10 random questions across all topics',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_rounded, color: Colors.white70),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Flashcard + Podcast row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  // Flashcards button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (ctx) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Choose Flashcard Deck', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                                const SizedBox(height: 16),
                                ListTile(
                                  leading: const Icon(Icons.local_hospital_rounded, color: AppTheme.accentTeal),
                                  title: const Text('Acute Management'),
                                  subtitle: Text('${NotebookLMAcuteMgmtFlashcards.cards.length} cards'),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => FlashcardView(cards: NotebookLMAcuteMgmtFlashcards.cards, title: 'Acute Management Flashcards')));
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.psychology_rounded, color: AppTheme.pathophysColor),
                                  title: const Text('Pathophysiology'),
                                  subtitle: Text('${NotebookLMPathophysFlashcards.cards.length} cards'),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => FlashcardView(cards: NotebookLMPathophysFlashcards.cards, title: 'Pathophysiology Flashcards')));
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.assessment_rounded, color: AppTheme.classificationColor),
                                  title: const Text('Classification & Severity'),
                                  subtitle: Text('${NotebookLMClassificationFlashcards.cards.length} cards'),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => FlashcardView(cards: NotebookLMClassificationFlashcards.cards, title: 'Classification Flashcards')));
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.menu_book_rounded, color: AppTheme.fundamentalsColor),
                                  title: const Text('TBI Fundamentals'),
                                  subtitle: Text('${NotebookLMFundamentalsFlashcards.cards.length} cards'),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => FlashcardView(cards: NotebookLMFundamentalsFlashcards.cards, title: 'TBI Fundamentals Flashcards')));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppTheme.warningAmber.withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.warningAmber.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.style_rounded, color: AppTheme.warningAmber, size: 22),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Flashcards', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                                  Text('4 decks', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Podcast button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (ctx) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Choose Podcast', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                                const SizedBox(height: 16),
                                ...PodcastData.episodes.map((ep) => ListTile(
                                  leading: const Icon(Icons.headset_rounded, color: AppTheme.accentTeal),
                                  title: Text(ep.title),
                                  onTap: () async {
                                    Navigator.pop(ctx);
                                    final player = AudioPlayer();
                                    await player.setAsset(ep.assetPath);
                                    await player.play();
                                  },
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppTheme.pathophysColor.withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.pathophysColor.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.headset_rounded, color: AppTheme.pathophysColor, size: 22),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Podcasts', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                                  Text('4 episodes', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Section header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppTheme.accentTeal,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Learning Pathway',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Module cards
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final module = modules[index];
                return ContentCard(
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
                );
              },
              childCount: modules.length,
            ),
          ),
          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
    );
  }
}
