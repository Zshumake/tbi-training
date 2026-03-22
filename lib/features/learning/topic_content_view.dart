import 'package:flutter/material.dart';
import '../../data/models/topic_content_model.dart';
import '../../core/theme/app_theme.dart';

class TopicContentView extends StatelessWidget {
  final TopicData topicData;

  const TopicContentView({super.key, required this.topicData});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: topicData.tabs.length,
      child: Column(
        children: [
          Container(
            color: AppTheme.surface,
            child: TabBar(
              isScrollable: topicData.tabs.length > 3,
              labelColor: AppTheme.accent,
              unselectedLabelColor: AppTheme.textSecondary,
              indicatorColor: AppTheme.accent,
              indicatorWeight: 3,
              dividerColor: AppTheme.border,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabs: topicData.tabs.map((t) => Tab(text: t.title)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: topicData.tabs.map((tab) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tab.blocks.length,
                  itemBuilder: (context, index) {
                    return _buildBlock(tab.blocks[index]);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlock(ContentBlock block) {
    if (block is HeaderBlock) return _buildHeader(block);
    if (block is TextBlock) return _buildText(block);
    if (block is PearlBlock) return _buildPearl(block);
    if (block is BulletCardBlock) return _buildBulletCard(block);
    if (block is TableBlock) return _buildTable(block);
    if (block is MnemonicBlock) return _buildMnemonic(block);
    if (block is NumberedListBlock) return _buildNumberedList(block);
    if (block is MedicationCardBlock) return _buildMedicationCard(block);
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
          color: block.isIntro ? AppTheme.textPrimary : AppTheme.textSecondary,
          fontStyle: block.isIntro ? FontStyle.italic : FontStyle.normal,
        ),
      ),
    );
  }

  Widget _buildPearl(PearlBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.pearlBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.pearlBorder, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_rounded, color: AppTheme.pearlBorder, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  block.title,
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
            block.text,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: AppTheme.accentAmber.withValues(alpha: 0.85),
            ),
          ),
        ],
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
                headingRowColor: WidgetStateProperty.all(AppTheme.surfaceElevated),
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
                columns: block.columns.map((c) => DataColumn(label: Text(c))).toList(),
                rows: List.generate(block.rows.length, (rowIndex) {
                  return DataRow(
                    color: WidgetStateProperty.all(
                      rowIndex.isEven ? AppTheme.surface : AppTheme.surfaceElevated,
                    ),
                    cells: block.rows[rowIndex].map((cell) => DataCell(
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 180),
                        child: Text(cell),
                      ),
                    )).toList(),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMnemonic(MnemonicBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.mnemonicBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.mnemonicBorder, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology_alt_rounded, color: AppTheme.mnemonicBorder, size: 20),
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
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppTheme.mnemonicBorder.withValues(alpha: 0.9),
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

  Widget _buildMedicationCard(MedicationCardBlock block) {
    final isAvoid = block.isAvoid;
    final borderColor = isAvoid ? AppTheme.avoidBorder : AppTheme.accent;
    final bgColor = isAvoid ? AppTheme.avoidBackground : const Color(0xFF182A2A);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isAvoid ? Icons.do_not_disturb_rounded : Icons.check_circle_rounded,
                color: borderColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${block.name} (${block.drugClass})',
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
          Text('Mechanism: ${block.mechanism}',
              style: const TextStyle(fontSize: 12, height: 1.4, color: AppTheme.textSecondary)),
          Text('Indication: ${block.indication}',
              style: const TextStyle(fontSize: 12, height: 1.4, color: AppTheme.textSecondary)),
          if (block.dosing.isNotEmpty)
            Text('Dosing: ${block.dosing}',
                style: const TextStyle(fontSize: 12, height: 1.4, color: AppTheme.textSecondary)),
          if (block.sideEffects.isNotEmpty)
            Text('Side Effects: ${block.sideEffects}',
                style: const TextStyle(fontSize: 12, height: 1.4, color: AppTheme.textSecondary)),
          if (block.boardPearl.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'Board Pearl: ${block.boardPearl}',
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
              style: const TextStyle(fontSize: 13, height: 1.4, color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          ...block.keyPoints.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('- ', style: TextStyle(color: block.themeColor, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(p,
                          style: const TextStyle(
                              fontSize: 12, height: 1.4, color: AppTheme.textSecondary)),
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
                  style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 16,
              horizontalMargin: 12,
              headingRowColor: WidgetStateProperty.all(AppTheme.surfaceElevated),
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
              columns: block.columns.map((c) => DataColumn(label: Text(c))).toList(),
              rows: List.generate(block.rows.length, (rowIndex) {
                return DataRow(
                  color: WidgetStateProperty.all(
                    rowIndex.isEven ? AppTheme.surface : AppTheme.surfaceElevated,
                  ),
                  cells: block.rows[rowIndex].map((cell) => DataCell(
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 160),
                      child: Text(cell),
                    ),
                  )).toList(),
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
