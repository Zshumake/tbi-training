import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/topic_content_model.dart';
import '../../data/models/infographic_model.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/infographic_viewer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// TopicContentView  –  Premium Clinical Atlas UI
// ─────────────────────────────────────────────────────────────────────────────

class TopicContentView extends StatelessWidget {
  final TopicData topicData;

  const TopicContentView({super.key, required this.topicData});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: topicData.tabs.length,
      child: Column(
        children: [
          // ── UPGRADE 1: Glass-morphism TabBar ──
          Container(
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              border: Border(
                top: BorderSide(color: AppTheme.border, width: 1),
              ),
            ),
            child: TabBar(
              isScrollable: topicData.tabs.length > 3,
              labelColor: AppTheme.accent,
              unselectedLabelColor: AppTheme.textSecondary,
              dividerColor: AppTheme.border,
              splashFactory: InkSparkle.splashFactory,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              indicator: _GlassTabIndicator(),
              tabs: topicData.tabs.map((t) {
                return Tab(
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(t.title),
                  ),
                );
              }).toList(),
            ),
          ),
          // ── Content ──
          Expanded(
            child: TabBarView(
              children: topicData.tabs.map((tab) {
                return _AnimatedContentList(
                  items: _buildItemsWithInlineImages(tab.blocks),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Inline image injection ──

  /// Extracts searchable text from a [ContentBlock] for keyword matching.
  static String _extractText(ContentBlock block) {
    if (block is HeaderBlock) return block.title;
    if (block is TextBlock) return block.text;
    if (block is BulletCardBlock) {
      return '${block.title} ${block.points.join(' ')}';
    }
    if (block is PearlBlock) return '${block.title} ${block.text}';
    if (block is TableBlock) return block.title;
    if (block is MedicationCardBlock) {
      return '${block.name} ${block.drugClass} ${block.mechanism} '
          '${block.indication} ${block.boardPearl}';
    }
    if (block is MnemonicBlock) {
      return '${block.mnemonic} ${block.explanation}';
    }
    if (block is ComparisonCardBlock) {
      return '${block.title} ${block.description} ${block.keyPoints.join(' ')}';
    }
    if (block is ScaleBlock) {
      return '${block.scaleName} ${block.description} ${block.boardPearl ?? ''}';
    }
    if (block is NumberedListBlock) {
      return block.items.map((e) => '${e.key} ${e.value}').join(' ');
    }
    return '';
  }

  /// Builds the final widget list for a tab, injecting inline infographic
  /// cards after blocks whose text matches trigger keywords.
  /// Limits to [_maxInlineImages] per tab and deduplicates by infographic ID.
  static const int _maxInlineImages = 3;

  List<Widget> _buildItemsWithInlineImages(List<ContentBlock> blocks) {
    final items = <Widget>[];
    final inserted = <String>{};

    for (final block in blocks) {
      items.add(_buildBlock(block));

      if (inserted.length >= _maxInlineImages) continue;

      final text = _extractText(block);
      if (text.isEmpty) continue;

      final match = InfographicData.findByKeywords(text);
      if (match != null && !inserted.contains(match.id)) {
        inserted.add(match.id);
        items.add(_InlineImageCard(infographic: match));
      }
    }
    return items;
  }

  Widget _buildBlock(ContentBlock block) {
    if (block is HeaderBlock) return _buildHeader(block);
    if (block is TextBlock) return _buildText(block);
    if (block is PearlBlock) return _PearlBlockWidget(block: block);
    if (block is BulletCardBlock) return _buildBulletCard(block);
    if (block is TableBlock) return _buildTable(block);
    if (block is MnemonicBlock) return _MnemonicBlockWidget(block: block);
    if (block is NumberedListBlock) return _buildNumberedList(block);
    if (block is MedicationCardBlock) {
      return _MedicationCardBlockWidget(block: block);
    }
    if (block is ComparisonCardBlock) return _buildComparisonCard(block);
    if (block is ScaleBlock) return _buildScaleBlock(block);
    return const SizedBox.shrink();
  }

  Widget _buildHeader(HeaderBlock block) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 2,
            decoration: BoxDecoration(
              color: AppTheme.accent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(TextBlock block) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        block.text,
        style: TextStyle(
          fontSize: block.isIntro ? 16 : 14,
          height: 1.6,
          color:
              block.isIntro ? AppTheme.textPrimary : AppTheme.textSecondary,
          fontStyle: block.isIntro ? FontStyle.italic : FontStyle.normal,
        ),
      ),
    );
  }

  Widget _buildBulletCard(BulletCardBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: block.themeColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: block.themeColor,
            ),
          ),
          const SizedBox(height: 10),
          ...block.points.map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: block.themeColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTable(TableBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (block.title.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: block.headerColor ?? AppTheme.accent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
              ),
              child: Text(
                block.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(11),
              bottomRight: Radius.circular(11),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(AppTheme.surfaceElevated),
                columnSpacing: 16,
                horizontalMargin: 12,
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppTheme.textPrimary,
                ),
                dataTextStyle: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textPrimary,
                  height: 1.3,
                ),
                columns: block.columns
                    .map((c) => DataColumn(label: Text(c)))
                    .toList(),
                rows: List.generate(block.rows.length, (rowIndex) {
                  return DataRow(
                    color: WidgetStateProperty.all(
                      rowIndex.isEven
                          ? AppTheme.surface
                          : AppTheme.surfaceElevated,
                    ),
                    cells: block.rows[rowIndex]
                        .map((cell) => DataCell(
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 180),
                                child: Text(cell),
                              ),
                            ))
                        .toList(),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedList(NumberedListBlock block) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: block.items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item.key,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accent,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.value,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildComparisonCard(ComparisonCardBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: block.themeColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(block.icon, color: block.themeColor, size: 22),
              const SizedBox(width: 10),
              Text(
                block.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: block.themeColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(block.description,
              style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          ...block.keyPoints.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('- ',
                        style: TextStyle(
                            color: block.themeColor,
                            fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(p,
                          style: const TextStyle(
                              fontSize: 12,
                              height: 1.4,
                              color: AppTheme.textSecondary)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildScaleBlock(ScaleBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  block.scaleName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.accent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  block.description,
                  style: const TextStyle(
                      fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 16,
              horizontalMargin: 12,
              headingRowColor:
                  WidgetStateProperty.all(AppTheme.surfaceElevated),
              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: AppTheme.textPrimary,
              ),
              dataTextStyle: const TextStyle(
                fontSize: 11,
                height: 1.3,
                color: AppTheme.textPrimary,
              ),
              columns: block.columns
                  .map((c) => DataColumn(label: Text(c)))
                  .toList(),
              rows: List.generate(block.rows.length, (rowIndex) {
                return DataRow(
                  color: WidgetStateProperty.all(
                    rowIndex.isEven
                        ? AppTheme.surface
                        : AppTheme.surfaceElevated,
                  ),
                  cells: block.rows[rowIndex]
                      .map((cell) => DataCell(
                            ConstrainedBox(
                              constraints:
                                  const BoxConstraints(maxWidth: 160),
                              child: Text(cell),
                            ),
                          ))
                      .toList(),
                );
              }),
            ),
          ),
          if (block.boardPearl != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppTheme.pearlBackground,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(11),
                  bottomRight: Radius.circular(11),
                ),
              ),
              child: Text(
                'Board Pearl: ${block.boardPearl}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.accentAmber,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// UPGRADE 1 — Glass Tab Indicator
// ═══════════════════════════════════════════════════════════════════════════════

class _GlassTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GlassTabIndicatorPainter();
  }
}

class _GlassTabIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      configuration.size?.width ?? 0,
      configuration.size?.height ?? 0,
    );

    final rrect = RRect.fromRectAndRadius(rect.deflate(4), const Radius.circular(8));

    // Gradient fill
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppTheme.accent.withValues(alpha: 0.2),
          Colors.transparent,
        ],
      ).createShader(rrect.outerRect);
    canvas.drawRRect(rrect, fillPaint);

    // Border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = AppTheme.accent.withValues(alpha: 0.4);
    canvas.drawRRect(rrect, borderPaint);

    // Glow shadow beneath
    final glowPaint = Paint()
      ..color = AppTheme.accent.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    final glowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        rrect.left + 8,
        rrect.bottom - 4,
        rrect.width - 16,
        6,
      ),
      const Radius.circular(3),
    );
    canvas.drawRRect(glowRect, glowPaint);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// UPGRADE 3 — Scroll-Triggered Staggered Reveal
// ═══════════════════════════════════════════════════════════════════════════════

class _AnimatedContentList extends StatefulWidget {
  final List<Widget> items;

  const _AnimatedContentList({
    required this.items,
  });

  @override
  State<_AnimatedContentList> createState() => _AnimatedContentListState();
}

class _AnimatedContentListState extends State<_AnimatedContentList>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final Set<int> _revealed = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300 + (widget.items.length * 50),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        // Calculate the stagger interval for this item
        final totalItems = widget.items.length;
        final itemDuration = 300.0; // ms per item
        final staggerDelay = 50.0; // ms stagger
        final totalDuration = itemDuration + (totalItems * staggerDelay);
        final start = (index * staggerDelay) / totalDuration;
        final end =
            ((index * staggerDelay) + itemDuration) / totalDuration;

        final animation = CurvedAnimation(
          parent: _controller,
          curve: Interval(
            start.clamp(0.0, 1.0),
            end.clamp(0.0, 1.0),
            curve: Curves.easeOutCubic,
          ),
        );

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            // Once fully revealed, mark it so we don't re-animate
            if (animation.value >= 1.0) {
              _revealed.add(index);
            }
            final effectiveValue =
                _revealed.contains(index) ? 1.0 : animation.value;
            return Opacity(
              opacity: effectiveValue,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - effectiveValue)),
                child: child,
              ),
            );
          },
          child: widget.items[index],
        );
      },
    );
  }
}

/// Wrap an [Animation] so we can use [AnimatedBuilder] (renamed from
/// [AnimatedWidget] usage) without requiring a StatefulWidget per item.
class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext, Widget?) builder;
  final Widget? child;

  const AnimatedBuilder({
    super.key,
    required this.animation,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder2(
      listenable: animation,
      builder: builder,
      child: child,
    );
  }
}

class AnimatedBuilder2 extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;
  final Widget? child;

  const AnimatedBuilder2({
    super.key,
    required super.listenable,
    required this.builder,
    this.child,
  });

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// UPGRADE 2a — PearlBlock with shimmer scan line
// ═══════════════════════════════════════════════════════════════════════════════

class _PearlBlockWidget extends StatefulWidget {
  final PearlBlock block;
  const _PearlBlockWidget({required this.block});

  @override
  State<_PearlBlockWidget> createState() => _PearlBlockWidgetState();
}

class _PearlBlockWidgetState extends State<_PearlBlockWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppTheme.pearlBackground,
            Color(0xFF221E12), // slightly darker amber-dark
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: AppTheme.pearlBorder, width: 3),
          top: BorderSide(color: AppTheme.pearlBorder, width: 0.5),
          right: BorderSide(color: AppTheme.pearlBorder, width: 0.5),
          bottom: BorderSide(color: AppTheme.pearlBorder, width: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Shimmer scan line at top edge
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 2,
            child: AnimatedBuilder2(
              listenable: _shimmer,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ShimmerLinePainter(
                    progress: _shimmer.value,
                    color: AppTheme.pearlBorder,
                  ),
                );
              },
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.diamond_rounded,
                        color: AppTheme.secondaryAmber, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.block.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.accentAmber,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.block.text,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: AppTheme.accentAmber.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerLinePainter extends CustomPainter {
  final double progress;
  final Color color;

  _ShimmerLinePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = progress * size.width;
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          color.withValues(alpha: 0.8),
          Colors.white.withValues(alpha: 0.9),
          color.withValues(alpha: 0.8),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
      ).createShader(
        Rect.fromCenter(
          center: Offset(center, size.height / 2),
          width: size.width * 0.4,
          height: size.height,
        ),
      );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(_ShimmerLinePainter old) => old.progress != progress;
}

// ═══════════════════════════════════════════════════════════════════════════════
// UPGRADE 2b — MnemonicBlock with diagonal stripes + brain icon
// ═══════════════════════════════════════════════════════════════════════════════

class _MnemonicBlockWidget extends StatelessWidget {
  final MnemonicBlock block;
  const _MnemonicBlockWidget({required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.mnemonicBackground,           // 0xFF1E1B2E
            Color(0xFF211E33),                      // slightly lighter
            AppTheme.mnemonicBackground,
            Color(0xFF211E33),
            AppTheme.mnemonicBackground,
            Color(0xFF211E33),
            AppTheme.mnemonicBackground,
          ],
          stops: [0.0, 0.15, 0.3, 0.45, 0.6, 0.75, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.mnemonicBorder, width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology_rounded,
                  color: AppTheme.mnemonicBorder, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Memory Aid',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.mnemonicBorder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            block.mnemonic,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppTheme.mnemonicBorder.withValues(alpha: 0.9),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            block.explanation,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: AppTheme.mnemonicBorder.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// UPGRADE 2c — MedicationCardBlock with pulsing dot / check + badge
// ═══════════════════════════════════════════════════════════════════════════════

class _MedicationCardBlockWidget extends StatefulWidget {
  final MedicationCardBlock block;
  const _MedicationCardBlockWidget({required this.block});

  @override
  State<_MedicationCardBlockWidget> createState() =>
      _MedicationCardBlockWidgetState();
}

class _MedicationCardBlockWidgetState
    extends State<_MedicationCardBlockWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulseController;

  @override
  void initState() {
    super.initState();
    if (widget.block.isAvoid) {
      _pulseController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
        lowerBound: 0.3,
        upperBound: 1.0,
      )..repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAvoid = widget.block.isAvoid;
    final borderColor = isAvoid ? AppTheme.avoidBorder : AppTheme.accent;
    final bgColor =
        isAvoid ? AppTheme.avoidBackground : const Color(0xFF182A2A);
    final tintColor = isAvoid
        ? AppTheme.avoidBorder.withValues(alpha: 0.85)
        : AppTheme.accent.withValues(alpha: 0.85);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor.withValues(alpha: 0.4)),
      ),
      child: Stack(
        children: [
          // Badge chip — top left
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: borderColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: borderColor.withValues(alpha: 0.4),
                  width: 0.5,
                ),
              ),
              child: Text(
                isAvoid ? 'AVOID' : 'PROMOTE',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: borderColor,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          // Pulsing dot (avoid) or check (promote) — top right
          Positioned(
            top: 0,
            right: 0,
            child: isAvoid ? _buildPulsingDot() : _buildCheckIcon(),
          ),
          // Main content — push down to avoid badge overlap
          Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isAvoid
                          ? Icons.do_not_disturb_rounded
                          : Icons.check_circle_rounded,
                      color: borderColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${widget.block.name} (${widget.block.drugClass})',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: tintColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Mechanism: ${widget.block.mechanism}',
                    style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: AppTheme.textSecondary)),
                Text('Indication: ${widget.block.indication}',
                    style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: AppTheme.textSecondary)),
                if (widget.block.dosing.isNotEmpty)
                  Text('Dosing: ${widget.block.dosing}',
                      style: const TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: AppTheme.textSecondary)),
                if (widget.block.sideEffects.isNotEmpty)
                  Text('Side Effects: ${widget.block.sideEffects}',
                      style: const TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: AppTheme.textSecondary)),
                if (widget.block.boardPearl.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Board Pearl: ${widget.block.boardPearl}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: tintColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulsingDot() {
    return AnimatedBuilder2(
      listenable: _pulseController!,
      builder: (context, _) {
        return Opacity(
          opacity: _pulseController!.value,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppTheme.dangerRed,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckIcon() {
    return Icon(
      Icons.check_circle_rounded,
      size: 14,
      color: AppTheme.successGreen.withValues(alpha: 0.7),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Inline Contextual Image Card
// ═══════════════════════════════════════════════════════════════════════════════

class _InlineImageCard extends StatelessWidget {
  final Infographic infographic;

  const _InlineImageCard({required this.infographic});

  Color get _glowColor => InfographicData.moduleColor(infographic.moduleId);

  @override
  Widget build(BuildContext context) {
    final glowColor = _glowColor;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InfographicViewer(infographic: infographic),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
          boxShadow: [
            BoxShadow(
              color: glowColor.withValues(alpha: 0.12),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image area
            Container(
              height: 200,
              color: AppTheme.background,
              padding: const EdgeInsets.all(12),
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
            // Caption row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppTheme.border, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Icon(infographic.icon, color: glowColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      infographic.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Tap to explore >',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryCyan,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
