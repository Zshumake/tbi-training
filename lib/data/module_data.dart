import 'models/module_model.dart';

class ModuleData {
  static final List<ModuleModel> standardModules = [
    ModuleModel(
      id: 'tbi-fundamentals',
      title: 'TBI Fundamentals',
      description:
          'Epidemiology, definitions, and the landscape of traumatic brain injury.',
      highlights: ['Epidemiology', 'Definitions', 'Severity classification'],
    ),
    ModuleModel(
      id: 'pathophysiology',
      title: 'Pathophysiology',
      description:
          'Primary vs secondary injury, focal vs diffuse, and the neurochemical cascade.',
      highlights: ['Primary injury', 'Secondary injury', 'DAI'],
    ),
    ModuleModel(
      id: 'classification-severity',
      title: 'Classification & Severity Scales',
      description:
          'GCS, FOUR Score, GOS, DRS, Rancho Los Amigos, FIM, and PTA assessment.',
      highlights: ['GCS', 'Rancho', 'DRS', 'PTA'],
    ),
    ModuleModel(
      id: 'neuroimaging',
      title: 'Neuroimaging in TBI',
      description:
          'CT vs MRI, Marshall Classification, hemorrhage types, and advanced imaging.',
      highlights: ['CT findings', 'Marshall', 'DAI imaging'],
    ),
    ModuleModel(
      id: 'acute-management',
      title: 'Acute Management & BTF Guidelines',
      description:
          'ICP management, CPP targets, BTF 4th edition, surgical interventions.',
      highlights: ['ICP', 'CPP', 'BTF guidelines', 'CRASH trial'],
    ),
    ModuleModel(
      id: 'disorders-of-consciousness',
      title: 'Disorders of Consciousness',
      description:
          'Coma, VS, MCS, CRS-R assessment, and emerging therapies.',
      highlights: ['VS vs MCS', 'CRS-R', 'Amantadine trial'],
    ),
    ModuleModel(
      id: 'medical-complications',
      title: 'Medical Complications',
      description:
          'Seizures, hydrocephalus, HO, VTE, cranial nerve injuries, and more.',
      highlights: ['PTS/PTE', 'HO', 'DVT/PE', 'CN injuries'],
    ),
    ModuleModel(
      id: 'pharmacology',
      title: 'TBI Pharmacology',
      description:
          'Medications to avoid, medications to promote recovery, and drug interactions.',
      highlights: ['Avoid list', 'Recovery agents', 'Drug interactions'],
    ),
    ModuleModel(
      id: 'agitation-behavioral',
      title: 'Agitation & Behavioral Management',
      description:
          'Posttraumatic agitation, PSH, environmental management, and pharmacotherapy.',
      highlights: ['ABS', 'PSH', 'Beta-blockers', 'Agitation algorithm'],
    ),
    ModuleModel(
      id: 'spasticity-motor',
      title: 'Spasticity & Motor Recovery',
      description:
          'Assessment scales, management ladder, botulinum toxin, ITB pump.',
      highlights: ['MAS', 'Tardieu', 'Baclofen', 'ITB'],
    ),
    ModuleModel(
      id: 'neuroendocrine',
      title: 'Neuroendocrine Disorders',
      description:
          'SIADH vs CSW vs DI — the critical differential. Pituitary dysfunction after TBI.',
      highlights: ['SIADH', 'CSW', 'DI', 'Hypopituitarism'],
    ),
    ModuleModel(
      id: 'concussion-mtbi',
      title: 'Concussion & Mild TBI',
      description:
          'Sport concussion, SCAT6, return-to-play, PCS, second impact syndrome, CTE.',
      highlights: ['SCAT6', 'Return-to-play', 'PCS', 'CTE'],
    ),
    ModuleModel(
      id: 'pediatric-geriatric',
      title: 'Pediatric & Geriatric TBI',
      description:
          'Age-specific considerations, abusive head trauma, elderly falls, PECARN.',
      highlights: ['Pediatric GCS', 'PECARN', 'Elderly TBI'],
    ),
    ModuleModel(
      id: 'rehab-continuum',
      title: 'TBI Rehabilitation Continuum',
      description:
          'Acute care through community reintegration, vocational rehab, and driving.',
      highlights: ['Inpatient rehab', 'Post-acute', 'Community'],
    ),
  ];
}
