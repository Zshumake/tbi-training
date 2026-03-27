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
    PodcastEpisode(
      id: 'neuroimaging-podcast',
      title: 'Neuroimaging in TBI Board Review',
      description:
          'CT vs MRI indications, advanced imaging (DTI, SWI, fMRI), Canadian CT Head Rule, imaging in mTBI, and prognostic neuroimaging markers.',
      moduleId: 'neuroimaging',
      assetPath: 'assets/audio/neuroimaging_podcast.wav',
    ),
    PodcastEpisode(
      id: 'doc-podcast',
      title: 'Disorders of Consciousness Board Review',
      description:
          'VS/UWS vs MCS+/MCS-, CRS-R assessment, CMD, amantadine evidence, neuroprognostication, and emerging consciousness detection techniques.',
      moduleId: 'disorders-of-consciousness',
      assetPath: 'assets/audio/doc_podcast.wav',
    ),
    PodcastEpisode(
      id: 'medical-complications-podcast',
      title: 'Medical Complications of TBI Board Review',
      description:
          'Seizures/PTE, DVT/VTE prophylaxis, heterotopic ossification, cranial nerve injuries, neuroendocrine dysfunction, and autonomic dysregulation.',
      moduleId: 'medical-complications',
      assetPath: 'assets/audio/medical_complications_podcast.wav',
    ),
    PodcastEpisode(
      id: 'pharmacology-podcast',
      title: 'TBI Pharmacology Board Review',
      description:
          'Neurostimulants, antidepressants, antiepileptics, medications to avoid, dopaminergic agents, and evidence-based pharmacologic neurorehabilitation.',
      moduleId: 'pharmacology',
      assetPath: 'assets/audio/pharmacology_podcast.wav',
    ),
    PodcastEpisode(
      id: 'agitation-podcast',
      title: 'Agitation & Behavioral Management Board Review',
      description:
          'ABS scoring, PSH diagnosis and treatment, pharmacologic management of agitation, beta-blockers, environmental strategies, and restraint alternatives.',
      moduleId: 'agitation-behavioral',
      assetPath: 'assets/audio/agitation_podcast.wav',
    ),
    PodcastEpisode(
      id: 'spasticity-podcast',
      title: 'Spasticity & Motor Recovery Board Review',
      description:
          'Upper and lower motor neuron patterns, Modified Ashworth Scale, botulinum toxin, ITB pumps, surgical options, and motor recovery trajectories.',
      moduleId: 'spasticity-motor',
      assetPath: 'assets/audio/spasticity_podcast.wav',
    ),
    PodcastEpisode(
      id: 'neuroendocrine-podcast',
      title: 'Neuroendocrine Dysfunction Board Review',
      description:
          'Pituitary dysfunction after TBI, SIADH vs CSW, diabetes insipidus, growth hormone deficiency, screening protocols, and hormone replacement.',
      moduleId: 'neuroendocrine',
      assetPath: 'assets/audio/neuroendocrine_podcast.wav',
    ),
    PodcastEpisode(
      id: 'pediatric-geriatric-podcast',
      title: 'Pediatric & Geriatric TBI Board Review',
      description:
          'Age-specific considerations, pediatric GCS, abusive head trauma, elderly fall prevention, anticoagulant reversal, and age-related outcome differences.',
      moduleId: 'pediatric-geriatric',
      assetPath: 'assets/audio/pediatric_geriatric_podcast.wav',
    ),
    PodcastEpisode(
      id: 'rehab-continuum-podcast',
      title: 'Rehabilitation Continuum Board Review',
      description:
          'Acute rehab criteria, post-acute care levels, community reintegration, vocational rehabilitation, long-term outcomes, and the TBI Model Systems.',
      moduleId: 'rehab-continuum',
      assetPath: 'assets/audio/rehab_continuum_podcast.wav',
    ),
  ];
}
