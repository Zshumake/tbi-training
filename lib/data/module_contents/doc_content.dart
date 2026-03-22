import 'package:flutter/material.dart';
import '../models/topic_content_model.dart';

final TopicData docContent = TopicData(
  id: 'disorders-of-consciousness',
  title: 'Disorders of Consciousness',
  tabs: [
    TopicTab(
      title: 'DOC Classification',
      blocks: [
        HeaderBlock('Disorders of Consciousness: Definitions & Taxonomy'),
        TextBlock(
          'Disorders of consciousness (DOC) represent a spectrum of impaired awareness and wakefulness following severe brain injury. Accurate classification is critical for prognosis, treatment planning, and medicolegal decisions. Misdiagnosis rates remain alarmingly high (30-40%), making standardized assessment essential for board preparation and clinical practice.',
          isIntro: true,
        ),
        TableBlock(
          title: 'DOC Classification Spectrum',
          columns: ['State', 'Wakefulness', 'Awareness', 'Key Features'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'Coma',
              'Absent',
              'Absent',
              'No eye opening, no sleep-wake cycles on EEG, no purposeful behavior; GCS <= 8; typically lasts days to weeks',
            ],
            [
              'VS/UWS',
              'Present',
              'Absent',
              'Eyes open spontaneously, sleep-wake cycles present, NO purposeful behavior, startle response but no localization or tracking',
            ],
            [
              'MCS-',
              'Present',
              'Minimal (non-language)',
              'Visual fixation, visual pursuit, localization to noxious stimuli, contingent emotional responses; NO command-following',
            ],
            [
              'MCS+',
              'Present',
              'Minimal (language-dependent)',
              'Reproducible (but inconsistent) command-following, intelligible verbalization, intentional communication',
            ],
            [
              'Emergence from MCS',
              'Present',
              'Reliable',
              'CONSISTENT command-following, functional object use, OR reliable yes/no communication',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: MCS- vs MCS+',
          'MCS- is characterized by non-reflexive behaviors that do NOT require language processing (visual pursuit, fixation, localization to pain, object reaching, contingent emotional responses). MCS+ requires LANGUAGE-MEDIATED behaviors: consistent command-following, intelligible verbalization, or intentional communication. This distinction was introduced by Bruno et al. (2011) and is commonly tested.',
        ),
        HeaderBlock('Vegetative State (VS) / Unresponsive Wakefulness Syndrome (UWS)'),
        BulletCardBlock(
          title: 'VS/UWS Diagnostic Criteria',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Eyes open spontaneously or with stimulation (sleep-wake cycles present)',
            'NO sustained visual fixation or pursuit (> 2 seconds)',
            'NO reproducible purposeful behavior',
            'NO language comprehension or expression',
            'Intact brainstem reflexes (pupillary, oculocephalic, corneal, gag)',
            'Preserved autonomic functions (breathing, blood pressure, thermoregulation)',
            'Startle reflex present but NO localization to stimuli',
            'May exhibit reflexive posturing, oral reflexes, or non-purposeful movement',
          ],
        ),
        HeaderBlock('Timing Definitions for VS'),
        TableBlock(
          title: 'VS Temporal Classification',
          columns: ['Term', 'Duration', 'Clinical Significance'],
          rows: [
            [
              'Persistent VS',
              '>= 1 month after any brain injury',
              'Descriptive term only; does NOT imply permanence',
            ],
            [
              'Permanent VS (Traumatic)',
              '> 12 months after TBI',
              'Recovery of consciousness is exceedingly rare but documented',
            ],
            [
              'Permanent VS (Non-traumatic)',
              '> 3 months after anoxic/non-traumatic injury',
              'Prognosis significantly worse than traumatic etiology',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: Traumatic vs Non-Traumatic VS Prognosis',
          'VS after TBI has a BETTER prognosis than after anoxic injury. Approximately 52% of traumatic VS patients recover consciousness by 12 months (Multi-Society Task Force). Only 15% of non-traumatic VS patients recover consciousness by 12 months. For MCS, prognosis is substantially better: traumatic MCS patients may continue to show recovery for years after injury.',
        ),
        HeaderBlock('Minimally Conscious State (MCS)'),
        BulletCardBlock(
          title: 'CRS-R Behaviors That Indicate MCS',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFF0FDF4),
          points: [
            'Visual fixation (sustained > 2 seconds) -- MCS-',
            'Visual pursuit (smooth tracking of moving object/person) -- MCS-',
            'Localization to noxious stimulation (not reflexive withdrawal) -- MCS-',
            'Object reaching / touching (directed limb movement toward object) -- MCS-',
            'Contingent emotional responses (smiling/crying to appropriate stimuli, not random) -- MCS-',
            'Reproducible movement to command (inconsistent but clearly above chance) -- MCS+',
            'Intelligible verbalization (at least one recognizable word) -- MCS+',
            'Automatic motor responses (e.g., grasping a cup placed in hand) -- MCS-',
          ],
        ),
        HeaderBlock('Emergence from MCS'),
        BulletCardBlock(
          title: 'Criteria for Emergence (Must Demonstrate at Least ONE)',
          themeColor: const Color(0xFF2563EB),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Functional object use: Demonstrates knowledge of an object\'s function by using it appropriately (e.g., bringing a comb to hair, pen to paper)',
            'Functional accurate communication: Reliable yes/no responses to basic orientation questions (6 of 6 correct on 2 consecutive evaluations on CRS-R)',
          ],
        ),
        PearlBlock(
          'Board Pearl: Misdiagnosis Rate',
          'Studies consistently show a 30-40% misdiagnosis rate when VS is diagnosed by clinical impression alone without standardized behavioral assessment. The most common error is diagnosing VS in a patient who is actually in MCS. The CRS-R reduces this error rate dramatically and is the recommended assessment tool per the ACRM DOC Task Force (2010, updated 2018).',
        ),
        HeaderBlock('Locked-In Syndrome: The Critical Differential'),
        ComparisonCardBlock(
          title: 'Locked-In Syndrome vs Vegetative State',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          icon: Icons.warning_amber_rounded,
          description:
              'Locked-in syndrome (LIS) is NOT a disorder of consciousness. The patient is FULLY AWARE but completely paralyzed except for vertical eye movements and blinking. Caused by ventral pontine lesion (basilar artery occlusion most common). FOUR Score can distinguish LIS from VS because it assesses eye tracking.',
          keyPoints: [
            'Etiology: Ventral pontine lesion (basilar artery thrombosis/occlusion most common)',
            'Cognition: FULLY INTACT -- patient is aware and can think, feel, and perceive',
            'Communication: ONLY via vertical eye movements and blinking',
            'EEG: NORMAL or near-normal alpha rhythm (vs. VS which shows diffuse slowing)',
            'FOUR Score advantage: Detects eye tracking (score 4 on eye component) vs. GCS which cannot distinguish LIS from VS',
            'Must be excluded before diagnosing VS -- failure to recognize LIS is a devastating diagnostic error',
          ],
        ),
        HeaderBlock('Cognitive Motor Dissociation (CMD): Covert Consciousness'),
        TextBlock(
          'Cognitive motor dissociation (CMD) describes patients who demonstrate brain activation on task-based fMRI or EEG (indicating awareness and command comprehension) WITHOUT any behavioral evidence of command-following at the bedside. These patients appear unresponsive but are covertly conscious. CMD has transformed the understanding of DOC and has major prognostic and ethical implications.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Claassen et al. NEJM 2019 — Detection in Acute Brain Injury',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Study: 104 patients with acute brain injury assessed with EEG-based motor imagery paradigms in the ICU',
            '15% of clinically unresponsive patients showed EEG evidence of brain activation to spoken motor commands',
            'EEG paradigm: Patients asked to "keep opening and closing your right hand" — brain activation detected by machine learning algorithms analyzing EEG patterns',
            'Patients with CMD had BETTER functional outcomes at 12 months than those without CMD',
            'Key implication: CMD assessment in the ICU may influence decisions about withdrawal of life-sustaining treatment',
          ],
        ),
        BulletCardBlock(
          title: 'Claassen et al. NEJM 2024 — Landmark Multicenter Study',
          themeColor: const Color(0xFF2563EB),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Largest CMD study to date: 241 patients with DOC assessed with task-based fMRI and/or EEG across 6 international centers',
            '25% of behaviorally unresponsive patients demonstrated CMD (covert awareness)',
            'Detection methods: 11 detected by fMRI only, 13 by EEG only, 36 by BOTH modalities',
            'CMD was more common in: younger patients, traumatic (vs anoxic) etiology, longer time since injury',
            '38% of patients WITH behavioral command-following also showed task-based brain activation (confirmatory)',
            'Implication: 1 in 4 apparently unresponsive brain-injured patients may be covertly conscious',
          ],
        ),
        PearlBlock(
          'Board Pearl: CMD and Clinical Decision-Making',
          'CMD occurs in approximately 15-25% of patients who appear behaviorally unresponsive. Detection requires task-based fMRI ("imagine playing tennis" or "imagine walking through your house") or EEG motor imagery paradigms. CMD patients have BETTER prognosis than non-CMD patients at the same behavioral level. This has profound implications for withdrawal-of-care decisions: a patient diagnosed as VS on behavioral exam may actually be covertly aware. The AAN/ACRM 2018 guidelines recommend considering advanced neuroimaging/electrophysiology when available.',
        ),
        HeaderBlock('AAN/ACRM/NIDILRR Practice Guidelines (2018)'),
        TextBlock(
          'The 2018 joint guidelines from AAN, ACRM, and NIDILRR updated the 1995 Multi-Society Task Force report. They provide evidence-based recommendations for diagnosis, prognosis, and treatment of prolonged DOC. These are the current standard-of-care guidelines tested on board exams.',
        ),
        BulletCardBlock(
          title: 'Key Guideline Recommendations',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFF0FDF4),
          points: [
            'Level B: Use standardized neurobehavioral assessment tools (CRS-R recommended) to improve diagnostic accuracy over clinical impression alone',
            'Level B: Perform SERIAL standardized assessments, especially in the first 3 months post-injury, to account for fluctuating consciousness',
            'Minimum 5 evaluations recommended (Wannez et al. 2017) — single assessments miss up to 40% of MCS patients',
            'Level B: Identify and treat confounders that may suppress behavioral responses (sedating medications, pain, infection, metabolic derangements, subclinical seizures)',
            'Level B: Amantadine 100-200 mg BID for patients in VS or MCS 4-16 weeks post-TBI (Giacino 2012 trial)',
            'Assess across multiple times of day to capture peak arousal',
            'Consider advanced neuroimaging (fMRI, PET) when behavioral assessments are inconclusive and when results may affect treatment decisions',
          ],
        ),
        PearlBlock(
          'Board Pearl: The "5 Assessment" Rule',
          'Wannez et al. (2017) demonstrated that at least 5 CRS-R assessments are needed to achieve optimal diagnostic sensitivity. A single CRS-R assessment misses approximately 36% of patients who are actually in MCS. The false-negative rate drops to <5% with 5 or more assessments across different times of day. This finding underlies the AAN/ACRM recommendation for serial assessments and is board-testable.',
        ),
        HeaderBlock('Prognostic Biomarkers in DOC'),
        TableBlock(
          title: 'Electrophysiologic and Neuroimaging Prognostic Markers',
          columns: ['Modality', 'Finding', 'Prognostic Significance'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'SSEP (N20)',
              'Bilateral ABSENCE of cortical N20 response',
              'Most reliable predictor of non-recovery in ANOXIC injury (near 0% false positive rate). Less reliable in traumatic DOC where recovery despite absent N20 has been reported.',
            ],
            [
              'EEG Reactivity',
              'Presence of EEG background reactivity to external stimuli',
              'EEG reactivity present = favorable sign for recovery. Absent reactivity with suppressed/flat background = poor prognosis. Sleep spindles on EEG associated with better outcomes.',
            ],
            [
              'MRI (Structural)',
              'Extent of corpus callosum/brainstem/thalamic injury',
              'Diffuse axonal injury severity on MRI correlates with DOC duration. Brainstem and bilateral thalamic lesions = worst prognosis.',
            ],
            [
              'DTI (Diffusion Tensor Imaging)',
              'Fractional anisotropy (FA) in white matter tracts',
              'Reduced FA in corpus callosum, thalamocortical tracts, and ascending reticular activating system correlates with poorer consciousness recovery.',
            ],
            [
              'FDG-PET',
              'Global cortical metabolic rate',
              'Cortical metabolism >42% of normal associated with MCS; <42% associated with VS. Best single neuroimaging predictor of consciousness level.',
            ],
            [
              'fMRI (Task-based)',
              'Brain activation to motor imagery or spatial navigation commands',
              'Detects CMD (covert awareness) in 15-25% of behaviorally unresponsive patients. Presence predicts better functional outcome.',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: N20 SSEP — Etiology Matters',
          'Bilateral absence of cortical N20 SSEP has near-100% specificity for poor outcome (death or VS) in post-ANOXIC injury. However, in TRAUMATIC DOC, absent N20 is less reliable — recovery of consciousness has been reported despite bilaterally absent N20. This is because traumatic DOC involves focal white matter injury rather than global cortical necrosis. Always specify the etiology when interpreting SSEP prognostic data.',
        ),
      ],
    ),
    TopicTab(
      title: 'CRS-R Assessment',
      blocks: [
        HeaderBlock('Coma Recovery Scale - Revised (CRS-R)'),
        TextBlock(
          'The CRS-R is the gold standard standardized neurobehavioral assessment for differentiating VS/UWS from MCS and for tracking recovery through the DOC spectrum. Developed by Giacino, Kalmar, and Whyte (2004), it consists of 23 items organized into 6 hierarchically arranged subscales. The ACRM DOC Task Force recommends it as the primary assessment instrument.',
          isIntro: true,
        ),
        ScaleBlock(
          scaleName: 'Auditory Function Scale',
          description:
              'Assesses auditory processing from reflexive startle to consistent command-following. Command-following (score 3-4) is a key MCS+ criterion.',
          columns: ['Score', 'Response', 'DOC Implication'],
          rows: [
            ['4', 'Consistent movement to command', 'MCS+ (language-dependent)'],
            ['3', 'Reproducible movement to command', 'MCS+ (language-dependent)'],
            ['2', 'Localization to sound', 'MCS-'],
            ['1', 'Auditory startle', 'VS/UWS compatible'],
            ['0', 'None', 'VS/UWS or Coma'],
          ],
          boardPearl:
              'Consistent vs reproducible: "consistent" (score 4) means correct response on ALL trials within a single assessment. "Reproducible" (score 3) means correct on at least 2 of 4 trials. Both indicate MCS+.',
        ),
        ScaleBlock(
          scaleName: 'Visual Function Scale',
          description:
              'Assesses visual processing from startle to object recognition. Visual pursuit (score 3) and fixation (score 2) are key MCS- markers. Object recognition (score 5) indicates MCS+.',
          columns: ['Score', 'Response', 'DOC Implication'],
          rows: [
            ['5', 'Object recognition (matches objects)', 'MCS+'],
            ['4', 'Object localization (reaches toward object)', 'MCS-'],
            ['3', 'Visual pursuit (tracking)', 'MCS-'],
            ['2', 'Fixation (sustained > 2 sec)', 'MCS-'],
            ['1', 'Visual startle', 'VS/UWS compatible'],
            ['0', 'None', 'VS/UWS or Coma'],
          ],
          boardPearl:
              'Visual pursuit is the single most common behavior that distinguishes MCS from VS on the CRS-R. It must be smooth, sustained tracking -- not saccadic or reflexive. Test with a mirror (most sensitive stimulus) held 6-8 inches from face.',
        ),
        ScaleBlock(
          scaleName: 'Motor Function Scale',
          description:
              'Assesses motor behavior from none to functional object use. Functional object use (score 6) is a criterion for EMERGENCE from MCS.',
          columns: ['Score', 'Response', 'DOC Implication'],
          rows: [
            ['6', 'Functional object use', 'EMERGED from MCS'],
            ['5', 'Automatic motor response', 'MCS-'],
            ['4', 'Object manipulation', 'MCS-'],
            ['3', 'Localization to noxious stimulation', 'MCS-'],
            ['2', 'Flexion withdrawal', 'VS/UWS compatible'],
            ['1', 'Abnormal posturing', 'VS/UWS or Coma'],
            ['0', 'None/flaccid', 'Coma'],
          ],
          boardPearl:
              'Localization to noxious stimulation (score 3) requires the limb to CROSS MIDLINE or reach above the clavicle to contact the stimulus. Simple withdrawal (pulling away) is only a score of 2 and is compatible with VS.',
        ),
        ScaleBlock(
          scaleName: 'Oromotor/Verbal Function Scale',
          description:
              'Assesses oral motor and verbal behavior. Intelligible verbalization (score 3) is an MCS+ criterion and indicates emergence if functional.',
          columns: ['Score', 'Response', 'DOC Implication'],
          rows: [
            ['3', 'Intelligible verbalization', 'MCS+ (or emergence if functional communication)'],
            ['2', 'Vocalization/oral movement', 'MCS-'],
            ['1', 'Oral reflexive movement', 'VS/UWS compatible'],
            ['0', 'None', 'VS/UWS or Coma'],
          ],
          boardPearl:
              'Intelligible verbalization means at least one clearly recognizable word. It does not have to be contextually appropriate to indicate MCS+. However, functional ACCURATE communication (reliable yes/no) indicates emergence.',
        ),
        ScaleBlock(
          scaleName: 'Communication Scale',
          description:
              'Assesses intentional communication. Functional accurate communication (score 2) is a criterion for EMERGENCE from MCS.',
          columns: ['Score', 'Response', 'DOC Implication'],
          rows: [
            ['2', 'Functional: accurate', 'EMERGED from MCS'],
            ['1', 'Non-functional: intentional', 'MCS+'],
            ['0', 'None', 'VS/UWS or Coma'],
          ],
          boardPearl:
              'Functional accurate communication requires correct yes/no responses to 6 of 6 basic situational orientation questions on 2 consecutive assessments. This is one of only two criteria for emergence from MCS (the other is functional object use on the Motor subscale).',
        ),
        ScaleBlock(
          scaleName: 'Arousal Scale',
          description:
              'Assesses level of arousal and attention. This is a facilitatory subscale -- if the patient is not sufficiently aroused, other subscales cannot be accurately assessed.',
          columns: ['Score', 'Response', 'Clinical Note'],
          rows: [
            ['3', 'Attention', 'Sustained attention to task/examiner'],
            ['2', 'Eye opening without stimulation', 'Spontaneous eye opening, sleep-wake cycles'],
            ['1', 'Eye opening WITH stimulation', 'Opens eyes only to stimulation'],
            ['0', 'Unarousable', 'No eye opening even with deep stimulation'],
          ],
          boardPearl:
              'The CRS-R should be administered at least 5 times across different times of day to minimize false negatives. A single assessment may miss fluctuating consciousness. Administer when the patient is at peak arousal.',
        ),
        PearlBlock(
          'Board Pearl: CRS-R Total Score Range',
          'Total CRS-R score ranges from 0 to 23. However, the TOTAL SCORE is less important than the SUBSCALE SCORES for diagnosis. A patient could have a relatively low total score but demonstrate one key behavior (e.g., visual pursuit) that changes the diagnosis from VS to MCS. Always look at the highest score on each subscale, not just the total.',
        ),
      ],
    ),
    TopicTab(
      title: 'Treatment & Trials',
      blocks: [
        HeaderBlock('Giacino et al. NEJM 2012: The Landmark Amantadine Trial'),
        TextBlock(
          'This is the single most important and most commonly tested pharmacological trial in TBI rehabilitation. It provides the ONLY Class I evidence for a drug intervention to accelerate recovery from disorders of consciousness after severe TBI.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Study Design',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Multi-center, double-blind, placebo-controlled RCT',
            '184 patients enrolled: amantadine (n=87) vs placebo (n=97)',
            '11 US sites and 6 European sites (NIDRR TBI Model Systems centers)',
            'Population: Age 16-65, non-penetrating TBI, 4-16 WEEKS post-injury',
            'Enrolled patients in vegetative state (VS) or minimally conscious state (MCS)',
            'DRS score >= 12 at enrollment (severe disability)',
            'Primary outcome: Rate of DRS score change over 4-week treatment period',
          ],
        ),
        TableBlock(
          title: 'Amantadine Dosing Protocol',
          columns: ['Timepoint', 'Dose', 'Notes'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            ['Weeks 1-2', '100 mg BID (200 mg/day)', 'Starting dose; second dose given by 12:00 PM (noon) to avoid insomnia'],
            ['Weeks 3-4', '150 mg BID (300 mg/day)', 'Increase if insufficient response'],
            ['Maximum', '200 mg BID (400 mg/day)', 'Do not exceed; adjust for renal impairment'],
            ['Weeks 5-6', 'Taper/washout', '2-week washout period to assess drug vs disease effect'],
          ],
        ),
        HeaderBlock('Key Results'),
        BulletCardBlock(
          title: 'Treatment Period (Weeks 0-4)',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFF0FDF4),
          points: [
            'Amantadine group: SIGNIFICANTLY faster DRS improvement (p = 0.007)',
            'Treatment effect: ~0.24 DRS points/week faster recovery in amantadine group',
            'Effect was CONSISTENT across both VS and MCS subgroups',
            'Both behavioral and functional improvements observed',
          ],
        ),
        BulletCardBlock(
          title: 'Washout Period (Weeks 4-6)',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Placebo group showed FASTER recovery during washout',
            'Amantadine group showed SLOWING of recovery after discontinuation',
            'Groups CONVERGED by week 6 -- no significant difference at study end',
            'Interpretation: Benefit is a DIRECT pharmacological effect, NOT disease-modifying',
            'Implication: Ongoing treatment may be needed to maintain benefit',
          ],
        ),
        PearlBlock(
          'Board Pearl: The Washout Finding',
          'The washout finding is the most commonly tested aspect of this trial. The fact that recovery slowed when amantadine was stopped and the groups converged by week 6 indicates amantadine has a DIRECT PHARMACOLOGICAL EFFECT on neurotransmission rather than altering the underlying trajectory of recovery. In clinical practice, amantadine is often continued beyond 4 weeks based on this reasoning.',
        ),
        HeaderBlock('Amantadine Mechanism & Comparators'),
        TableBlock(
          title: 'Dopaminergic Agents in TBI: Mechanism Comparison',
          columns: ['Drug', 'Mechanism', 'Board Distinction'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            ['Amantadine', 'Releases preformed DA from presynaptic terminals; weak NMDA antagonist', 'Increases EXOGENOUS dopamine; Level B recommendation for DOC'],
            ['Bromocriptine', 'Direct D2 receptor agonist', 'Increases ENDOGENOUS dopamine; used for executive dysfunction, akinetic mutism'],
            ['Methylphenidate', 'Blocks DAT and NET reuptake', 'Blocks REUPTAKE of DA/NE; first-line for attention deficits'],
            ['Levodopa/Carbidopa', 'Converted to dopamine by DOPA decarboxylase', 'Increases EXOGENOUS dopamine; used for arousal/initiation'],
          ],
        ),
        MnemonicBlock(
          'Dopaminergic Agents: "A BLM"',
          'Amantadine = releases preformed (Exogenous) DA. Bromocriptine = direct D2 agonist (Endogenous). Levodopa = converted to DA (Exogenous). Methylphenidate = blocks reuptake (NET/DAT blocker). Know these distinctions -- they are tested repeatedly.',
        ),
        HeaderBlock('Prognosis in Disorders of Consciousness'),
        TableBlock(
          title: 'Recovery Rates by Etiology and Diagnosis',
          columns: ['Condition', '3 Months', '6 Months', '12 Months'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            ['Traumatic VS', '33% recover consciousness', '46% recover consciousness', '52% recover consciousness'],
            ['Non-traumatic VS', '11% recover consciousness', '13% recover consciousness', '15% recover consciousness'],
            ['Traumatic MCS', 'Better than VS at all timepoints', 'Continued recovery common', 'Recovery may continue for years'],
            ['Non-traumatic MCS', 'Better than non-traumatic VS', 'Plateau earlier than traumatic', 'Less late recovery than traumatic'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Prognostic Factors in DOC',
          'Favorable prognostic signs: traumatic (vs anoxic) etiology, younger age, MCS (vs VS), evidence of visual pursuit or command-following on CRS-R, preserved cortical metabolism on FDG-PET, intact thalamocortical connectivity on fMRI. Unfavorable signs: bilateral absence of cortical N20 on SSEP (most reliable predictor of non-recovery in anoxic injury), anoxic etiology, prolonged VS > 3 months.',
        ),
        HeaderBlock('Emerging Therapies for DOC'),
        BulletCardBlock(
          title: 'Novel Interventions Under Investigation',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Zolpidem paradox: In rare cases (6-7% of VS/MCS patients), zolpidem (a GABA-A agonist/sedative) paradoxically produces transient arousal and improved responsiveness lasting 1-4 hours; mechanism may involve GABA-mediated disinhibition of thalamocortical circuits; response is dramatic but unpredictable and not sustained',
            'Transcranial direct current stimulation (tDCS): Applied to left dorsolateral prefrontal cortex (DLPFC); Thibaut et al. (2014) showed improved CRS-R scores in MCS patients; generally safe, non-invasive; evidence strongest for MCS, limited for VS',
            'Low-intensity focused ultrasound (LIFU): Non-invasive neuromodulation targeting thalamus; can penetrate deep brain structures; early case reports showing transient improvement in consciousness; mechanism involves mechanical stimulation of neural tissue',
            'Deep brain stimulation (DBS): Schiff et al. (2007) showed behavioral improvements with bilateral central thalamic DBS in a single MCS patient; highly invasive; remains experimental',
            'Median nerve stimulation: Peripheral nerve stimulation may increase arousal via reticular activating system; some evidence for accelerated emergence from coma',
          ],
        ),
        PearlBlock(
          'Board Pearl: The Zolpidem Paradox',
          'The zolpidem paradox is frequently tested. A GABA-A modulator (normally a sedative) paradoxically improves consciousness in a small subset (6-7%) of DOC patients. The proposed mechanism involves GABAergic inhibition of overactive inhibitory globus pallidus neurons, leading to disinhibition of the thalamus and restoration of thalamocortical signaling. The effect is transient (1-4 hours per dose) and not all patients respond. A zolpidem challenge is sometimes performed as a diagnostic/therapeutic trial.',
        ),
        HeaderBlock('Emerging Neuromodulation Therapies: Evidence Summary'),
        TableBlock(
          title: 'Neuromodulation for DOC — Key Studies and Evidence',
          columns: ['Therapy', 'Investigators', 'Target', 'Evidence Level', 'Key Findings'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'tDCS (Transcranial Direct Current Stimulation)',
              'Thibaut et al. (2014, 2017)',
              'Left DLPFC (dorsolateral prefrontal cortex)',
              'Class II (sham-controlled crossover)',
              'Significant CRS-R improvement in MCS patients but NOT VS patients. Effect did not persist at 1-year follow-up. 2 mA for 20 min, 5 consecutive days. Safe and non-invasive.',
            ],
            [
              'LIFU (Low-Intensity Focused Ultrasound)',
              'Monti et al. (UCLA, 2016+)',
              'Thalamus (central lateral nucleus)',
              'Case series/Pilot studies',
              'Non-invasive deep brain stimulation via acoustic energy. Monti (2016): dramatic recovery in single chronic DOC patient after thalamic LIFU. Can penetrate skull to reach deep targets. Larger trials underway.',
            ],
            [
              'DBS (Deep Brain Stimulation)',
              'Schiff et al. (2007)',
              'Central thalamus (intralaminar nuclei)',
              'Single case study (NEJM)',
              'Bilateral thalamic DBS in MCS patient 6 years post-injury produced reproducible improvements in arousal, communication, and limb movement. Highly invasive, requires surgical implantation. Remains experimental.',
            ],
            [
              'Vagus Nerve Stimulation (VNS)',
              'Corazzol et al. (2017)',
              'Left vagus nerve',
              'Single case study (Current Biology)',
              'VS patient 15 years post-injury showed improvement to MCS after VNS. Enhanced EEG theta power and increased metabolic activity on PET. Less invasive than DBS.',
            ],
            [
              'Median Nerve Stimulation',
              'Various investigators',
              'Median nerve at wrist (peripheral)',
              'Small RCTs',
              'May accelerate emergence from coma via ascending reticular activating system. Non-invasive and low-cost. Evidence limited but supportive of early arousal facilitation.',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: tDCS in DOC',
          'Thibaut et al. demonstrated that tDCS applied to the LEFT DLPFC improves CRS-R scores in MCS patients but NOT in VS patients. This differential response supports the concept that MCS patients have preserved but dysfunctional thalamocortical networks that can be augmented, while VS patients lack the neural substrate to respond. The left DLPFC target and MCS-specific efficacy are testable details.',
        ),
        PearlBlock(
          'Board Pearl: LIFU vs DBS for DOC',
          'LIFU (Monti, UCLA) offers NON-INVASIVE deep brain stimulation with high spatial precision targeting the thalamus. DBS (Schiff, 2007) achieves the same thalamic target but requires INVASIVE surgical electrode implantation. Both target central thalamic structures to restore thalamocortical connectivity. LIFU is the more promising emerging technology because it combines deep targeting with non-invasiveness. DBS remains the proof-of-concept that thalamic stimulation can improve consciousness in DOC.',
        ),
        HeaderBlock('Legal and Ethical Framework in DOC'),
        TextBlock(
          'Disorders of consciousness raise unique medicolegal challenges. The intersection of clinical uncertainty (30-40% misdiagnosis rate), prognostic limitations, and life-sustaining treatment decisions makes this a high-stakes ethical domain tested on board exams.',
        ),
        BulletCardBlock(
          title: 'Key Legal Precedents',
          themeColor: const Color(0xFF1B2A4A),
          backgroundColor: const Color(0xFFF1F5F9),
          points: [
            'Quinlan (1976, NJ): First case establishing right to withdraw ventilator in VS. Court ruled that the right to privacy extends to decisions about life-sustaining treatment for incapacitated patients.',
            'Cruzan (1990, US Supreme Court): Established the requirement for CLEAR AND CONVINCING evidence of patient wishes before withdrawing nutrition/hydration. States may impose this evidentiary standard.',
            'Schiavo (1998-2005, FL): 15-year VS after anoxic injury. Prolonged legal battle between husband (substitute judgment — she would not want to live this way) and parents (best interest — continued care). Highlighted importance of written advance directives.',
            'Key legal lesson: Written advance directives are extremely difficult to overturn. Oral statements require clear and convincing evidence. The Schiavo case would likely not have occurred if Terri had a written living will.',
          ],
        ),
        TableBlock(
          title: 'Surrogate Decision-Making Standards',
          columns: ['Standard', 'Definition', 'When Applied', 'Strength'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'Expressed Wishes',
              'Patient\'s own written advance directive or clear oral statements',
              'Patient previously documented or clearly stated preferences',
              'STRONGEST -- most legally protected; very difficult to override',
            ],
            [
              'Substituted Judgment',
              'What would THIS patient have wanted based on their known values, beliefs, and prior statements?',
              'Patient did not leave explicit directive but there is knowledge of their values',
              'Moderate -- requires evidence of patient\'s values; subject to dispute',
            ],
            [
              'Best Interest',
              'What would a reasonable person want in this situation? Weighing burdens vs benefits of treatment.',
              'No knowledge of patient\'s wishes or values is available',
              'WEAKEST -- most subjective; used as default when no other information exists',
            ],
          ],
        ),
        BulletCardBlock(
          title: 'POLST vs Advance Directive in DOC',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFF0FDF4),
          points: [
            'Advance Directive (Living Will): Completed by patient when competent; describes general wishes about life-sustaining treatment; does NOT require physician signature; may be vague or not applicable to specific clinical scenarios',
            'POLST (Physician Orders for Life-Sustaining Treatment): Completed WITH physician; generates ACTIONABLE medical orders (DNR, comfort care, antibiotics, feeding); brightly colored form that travels with the patient; more specific than advance directive',
            'Healthcare Proxy/Durable Power of Attorney for Health Care: Designates a SPECIFIC PERSON to make decisions; the surrogate uses substituted judgment or best interest standard',
            'In DOC specifically: The distinction between VS and MCS has legal significance — some state statutes (e.g., Florida) specify "persistent vegetative state" for withdrawal of nutrition/hydration but do NOT address MCS',
            'CMD raises new ethical dilemmas: If a patient is covertly aware (CMD), withdrawal of life-sustaining treatment raises different ethical considerations than if the patient is truly unaware',
          ],
        ),
        PearlBlock(
          'Board Pearl: Legal Implications of CMD',
          'The discovery of cognitive motor dissociation (CMD) has disrupted established ethical frameworks for DOC. If 25% of behaviorally unresponsive patients are covertly aware, decisions to withdraw life-sustaining treatment based on behavioral assessment alone may be ethically insufficient. The AAN/ACRM 2018 guidelines recommend considering advanced neuroimaging when results may affect treatment decisions. Expect board questions that test the intersection of CMD, prognostication, and withdrawal-of-care ethics.',
        ),
      ],
    ),
  ],
);
