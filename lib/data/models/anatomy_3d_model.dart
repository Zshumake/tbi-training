/// Data model for 3D anatomy models hosted on Sketchfab.
class Anatomy3DModel {
  final String id;
  final String title;
  final String description;
  final String sketchfabId;
  final String attribution;
  final String moduleId;
  final List<String> relevantTopics;

  const Anatomy3DModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sketchfabId,
    required this.attribution,
    required this.moduleId,
    required this.relevantTopics,
  });

  /// Sketchfab embed URL with dark theme and minimal UI.
  String get embedUrl =>
      'https://sketchfab.com/models/$sketchfabId/embed'
      '?autostart=1&ui_theme=dark&ui_infos=0&ui_controls=0'
      '&ui_stop=0&ui_watermark=0&ui_watermark_link=0';

  /// URL to open the model on the Sketchfab website.
  String get webUrl => 'https://sketchfab.com/3d-models/$sketchfabId';
}

class Anatomy3DData {
  static const List<Anatomy3DModel> all = [
    Anatomy3DModel(
      id: 'brain-realistic',
      title: 'Brain Realistic',
      description:
          'Detailed realistic brain model for general neuroanatomy orientation. '
          'Useful for understanding gyri, sulci, and overall brain topography.',
      sketchfabId: '756bc05dd59e4f3ca1a93ffcc57a8994',
      attribution: 'Sketchfab Community',
      moduleId: 'pathophysiology',
      relevantTopics: [
        'Cortical anatomy',
        'Gyri and sulci',
        'Coup-contrecoup sites',
        'Brain topography',
      ],
    ),
    Anatomy3DModel(
      id: 'cerebrum-brainstem',
      title: 'Human Brain Cerebrum & Brainstem',
      description:
          'Cerebrum and brainstem detail ideal for understanding herniation '
          'syndromes and disorders of consciousness pathways.',
      sketchfabId: '0aa0e33c5c854d1bab7bac9e1c7acaec',
      attribution: 'Sketchfab Community',
      moduleId: 'disorders-of-consciousness',
      relevantTopics: [
        'Brainstem anatomy',
        'Herniation syndromes',
        'Reticular activating system',
        'Disorders of consciousness',
      ],
    ),
    Anatomy3DModel(
      id: 'brain-labeled',
      title: 'Brain with Labeled Parts',
      description:
          'Labeled brain model for learning lobes, functional areas, and '
          'key structures affected in TBI pathophysiology.',
      sketchfabId: '28c8971e11334e8b97a2a0d6235992e8',
      attribution: 'Sketchfab Community',
      moduleId: 'pathophysiology',
      relevantTopics: [
        'Frontal lobe function',
        'Temporal lobe injuries',
        'DAI predilection sites',
        'Primary vs secondary injury',
      ],
    ),
    Anatomy3DModel(
      id: 'brain-clean',
      title: 'Human Brain',
      description:
          'Clean brain model well suited for neuroimaging correlation '
          'and understanding hemorrhage locations.',
      sketchfabId: 'c9c9d4d671b94345952d012cc2ea7a24',
      attribution: 'Sketchfab Community',
      moduleId: 'neuroimaging',
      relevantTopics: [
        'CT correlation',
        'Hemorrhage locations',
        'Marshall classification',
        'Midline shift',
      ],
    ),
    Anatomy3DModel(
      id: 'brain-lobes',
      title: 'Human Brain - Detailed Lobes',
      description:
          'Detailed lobe visualization for concussion education, '
          'understanding focal deficits, and acute management planning.',
      sketchfabId: '7a27c17fd6c0488bb31ab093236a47fb',
      attribution: 'Sketchfab Community',
      moduleId: 'concussion-mtbi',
      relevantTopics: [
        'Frontal lobe concussion effects',
        'Lobe-specific deficits',
        'Acute management anatomy',
        'Concussion biomechanics',
      ],
    ),
  ];

  /// Get all 3D models for a specific module.
  static List<Anatomy3DModel> getByModule(String moduleId) =>
      all.where((m) => m.moduleId == moduleId).toList();

  /// Get all 3D models relevant to a given topic keyword (case-insensitive).
  static List<Anatomy3DModel> searchByTopic(String keyword) {
    final lc = keyword.toLowerCase();
    return all
        .where((m) => m.relevantTopics.any((t) => t.toLowerCase().contains(lc)))
        .toList();
  }
}
