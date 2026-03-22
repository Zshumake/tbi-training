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
          TabBar(
            isScrollable: topicData.tabs.length > 3,
            labelColor: AppTheme.primaryNavy,
            unselectedLabelColor: AppTheme.textSecondary,
            indicatorColor: AppTheme.accentTeal,
            indicatorWeight: 3,
            tabs: topicData.tabs.map((t) => Tab(text: t.title)).toList(),
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
      child: Text(
        block.title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppTheme.primaryNavy,
          letterSpacing: -0.5,
        ),
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
                    color: Color(0xFF92400E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            block.text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF78350F),
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
        color: block.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: block.themeColor.withValues(alpha: 0.3)),
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
                        style: const TextStyle(fontSize: 13, height: 1.5),
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
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (block.title.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: block.headerColor ?? AppTheme.primaryNavy,
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
                headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
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
                rows: block.rows.map((row) {
                  return DataRow(
                    cells: row.map((cell) => DataCell(
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 180),
                        child: Text(cell),
                      ),
                    )).toList(),
                  );
                }).toList(),
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
                  color: Color(0xFF5B21B6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            block.mnemonic,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF4C1D95),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            block.explanation,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF6D28D9),
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
                    color: AppTheme.accentTeal.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item.key,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentTeal,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.value,
                    style: const TextStyle(fontSize: 13, height: 1.5),
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
    final borderColor = block.isAvoid ? AppTheme.avoidBorder : AppTheme.accentTeal;
    final bgColor = block.isAvoid ? AppTheme.avoidBackground : const Color(0xFFF0FDFA);

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
                block.isAvoid ? Icons.do_not_disturb_rounded : Icons.check_circle_rounded,
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
                    color: borderColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Mechanism: ${block.mechanism}', style: const TextStyle(fontSize: 12, height: 1.4)),
          Text('Indication: ${block.indication}', style: const TextStyle(fontSize: 12, height: 1.4)),
          if (block.dosing.isNotEmpty)
            Text('Dosing: ${block.dosing}', style: const TextStyle(fontSize: 12, height: 1.4)),
          if (block.sideEffects.isNotEmpty)
            Text('Side Effects: ${block.sideEffects}', style: const TextStyle(fontSize: 12, height: 1.4)),
          if (block.boardPearl.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'Board Pearl: ${block.boardPearl}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: borderColor,
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
        color: block.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: block.themeColor.withValues(alpha: 0.3)),
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
          Text(block.description, style: const TextStyle(fontSize: 13, height: 1.4)),
          const SizedBox(height: 8),
          ...block.keyPoints.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: block.themeColor, fontWeight: FontWeight.bold)),
                    Expanded(child: Text(p, style: const TextStyle(fontSize: 12, height: 1.4))),
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accentTeal.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.accentTeal.withValues(alpha: 0.1),
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
                    color: AppTheme.accentTeal,
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
              headingTextStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
              dataTextStyle: const TextStyle(fontSize: 11, height: 1.3),
              columns: block.columns.map((c) => DataColumn(label: Text(c))).toList(),
              rows: block.rows.map((row) {
                return DataRow(
                  cells: row.map((cell) => DataCell(
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 160),
                      child: Text(cell),
                    ),
                  )).toList(),
                );
              }).toList(),
            ),
          ),
          if (block.boardPearl != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.pearlBackground,
                borderRadius: const BorderRadius.only(
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
                  color: Color(0xFF92400E),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
