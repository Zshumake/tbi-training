import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum InfographicCategory { flowchart, anatomy, summary }

class Infographic {
  final String id;
  final String title;
  final String description;
  final String assetPath;
  final InfographicCategory category;
  final String moduleId;
  final IconData icon;

  const Infographic({
    required this.id,
    required this.title,
    required this.description,
    required this.assetPath,
    required this.category,
    required this.moduleId,
    required this.icon,
  });
}

class InfographicData {
  static const List<Infographic> all = [
    // ── Flowcharts ──
    Infographic(
      id: 'icp-ladder',
      title: 'ICP Management Ladder',
      description: '7-step escalation from HOB elevation through barbiturate coma',
      assetPath: 'assets/infographics/flowcharts/icp_management_ladder.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'acute-management',
      icon: Icons.stairs_rounded,
    ),
    Infographic(
      id: 'agitation-algo',
      title: 'Agitation Management Algorithm',
      description: 'Decision tree for posttraumatic agitation with pharmacotherapy hierarchy',
      assetPath: 'assets/infographics/flowcharts/agitation_management.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'agitation-behavioral',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'doc-diagnosis',
      title: 'DOC Diagnostic Algorithm',
      description: 'Coma → VS/UWS → MCS- → MCS+ → Emergence pathway',
      assetPath: 'assets/infographics/flowcharts/doc_diagnosis.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'disorders-of-consciousness',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'sodium-disorders',
      title: 'Sodium Disorders Differential',
      description: 'SIADH vs CSW vs DI diagnostic flowchart',
      assetPath: 'assets/infographics/flowcharts/sodium_disorders.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'neuroendocrine',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'seizure-prophylaxis',
      title: 'Seizure Prophylaxis Algorithm',
      description: '7-day prophylaxis rule and late PTS management',
      assetPath: 'assets/infographics/flowcharts/seizure_prophylaxis.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'medical-complications',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'concussion-rtp',
      title: 'Return-to-Play Protocol',
      description: '6-step graduated return-to-play with medical clearance gate',
      assetPath: 'assets/infographics/flowcharts/concussion_rtp.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'concussion-mtbi',
      icon: Icons.directions_run_rounded,
    ),
    Infographic(
      id: 'herniation',
      title: 'Herniation Syndromes',
      description: '5 herniation types with mechanisms and clinical findings',
      assetPath: 'assets/infographics/flowcharts/herniation_syndromes.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'acute-management',
      icon: Icons.warning_rounded,
    ),
    // ── Anatomical Diagrams ──
    Infographic(
      id: 'hemorrhage-types',
      title: 'Intracranial Hemorrhage Types',
      description: 'EDH vs SDH vs SAH vs ICH — CT appearance and mechanisms',
      assetPath: 'assets/infographics/anatomy/hemorrhage_types_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neuroimaging',
      icon: Icons.bloodtype_rounded,
    ),
    Infographic(
      id: 'dai-locations',
      title: 'DAI Predilection Sites',
      description: 'Adams Grade I-III locations in the brain',
      assetPath: 'assets/infographics/anatomy/dai_locations.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.hub_rounded,
    ),
    Infographic(
      id: 'cranial-nerves',
      title: 'Cranial Nerve Injuries in TBI',
      description: 'Most affected CNs with frequency and mechanisms',
      assetPath: 'assets/infographics/anatomy/cranial_nerves_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'medical-complications',
      icon: Icons.share_rounded,
    ),
    Infographic(
      id: 'coup-contrecoup',
      title: 'Coup-Contrecoup Mechanism',
      description: 'Impact mechanics and vulnerable brain regions',
      assetPath: 'assets/infographics/anatomy/coup_contrecoup_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.swap_horiz_rounded,
    ),
    Infographic(
      id: 'icp-dynamics',
      title: 'Monro-Kellie Doctrine',
      description: 'Intracranial pressure dynamics and compliance curve',
      assetPath: 'assets/infographics/anatomy/icp_dynamics.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.pie_chart_rounded,
    ),
    // ── New Anatomy Diagrams (SMART-inspired) ──
    Infographic(
      id: 'meningeal-layers',
      title: 'Meningeal Layers',
      description: 'Scalp through pia mater with SCALP mnemonic and hemorrhage sites',
      assetPath: 'assets/infographics/anatomy/meningeal_layers_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.layers_rounded,
    ),
    Infographic(
      id: 'skull-base-foramina',
      title: 'Skull Base Foramina',
      description: 'Cranial nerve exit points color-coded by TBI injury frequency',
      assetPath: 'assets/infographics/anatomy/skull_base_foramina_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'medical-complications',
      icon: Icons.circle_outlined,
    ),
    Infographic(
      id: 'brain-lobes',
      title: 'Brain Lobes & TBI Deficits',
      description: 'Functional anatomy mapped to TBI-specific clinical deficits',
      assetPath: 'assets/infographics/anatomy/brain_lobes_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.psychology_rounded,
    ),
    Infographic(
      id: 'circle-of-willis',
      title: 'Circle of Willis',
      description: 'Cerebral vasculature with vascular territories and TBI vasospasm',
      assetPath: 'assets/infographics/anatomy/circle_of_willis_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.donut_large_rounded,
    ),
    Infographic(
      id: 'pituitary-anatomy',
      title: 'Pituitary Anatomy',
      description: 'Hypothalamic-pituitary axis with stalk vulnerability and hormones',
      assetPath: 'assets/infographics/anatomy/pituitary_anatomy_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neuroendocrine',
      icon: Icons.science_rounded,
    ),
    Infographic(
      id: 'umn-lmn-pathways',
      title: 'UMN/LMN Pathways',
      description: 'Corticospinal tract from cortex to muscle with lesion signs',
      assetPath: 'assets/infographics/anatomy/umn_lmn_pathways_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'spasticity-motor',
      icon: Icons.linear_scale_rounded,
    ),
    Infographic(
      id: 'herniation-anatomy',
      title: 'Herniation Syndromes (Anatomy)',
      description: '5 herniation types with directions, boundaries, and Kernohan notch',
      assetPath: 'assets/infographics/anatomy/herniation_anatomy_real.png',
      category: InfographicCategory.anatomy,
      moduleId: 'acute-management',
      icon: Icons.warning_rounded,
    ),
    // ── Visual Summary Cards ──
    Infographic(
      id: 'gcs-summary',
      title: 'GCS Quick Reference',
      description: 'Eye, Verbal, Motor scoring with severity classification',
      assetPath: 'assets/infographics/summaries/gcs_summary.svg',
      category: InfographicCategory.summary,
      moduleId: 'classification-severity',
      icon: Icons.assignment_rounded,
    ),
    Infographic(
      id: 'meds-summary',
      title: 'TBI Medications Cheat Sheet',
      description: 'Avoid vs Promote medications with mechanisms',
      assetPath: 'assets/infographics/summaries/medications_summary.svg',
      category: InfographicCategory.summary,
      moduleId: 'pharmacology',
      icon: Icons.medication_rounded,
    ),
    Infographic(
      id: 'sodium-summary',
      title: 'SIADH vs CSW vs DI',
      description: 'Side-by-side sodium disorder comparison card',
      assetPath: 'assets/infographics/summaries/siadh_csw_di_summary.svg',
      category: InfographicCategory.summary,
      moduleId: 'neuroendocrine',
      icon: Icons.compare_arrows_rounded,
    ),
    Infographic(
      id: 'rancho-summary',
      title: 'Rancho Levels I-X',
      description: 'All 10 levels with descriptions and management',
      assetPath: 'assets/infographics/summaries/rancho_levels_summary.svg',
      category: InfographicCategory.summary,
      moduleId: 'classification-severity',
      icon: Icons.trending_up_rounded,
    ),
  ];

  // ── Keyword triggers for inline contextual image insertion ──

  static const Map<String, List<String>> triggerKeywords = {
    'hemorrhage-types': ['epidural', 'subdural', 'subarachnoid', 'hemorrhage', 'EDH', 'SDH', 'SAH', 'ICH'],
    'dai-locations': ['diffuse axonal', 'DAI', 'retraction ball', 'Adams grade'],
    'cranial-nerves': ['cranial nerve', 'CN I', 'CN VII', 'anosmia', 'facial nerve'],
    'coup-contrecoup': ['coup', 'contrecoup', 'contusion'],
    'icp-dynamics': ['Monro-Kellie', 'intracranial pressure', 'ICP dynamics', 'compliance'],
    'meningeal-layers': ['meninges', 'dura mater', 'arachnoid', 'pia mater', 'SCALP'],
    'skull-base-foramina': ['cribriform', 'foramen', 'skull base'],
    'brain-lobes': ['frontal lobe', 'temporal lobe', 'parietal lobe', 'occipital'],
    'circle-of-willis': ['circle of Willis', 'ACA', 'MCA', 'PCA', 'vasospasm'],
    'pituitary-anatomy': ['pituitary', 'hypothalamic', 'sella turcica', 'hypopituitarism'],
    'umn-lmn-pathways': ['upper motor neuron', 'lower motor neuron', 'corticospinal', 'UMN', 'LMN'],
    'herniation-anatomy': ['herniation', 'uncal', 'tonsillar', 'subfalcine', 'tentorial'],
    'icp-ladder': ['ICP management', 'ICP ladder', 'mannitol', 'barbiturate coma'],
    'agitation-algo': ['agitation algorithm', 'agitation management', 'ABS score'],
    'doc-diagnosis': ['disorders of consciousness', 'VS', 'MCS', 'CRS-R'],
    'sodium-disorders': ['SIADH', 'cerebral salt wasting', 'CSW', 'diabetes insipidus'],
    'seizure-prophylaxis': ['seizure prophylaxis', 'post-traumatic seizure', 'PTS', 'PTE', 'Temkin'],
    'concussion-rtp': ['return to play', 'return-to-play', 'graduated return', 'SCAT'],
    'herniation': ['herniation syndrome', 'Cushing triad', 'Kernohan'],
    'gcs-summary': ['Glasgow Coma Scale', 'GCS scoring', 'Eye opening'],
    'meds-summary': ['medications to avoid', 'medications to promote', 'haloperidol', 'methylphenidate'],
    'sodium-summary': ['SIADH vs CSW', 'sodium disorder comparison'],
    'rancho-summary': ['Rancho Los Amigos', 'Rancho Level', 'Rancho scale'],
  };

  /// Returns the first [Infographic] whose trigger keywords match the given
  /// [text], or `null` if no match is found.
  static Infographic? findByKeywords(String text) {
    final lower = text.toLowerCase();
    for (final entry in triggerKeywords.entries) {
      if (entry.value.any((kw) => lower.contains(kw.toLowerCase()))) {
        try {
          return all.firstWhere((i) => i.id == entry.key);
        } catch (_) {
          continue;
        }
      }
    }
    return null;
  }

  /// Returns a module-color for the glow effect based on the infographic's
  /// [moduleId].  Falls back to [AppTheme.accent] when the module is unknown.
  static Color moduleColor(String moduleId) {
    const map = <String, Color>{
      'tbi-fundamentals': AppTheme.fundamentalsColor,
      'pathophysiology': AppTheme.pathophysColor,
      'classification-severity': AppTheme.classificationColor,
      'neuroimaging': AppTheme.imagingColor,
      'acute-management': AppTheme.acuteColor,
      'disorders-of-consciousness': AppTheme.docColor,
      'medical-complications': AppTheme.complicationsColor,
      'pharmacology': AppTheme.pharmacologyColor,
      'agitation-behavioral': AppTheme.agitationColor,
      'spasticity-motor': AppTheme.spasticityColor,
      'neuroendocrine': AppTheme.neuroendocrineColor,
      'concussion-mtbi': AppTheme.concussionColor,
      'pediatric-geriatric': AppTheme.pediatricColor,
      'rehab-continuum': AppTheme.rehabColor,
    };
    return map[moduleId] ?? AppTheme.accent;
  }

  static List<Infographic> getByCategory(InfographicCategory category) =>
      all.where((i) => i.category == category).toList();

  static List<Infographic> getByModule(String moduleId) =>
      all.where((i) => i.moduleId == moduleId).toList();
}
