class PodcastEpisode {
  final String id;
  final String title;
  final String description;
  final String moduleId;
  final String assetPath;

  const PodcastEpisode({
    required this.id,
    required this.title,
    required this.description,
    required this.moduleId,
    required this.assetPath,
  });
}

class PodcastData {
  static const List<PodcastEpisode> episodes = [
    PodcastEpisode(
      id: 'acute-mgmt-podcast',
      title: 'High Yield Acute TBI Board Review',
      description:
          'Board-focused podcast covering BTF guidelines, ICP management, SIBICC algorithm, CRASH-3/TXA, failed trials, blood biomarkers, and critical numbers.',
      moduleId: 'acute-management',
      assetPath: 'assets/audio/acute_management_podcast.wav',
    ),
    PodcastEpisode(
      id: 'pathophys-podcast',
      title: 'TBI Pathophysiology Board Review',
      description:
          'Deep dive into primary vs secondary injury, DAI, neurometabolic cascade, neuroinflammation, glymphatic system, ferroptosis, and emerging pathophysiology.',
      moduleId: 'pathophysiology',
      assetPath: 'assets/audio/pathophysiology_podcast.wav',
    ),
    PodcastEpisode(
      id: 'classification-podcast',
      title: 'TBI Classification & Severity Board Review',
      description:
          'GCS, GCS-P, FOUR Score, DRS, Rancho Levels, CRS-R, MCS+/MCS-, CMD, blood biomarkers, CT scoring systems, and outcome measures.',
      moduleId: 'classification-severity',
      assetPath: 'assets/audio/classification_severity_podcast.wav',
    ),
    PodcastEpisode(
      id: 'fundamentals-podcast',
      title: 'TBI Fundamentals Board Review',
      description:
          'Epidemiology updates, TBI as chronic disease, military/blast TBI, IPV-TBI, CBI-M framework, neurodegeneration risk, and prevention advances.',
      moduleId: 'tbi-fundamentals',
      assetPath: 'assets/audio/tbi_fundamentals_podcast.wav',
    ),
  ];
}
