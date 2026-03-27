import 'package:flutter/material.dart';
import '../models/anatomy_layer_model.dart';

/// Layered anatomy data for intracranial hemorrhage types.
///
/// Six layers from outermost (skull) to deepest (brain parenchyma),
/// each with board-relevant annotations and clinical pearls.
const AnatomyDiagram hemorrhageLayersDiagram = AnatomyDiagram(
  id: 'hemorrhage-types-layers',
  title: 'Intracranial Hemorrhage Layers',
  description:
      'Peel away anatomical layers to understand the spatial relationship '
      'of EDH, SDH, SAH, and ICH relative to meningeal structures.',
  layers: [
    // ── Layer 0: Skull ──
    AnatomyLayer(
      order: 0,
      name: 'Skull',
      description:
          'Bony calvarium, fractures can tear middle meningeal artery',
      color: Color(0xFFE8ECF1), // white/bone
      annotations: [
        LayerAnnotation(
          label: 'Temporal bone',
          detail:
              'Thinnest part of calvarium. Temporal bone fractures account '
              'for ~75% of EDH cases by lacerating the middle meningeal '
              'artery as it courses through the epidural space.',
          x: 0.25,
          y: 0.45,
        ),
        LayerAnnotation(
          label: 'Suture lines',
          detail:
              'Dura adheres tightly to the inner skull table at suture lines. '
              'This is why epidural hematomas do NOT cross sutures — the dura '
              'is fused to bone at these junctions.',
          x: 0.72,
          y: 0.18,
        ),
        LayerAnnotation(
          label: 'Skull fracture',
          detail:
              'Present in ~90% of adult EDH cases. In children, EDH can '
              'occur without fracture due to more deformable calvarium. '
              'Linear fractures crossing MMA groove are highest risk.',
          x: 0.78,
          y: 0.35,
        ),
      ],
    ),

    // ── Layer 1: Epidural Space ──
    AnatomyLayer(
      order: 1,
      name: 'Epidural Space',
      description:
          'Between skull and dura. EDH: biconvex, middle meningeal artery, '
          'does NOT cross sutures, lucid interval in ~50%',
      color: Color(0xFFEF4444), // danger red — arterial
      annotations: [
        LayerAnnotation(
          label: 'Middle meningeal a.',
          detail:
              'Most common source of EDH. Arterial bleed causes rapid '
              'accumulation. Classic presentation: loss of consciousness, '
              'lucid interval, then rapid deterioration. Surgical emergency.',
          x: 0.80,
          y: 0.40,
        ),
        LayerAnnotation(
          label: 'Biconvex shape',
          detail:
              'CT shows lens-shaped (biconvex) hyperdensity. Does NOT cross '
              'suture lines because periosteal dura is fused at sutures. '
              'CAN cross the midline (unlike SDH).',
          x: 0.75,
          y: 0.55,
        ),
        LayerAnnotation(
          label: 'Lucid interval',
          detail:
              'Classic "talk and die" presentation occurs in ~50% of EDH. '
              'Patient may initially appear well after trauma, then '
              'decompensates as hematoma expands. Requires high suspicion '
              'with temporal bone fractures.',
          x: 0.68,
          y: 0.25,
        ),
      ],
    ),

    // ── Layer 2: Dura Mater ──
    AnatomyLayer(
      order: 2,
      name: 'Dura Mater',
      description:
          'Tough outer meningeal layer, bridging veins traverse to '
          'superior sagittal sinus',
      color: Color(0xFF818CF8), // indigo
      annotations: [
        LayerAnnotation(
          label: 'Bridging veins',
          detail:
              'Cortical veins bridge from brain surface through subdural '
              'space to drain into dural venous sinuses. Vulnerable to '
              'shearing from acceleration-deceleration injury. Tearing '
              'causes subdural hematoma (SDH).',
          x: 0.40,
          y: 0.15,
        ),
        LayerAnnotation(
          label: 'Dural reflections',
          detail:
              'Falx cerebri and tentorium cerebelli are dural folds. SDH '
              'does NOT cross the midline (falx) but DOES cross sutures '
              '(because it is deep to the dural-skull adhesion at sutures). '
              'This distinguishes SDH from EDH on CT.',
          x: 0.50,
          y: 0.50,
        ),
      ],
    ),

    // ── Layer 3: Subdural Space ──
    AnatomyLayer(
      order: 3,
      name: 'Subdural Space',
      description:
          'Between dura and arachnoid. SDH: crescent-shaped, bridging '
          'veins, crosses sutures but NOT midline',
      color: Color(0xFFF59E0B), // amber — venous
      annotations: [
        LayerAnnotation(
          label: 'Crescent shape',
          detail:
              'CT shows crescent-shaped (concavo-convex) hyperdensity that '
              'conforms to the brain surface. Crosses suture lines freely '
              'because it is below the dura. Does NOT cross midline because '
              'falx cerebri blocks spread.',
          x: 0.20,
          y: 0.40,
        ),
        LayerAnnotation(
          label: 'Acute vs Chronic',
          detail:
              'Acute SDH: hyperdense (white) on CT, <3 days. Subacute: '
              'isodense, 3-21 days. Chronic: hypodense (dark), >21 days. '
              'Chronic SDH common in elderly/alcoholics due to brain '
              'atrophy stretching bridging veins.',
          x: 0.22,
          y: 0.60,
        ),
        LayerAnnotation(
          label: 'Risk factors',
          detail:
              'Elderly, anticoagulant use, brain atrophy, alcoholism. '
              'Even minor trauma can cause SDH in these populations. '
              'Mortality for acute SDH is 60-80% — worst prognosis of '
              'all extra-axial hemorrhages.',
          x: 0.30,
          y: 0.75,
        ),
      ],
    ),

    // ── Layer 4: Arachnoid / Subarachnoid Space ──
    AnatomyLayer(
      order: 4,
      name: 'Arachnoid / Subarachnoid Space',
      description:
          'SAH: blood in sulci and cisterns, from cortical vessel '
          'disruption',
      color: Color(0xFF22D3EE), // cyan
      annotations: [
        LayerAnnotation(
          label: 'Blood in sulci',
          detail:
              'Traumatic SAH is the most common type of traumatic '
              'intracranial hemorrhage. CT shows hyperdensity in sulci '
              'and cisterns. May cause vasospasm (more common in '
              'aneurysmal SAH but can occur in traumatic SAH).',
          x: 0.35,
          y: 0.35,
        ),
        LayerAnnotation(
          label: 'Cisterns',
          detail:
              'Blood accumulates in basal cisterns (suprasellar, ambient, '
              'quadrigeminal). Effacement of basal cisterns on CT suggests '
              'elevated ICP — important prognostic indicator. '
              'CSF circulation may be impaired causing hydrocephalus.',
          x: 0.55,
          y: 0.65,
        ),
      ],
    ),

    // ── Layer 5: Brain Parenchyma ──
    AnatomyLayer(
      order: 5,
      name: 'Brain Parenchyma',
      description:
          'ICH: intraparenchymal hemorrhage, contusions at '
          'coup-contrecoup sites (inferior frontal, anterior temporal)',
      color: Color(0xFF34D399), // emerald green
      annotations: [
        LayerAnnotation(
          label: 'Contusions',
          detail:
              'Hemorrhagic contusions occur at coup (impact site) and '
              'contrecoup (opposite side) locations. Most common sites: '
              'inferior frontal lobes and anterior temporal lobes due to '
              'rough bone of anterior/middle cranial fossa floor.',
          x: 0.45,
          y: 0.45,
        ),
        LayerAnnotation(
          label: 'Contusion evolution',
          detail:
              'Contusions may "blossom" (expand) over 24-72 hours. '
              'Repeat CT indicated if neurological decline. '
              'Hemorrhagic progression of contusion (HPC) occurs in '
              '~50% of cases and may require surgical evacuation.',
          x: 0.55,
          y: 0.35,
        ),
        LayerAnnotation(
          label: 'Deep ICH',
          detail:
              'Basal ganglia and thalamic hemorrhages can occur from '
              'shearing of perforating arteries (lenticulostriate). '
              'Distinguished from hypertensive ICH by clinical context '
              '(trauma vs HTN history). May indicate DAI if punctate.',
          x: 0.48,
          y: 0.55,
        ),
      ],
    ),
  ],
  boardPearls: [
    // Pearl when both epidural and subdural are visible
    BoardPearl(
      requiredVisibleLayers: [1, 3],
      title: 'EDH vs SDH — Key CT Distinctions',
      content:
          'EDH: Biconvex (lens), does NOT cross sutures, CAN cross midline. '
          'Arterial (middle meningeal a.), lucid interval in ~50%.\n'
          'SDH: Crescent-shaped, DOES cross sutures, does NOT cross midline. '
          'Venous (bridging veins), worse prognosis (60-80% mortality acute).\n\n'
          'Mnemonic: EDH = "E" for "egg-shaped" (biconvex). '
          'SDH = "S" for "sickle/crescent."',
    ),
    // Pearl when skull + epidural visible
    BoardPearl(
      requiredVisibleLayers: [0, 1],
      title: 'Skull Fracture + EDH Association',
      content:
          'Skull fracture is present in ~90% of adult EDH cases. '
          'Linear temporal bone fractures crossing the middle meningeal '
          'artery groove carry highest risk. In pediatric patients, EDH '
          'can occur WITHOUT fracture due to calvarial deformability.\n\n'
          'Board Pearl: Any patient with temporal bone fracture and '
          'declining consciousness — think EDH until proven otherwise.',
    ),
    // Pearl when SAH + parenchyma visible
    BoardPearl(
      requiredVisibleLayers: [4, 5],
      title: 'SAH + Contusions = Severity Marker',
      content:
          'The combination of traumatic SAH with hemorrhagic contusions '
          'is associated with worse outcomes. SAH can cause vasospasm '
          '(monitor with TCDs). Contusions may "blossom" over 24-72 hours.\n\n'
          'Board Pearl: Traumatic SAH is the MOST COMMON type of traumatic '
          'intracranial hemorrhage, though often clinically overshadowed '
          'by associated injuries.',
    ),
    // Pearl when all layers visible
    BoardPearl(
      requiredVisibleLayers: [0, 1, 2, 3, 4, 5],
      title: 'Complete Layer Review — Surgical Indications',
      content:
          'EDH >30 mL or >15 mm thick or >5 mm midline shift: SURGICAL.\n'
          'Acute SDH >10 mm thick or >5 mm midline shift: SURGICAL.\n'
          'ICH >50 mL with GCS 6-8: consider surgery (STICH II criteria).\n'
          'SAH: Usually managed medically; watch for hydrocephalus.\n\n'
          'Marshall CT Classification: Grade I-VI based on cistern '
          'compression, midline shift, and mass lesion evacuation status.',
    ),
  ],
);
