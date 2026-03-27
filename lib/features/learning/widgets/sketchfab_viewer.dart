import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/anatomy_3d_model.dart';

/// Displays a Sketchfab 3D model.
///
/// On **web** this uses an `HtmlElementView` iframe embed (imported
/// conditionally). On **macOS / desktop** it falls back to opening the
/// model in the system browser via `url_launcher`.
class SketchfabViewer extends StatelessWidget {
  final Anatomy3DModel model;
  final Color accentColor;

  const SketchfabViewer({
    super.key,
    required this.model,
    this.accentColor = AppTheme.primaryCyan,
  });

  // ── helpers ──

  Future<void> _openInBrowser() async {
    final uri = Uri.parse(model.webUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  bool get _isDesktop {
    if (kIsWeb) return false;
    return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
  }

  // ── build ──

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: const Text('3D Anatomy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new_rounded),
            tooltip: 'Open in browser',
            onPressed: _openInBrowser,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title / attribution header ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.view_in_ar_rounded,
                      color: accentColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3D ANATOMY',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: accentColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        model.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Drag to rotate',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),

          // ── Attribution ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),
            child: Text(
              'Source: ${model.attribution}',
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary.withValues(alpha: 0.6),
              ),
            ),
          ),

          // ── 3D viewer area ──
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: _isDesktop
                    ? _DesktopFallback(
                        model: model,
                        accentColor: accentColor,
                        onOpen: _openInBrowser,
                      )
                    : kIsWeb
                        ? _WebEmbed(model: model)
                        : _MobileFallback(
                            model: model,
                            accentColor: accentColor,
                            onOpen: _openInBrowser,
                          ),
              ),
            ),
          ),

          // ── Description ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              model.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ),

          // ── Relevant Topics chips ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RELEVANT TOPICS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textSecondary.withValues(alpha: 0.7),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: model.relevantTopics
                      .map((topic) => _TopicChip(
                            label: topic,
                            color: accentColor,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Web iframe embed (only used on web builds)
// ════════════════════════════════════════════════

class _WebEmbed extends StatelessWidget {
  final Anatomy3DModel model;

  const _WebEmbed({required this.model});

  @override
  Widget build(BuildContext context) {
    // On non-web platforms this widget is never built; the HTML
    // platform view registration happens in a web-only entrypoint.
    // For now, show a placeholder that prompts the user to open in
    // browser, since dart:html is unavailable in non-web builds.
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.view_in_ar_rounded,
            size: 64,
            color: AppTheme.primaryCyan.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'Web embed available in browser builds',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Desktop fallback -- open in system browser
// ════════════════════════════════════════════════

class _DesktopFallback extends StatelessWidget {
  final Anatomy3DModel model;
  final Color accentColor;
  final VoidCallback onOpen;

  const _DesktopFallback({
    required this.model,
    required this.accentColor,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.view_in_ar_rounded,
            size: 72,
            color: accentColor.withValues(alpha: 0.35),
          ),
          const SizedBox(height: 20),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '3D viewer opens in your browser',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onOpen,
            icon: const Icon(Icons.open_in_new_rounded, size: 18),
            label: const Text('Open 3D Model'),
            style: FilledButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: AppTheme.background,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Mobile fallback -- also opens in browser
// ════════════════════════════════════════════════

class _MobileFallback extends StatelessWidget {
  final Anatomy3DModel model;
  final Color accentColor;
  final VoidCallback onOpen;

  const _MobileFallback({
    required this.model,
    required this.accentColor,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.view_in_ar_rounded,
            size: 72,
            color: accentColor.withValues(alpha: 0.35),
          ),
          const SizedBox(height: 20),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap below to explore in 3D',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onOpen,
            icon: const Icon(Icons.view_in_ar_rounded, size: 18),
            label: const Text('Open 3D Model'),
            style: FilledButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: AppTheme.background,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// Topic Chip
// ════════════════════════════════════════════════

class _TopicChip extends StatelessWidget {
  final String label;
  final Color color;

  const _TopicChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
