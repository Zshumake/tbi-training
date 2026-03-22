import 'package:flutter/material.dart';
import '../models/topic_content_model.dart';

final TopicData medicalComplicationsContent = TopicData(
  id: 'medical-complications',
  title: 'Medical Complications of TBI',
  tabs: [
    TopicTab(
      title: 'Seizures & Hydrocephalus',
      blocks: [
        HeaderBlock('Posttraumatic Seizures (PTS)'),
        TextBlock(
          'Posttraumatic seizures are one of the most commonly tested TBI complications on the PM&R board exam. Understanding the temporal classification, risk factors, prophylaxis evidence, and long-term management is essential. The Temkin trial (1990) and subsequent studies form the evidence base for current practice.',
          isIntro: true,
        ),
        TableBlock(
          title: 'PTS Temporal Classification',
          columns: ['Category', 'Timing', 'Clinical Significance', 'Prophylaxis Effective?'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'Immediate PTS',
              '< 24 hours',
              'Impact seizures; generally benign; may be provoked by acute metabolic derangement',
              'Yes (phenytoin or levetiracetam)',
            ],
            [
              'Early PTS',
              '24 hours to 7 days',
              'Due to acute pathophysiology (edema, hemorrhage, metabolic dysfunction); increased risk of status epilepticus',
              'Yes (phenytoin or levetiracetam)',
            ],
            [
              'Late PTS',
              '> 7 days',
              'Defines POSTTRAUMATIC EPILEPSY if recurrent; due to cortical reorganization, gliosis, neuronal network changes',
              'NO -- prophylaxis NOT effective',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: The 7-Day Rule',
          'Phenytoin (and levetiracetam) reduce EARLY PTS (within 7 days) but NOT late PTS (after 7 days). AED prophylaxis should be used for 7 DAYS ONLY. Continuing prophylaxis beyond 1 week has NO evidence of benefit and exposes patients to adverse cognitive effects. This is the Temkin trial (1990) finding and is tested repeatedly.',
        ),
        HeaderBlock('Seizure Incidence by TBI Severity'),
        TableBlock(
          title: 'PTS Risk by Injury Severity',
          columns: ['TBI Severity', 'Overall PTS Incidence', 'Late PTS Risk'],
          rows: [
            ['Mild TBI', '1.5%', 'Very low (< 1%)'],
            ['Moderate TBI', '2.9%', '~2%'],
            ['Severe TBI', '17%', '10-17%'],
            ['Penetrating TBI', '33-50%', '33-50% (highest risk)'],
          ],
        ),
        HeaderBlock('Risk Factors for Late PTS'),
        BulletCardBlock(
          title: 'Risk Factors with Approximate Incidence',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Penetrating head injury: 33-50% incidence of late PTS (HIGHEST risk factor)',
            'Intracranial hematoma (EDH, SDH, IPH): 25-30%',
            'Early PTS (seizure within first week): 25% risk of developing late PTS',
            'Depressed skull fracture: 3-70% (wide range depending on depression depth and dural penetration)',
            'Prolonged coma (> 24 hours) or PTA (> 24 hours): up to 35%',
            'Cortical contusion (especially temporal and frontal): significantly elevated risk',
            'GCS < 10: significantly increased risk',
            'Age > 65 years: elevated risk (possibly due to comorbid vascular disease)',
          ],
        ),
        HeaderBlock('Seizure Prophylaxis: The Evidence'),
        TableBlock(
          title: 'Phenytoin vs Levetiracetam for PTS Prophylaxis',
          columns: ['Parameter', 'Phenytoin', 'Levetiracetam'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            ['Efficacy (early PTS)', 'Effective (Temkin 1990)', 'Effective (non-inferior)'],
            ['Efficacy (late PTS)', 'NOT effective', 'NOT effective'],
            ['Drug level monitoring', 'Required (narrow therapeutic index)', 'NOT required (wide therapeutic index)'],
            ['Drug interactions', 'Many (CYP450 inducer)', 'Few (renal excretion)'],
            ['Cognitive side effects', 'Significant (impairs attention, processing speed)', 'Minimal'],
            ['Effect on recovery', 'May IMPEDE neurological recovery with chronic use', 'Less impact on recovery'],
            ['BTF recommendation', 'Level IIA (7-day prophylaxis)', 'Insufficient evidence to prefer over phenytoin'],
            ['Current practice trend', 'Declining use', 'Increasingly preferred'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Temkin Trial Key Facts',
          'Temkin et al. (NEJM 1990): Phenytoin vs placebo in 404 patients with severe TBI. Phenytoin reduced early PTS from 14.2% to 3.6% (p < 0.001). NO benefit for late PTS (27.5% vs 21.1%, p = NS). This established the 7-day prophylaxis standard. BTF 4th Edition: Level IIA recommendation for phenytoin to decrease early PTS incidence.',
        ),
        HeaderBlock('Posttraumatic Hydrocephalus (PTH)'),
        TextBlock(
          'Ventriculomegaly is common after severe TBI (40-72% on imaging), but true posttraumatic hydrocephalus requiring treatment occurs in only 3.9-8% of cases. Distinguishing true PTH from ex vacuo ventriculomegaly (passive ventricular dilation from brain atrophy) is critical.',
        ),
        BulletCardBlock(
          title: 'PTH Classification',
          themeColor: const Color(0xFF0D9488),
          backgroundColor: const Color(0xFFF0FDFA),
          points: [
            'Communicating (most common in TBI): Obstruction at arachnoid granulations from blood products/protein; CSF circulates through ventricles but is not absorbed; presents as normal pressure hydrocephalus (NPH)',
            'Non-communicating (obstructive): Physical blockage within the ventricular system (e.g., intraventricular hemorrhage blocking foramen of Monro or aqueduct); presents acutely with elevated ICP; requires urgent intervention',
          ],
        ),
        HeaderBlock('NPH Triad (Hakim-Adams Syndrome)'),
        BulletCardBlock(
          title: 'Classic Triad: "Wet, Wacky, and Wobbly"',
          themeColor: const Color(0xFF6366F1),
          backgroundColor: const Color(0xFFEEF2FF),
          points: [
            'Gait disturbance (FIRST and most responsive to treatment): Magnetic, wide-based, shuffling gait; "feet stuck to floor"',
            'Urinary incontinence (SECOND most responsive to treatment): Often preceded by urgency/frequency',
            'Dementia (LEAST responsive to shunting): Subcortical pattern with psychomotor slowing, apathy, inattention',
          ],
        ),
        MnemonicBlock(
          'NPH Triad: "Wet, Wacky, Wobbly"',
          'Wet = urinary incontinence, Wacky = dementia, Wobbly = gait disturbance. Gait is the FIRST symptom and MOST responsive to VP shunt placement. Dementia is the LEAST responsive to treatment.',
        ),
        HeaderBlock('CT Findings in PTH vs Ex Vacuo'),
        TableBlock(
          title: 'Distinguishing PTH from Atrophy',
          columns: ['Finding', 'True PTH', 'Ex Vacuo (Atrophy)'],
          rows: [
            ['Ventricular dilation', 'Uniform, all ventricles dilated', 'Proportional to sulcal widening'],
            ['Periventricular lucency', 'PRESENT (transependymal CSF flow)', 'Absent'],
            ['Sulcal effacement', 'PRESENT (compressed sulci)', 'Widened sulci (brain volume loss)'],
            ['Temporal horn dilation', 'EARLY and prominent', 'Proportional'],
            ['Evans index (frontal horn/biparietal ratio)', '> 0.30 (supports hydrocephalus)', 'May be elevated but with proportional atrophy'],
            ['CSF flow void on MRI', 'Accentuated flow void at aqueduct', 'Normal flow'],
          ],
        ),
        PearlBlock(
          'Board Pearl: PTH Diagnosis and Treatment',
          'Periventricular lucency (transependymal CSF migration) on CT is the key finding distinguishing true PTH from ex vacuo ventriculomegaly. The diagnostic algorithm: suspect PTH if clinical plateau or decline with ventriculomegaly, then perform high-volume lumbar puncture (30-50 mL) and reassess gait/cognition. If improvement occurs, proceed to VP shunt placement. Treatment: ventriculoperitoneal (VP) shunt.',
        ),
      ],
    ),
    TopicTab(
      title: 'HO & VTE',
      blocks: [
        HeaderBlock('Heterotopic Ossification (HO) in TBI'),
        TextBlock(
          'Heterotopic ossification is the formation of mature lamellar bone in soft tissues surrounding joints. It is a significant rehabilitation complication in TBI, occurring in 10-20% of patients with clinically significant disease and up to 76% on radiographic screening. Understanding the timing, diagnosis, and management is high-yield for boards.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Key Facts About HO in TBI',
          themeColor: const Color(0xFFEA580C),
          backgroundColor: const Color(0xFFFFF7ED),
          points: [
            'Incidence: 10-20% clinically significant; up to 76% radiographic',
            'Most common location: HIPS (most commonly tested answer) > elbows > shoulders > knees',
            'Onset: Typically 1-4 months post-injury (peak at 2 months)',
            'Risk factors: Spasticity, prolonged immobilization, coma duration > 2 weeks, long bone fractures, blast injury',
            'NOT related to initial injury severity by GCS alone -- spasticity and immobilization are stronger predictors',
          ],
        ),
        HeaderBlock('Diagnosis of HO'),
        TableBlock(
          title: 'Diagnostic Modalities by Sensitivity and Timing',
          columns: ['Test', 'Sensitivity', 'When Positive', 'Key Features'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'Triple-phase bone scan',
              'MOST SENSITIVE (gold standard for early detection)',
              '2-4 weeks BEFORE plain X-ray',
              'Phase 1: flow, Phase 2: blood pool, Phase 3: delayed. All 3 phases positive in active HO',
            ],
            [
              'Serum alkaline phosphatase (SAP)',
              'Elevated but NONSPECIFIC',
              'Early (may precede radiographic findings)',
              'Useful for monitoring HO maturation -- normalizes as bone matures; NOT diagnostic alone',
            ],
            [
              'Plain X-ray',
              'Low sensitivity early',
              '4-6 weeks post-onset',
              'Shows mature calcification; negative in early HO',
            ],
            [
              'CT scan',
              'Moderate (better than X-ray)',
              '2-4 weeks post-onset',
              'Better anatomic detail; useful for surgical planning',
            ],
            [
              'Ultrasound',
              'Emerging modality',
              'Early (may detect before X-ray)',
              'Can detect zone phenomenon and soft tissue changes; operator-dependent',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: Triple-Phase Bone Scan',
          'The triple-phase bone scan is the MOST SENSITIVE test for early detection of HO and becomes positive 2-4 WEEKS BEFORE plain radiographs. All three phases (flow, blood pool, delayed) are positive in active HO. As HO matures, phases 1 and 2 normalize while phase 3 remains positive. A "cooling" bone scan (normalizing phases 1 and 2) indicates maturation and guides timing for surgical excision.',
        ),
        HeaderBlock('HO Management'),
        BulletCardBlock(
          title: 'Treatment Approach',
          themeColor: const Color(0xFF2563EB),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Prevention: Gentle ROM exercises (avoid aggressive/painful stretching which may worsen HO), positioning',
            'Pharmacologic prophylaxis: Indomethacin (NSAID, inhibits prostaglandin-mediated osteoblast activity); etidronate (bisphosphonate) less commonly used',
            'Radiation prophylaxis: Single-dose radiation (700-800 cGy) effective in hip arthroplasty population; limited evidence in TBI',
            'ROM exercises: Continue gentle ROM even with active HO to maintain functional arc of motion; DO NOT force through resistance',
            'Surgical excision (Garland timing): Wait 12-18 months until bone is mature -- alkaline phosphatase normalizes AND bone scan shows cooling (phases 1 and 2 normalize)',
          ],
        ),
        PearlBlock(
          'Board Pearl: Garland Timing for HO Resection',
          'Garland established that surgical excision of HO should be delayed until the bone is mature (12-18 months post-onset). Criteria for maturity: (1) alkaline phosphatase has returned to normal, (2) triple-phase bone scan shows "cooling" (phases 1 and 2 normalize). Early excision risks high recurrence rate. Post-operative indomethacin and/or radiation may reduce recurrence.',
        ),
        HeaderBlock('Venous Thromboembolism (VTE) in TBI'),
        TextBlock(
          'VTE is a leading cause of preventable death after TBI. The incidence of DVT in severe TBI patients WITHOUT prophylaxis is approximately 54%. Early recognition and appropriate prophylaxis strategy is essential.',
        ),
        BulletCardBlock(
          title: 'VTE Epidemiology in TBI',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'DVT incidence WITHOUT prophylaxis: ~54% (Kaufman et al.)',
            'DVT incidence WITH prophylaxis: 18-28% (still significant despite treatment)',
            'Pulmonary embolism (PE): Leading cause of preventable death in rehabilitation patients',
            'Risk factors: Prolonged immobility, lower extremity fractures, paralysis/paresis, central venous catheters, advanced age, obesity, prior VTE history',
            'TBI-specific concern: Intracranial hemorrhage limits timing of anticoagulation prophylaxis',
          ],
        ),
        TableBlock(
          title: 'VTE Prophylaxis Strategy in TBI',
          columns: ['Method', 'Timing', 'Details'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'Mechanical (first-line)',
              'Immediately',
              'Sequential compression devices (SCDs), graduated compression stockings; START immediately as no hemorrhage risk',
            ],
            [
              'Pharmacologic (LMWH)',
              '24-72 hours post-injury (if hemorrhage stable)',
              'Enoxaparin 30-40 mg SC BID; timing depends on stability of intracranial hemorrhage on repeat CT',
            ],
            [
              'Pharmacologic (UFH)',
              '24-72 hours post-injury',
              'Heparin 5000 units SC Q8-12H; may have slightly lower efficacy than LMWH',
            ],
            [
              'IVC filter',
              'When anticoagulation contraindicated',
              'Retrievable IVC filter for patients with active hemorrhage who cannot receive anticoagulation; retrieve when anticoagulation can be started',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: VTE Prophylaxis Timing',
          'The key dilemma in TBI is balancing VTE risk (54% DVT without prophylaxis) against hemorrhagic risk. Mechanical prophylaxis (SCDs) should be started IMMEDIATELY. Pharmacologic prophylaxis (LMWH or UFH) is typically started 24-72 hours after injury once repeat imaging confirms hemorrhage stability. If pharmacologic prophylaxis is contraindicated (expanding hemorrhage), a retrievable IVC filter should be considered. The "54% without prophylaxis" number is high-yield.',
        ),
      ],
    ),
    TopicTab(
      title: 'Cranial Nerve Injuries',
      blocks: [
        HeaderBlock('Cranial Nerve Injuries in TBI'),
        TextBlock(
          'Cranial nerve injuries are common after TBI and are a frequently tested board topic. The frequency, mechanism, and clinical features of each nerve injury must be understood. CN I is the most commonly injured cranial nerve overall, and the ONLY cranial neuropathy seen in mild TBI.',
          isIntro: true,
        ),
        TableBlock(
          title: 'Cranial Nerve Injury Frequency and Features',
          columns: ['CN', 'Name', 'Frequency Rank', 'Mechanism', 'Clinical Features'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'CN I',
              'Olfactory',
              '#1 (most common)',
              'Shearing of olfactory filaments at cribriform plate during acceleration/deceleration; anterior fossa fracture',
              'Anosmia (loss of smell) or hyposmia; ONLY CN injury seen in MILD TBI; recovery in > 1/3 within 3 months; associated with reduced taste perception',
            ],
            [
              'CN VII',
              'Facial',
              '#2',
              'Fracture through temporal bone (petrous portion); long intratemporal course makes it vulnerable; can be immediate or delayed',
              'Facial weakness/paralysis (UMN vs LMN pattern); immediate = nerve transection (poorer prognosis); delayed onset = edema/neuropraxia (better prognosis)',
            ],
            [
              'CN VIII',
              'Vestibulocochlear',
              '#3',
              'Temporal bone fracture (transverse > longitudinal); labyrinthine concussion; perilymphatic fistula',
              'Sensorineural hearing loss, tinnitus, vertigo, nystagmus; transverse temporal bone fractures have higher risk of SNHL',
            ],
            [
              'CN IV',
              'Trochlear',
              '#4 (most common oculomotor)',
              'Most common oculomotor nerve injury; long, thin course around brainstem makes it vulnerable to stretching; contralateral injury from contrecoup',
              'Superior oblique palsy; hypertropia (affected eye elevated); head tilt AWAY from affected side; worsened on looking down and medially (e.g., reading, stairs)',
            ],
            [
              'CN III',
              'Oculomotor',
              '#5',
              'Uncal herniation (posterior communicating artery compression); orbital fracture; midbrain injury',
              'Ptosis, "down and out" eye position, mydriasis (dilated pupil); pupil involvement suggests compression (surgical CN III palsy)',
            ],
            [
              'CN VI',
              'Abducens',
              '#6',
              'Long intracranial course makes it vulnerable to elevated ICP (false localizing sign); petrous bone fracture',
              'Lateral rectus palsy; esotropia (inward deviation); inability to abduct the affected eye; may be bilateral with elevated ICP',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: CN Injury Ranking',
          'The ranking of CN injuries in TBI is: CN I > CN VII > CN VIII > CN IV > CN III > CN VI. Remember: "1-7-8" for the top three. CN I is the ONLY CN injury in mild TBI -- anosmia from shearing at the cribriform plate. CN IV is the most commonly injured OCULOMOTOR nerve (not CN III). CN VI palsy can be a FALSE LOCALIZING SIGN of elevated ICP (not indicative of a focal brainstem lesion).',
        ),
        HeaderBlock('Temporal Bone Fractures and CN Injuries'),
        TableBlock(
          title: 'Temporal Bone Fracture Types',
          columns: ['Feature', 'Longitudinal (70-80%)', 'Transverse (10-20%)'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            ['Direction', 'Parallel to long axis of petrous bone', 'Perpendicular to long axis of petrous bone'],
            ['CN VII injury', '10-25%', '30-50%'],
            ['Hearing loss type', 'CONDUCTIVE (ossicular chain disruption)', 'SENSORINEURAL (labyrinthine damage)'],
            ['CSF leak (otorrhea)', 'More common', 'Less common'],
            ['Hemotympanum', 'Common', 'Common'],
            ['Vertigo', 'Less severe', 'More severe (labyrinthine destruction)'],
            ['CN VIII injury', 'Less common', 'More common (direct labyrinthine injury)'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Temporal Bone Fractures',
          'Longitudinal fractures (70-80%) are more common but less severe: CONDUCTIVE hearing loss from ossicular chain disruption, lower rate of CN VII injury (10-25%). Transverse fractures (10-20%) are less common but more severe: SENSORINEURAL hearing loss from labyrinthine destruction, higher rate of CN VII injury (30-50%). Know this distinction -- it is tested frequently.',
        ),
        HeaderBlock('CN IV (Trochlear) Palsy: The Most Common Oculomotor Injury'),
        BulletCardBlock(
          title: 'Clinical Details of CN IV Palsy in TBI',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'CN IV has the longest intracranial course and is the only CN that exits dorsally from the brainstem -- both features make it uniquely vulnerable to trauma',
            'The contralateral CN IV is often injured (contrecoup mechanism)',
            'Clinical findings: Hypertropia (affected eye elevated), excyclotorsion',
            'Parks-Bielschowsky three-step test: (1) Which eye is hypertropic? (2) Does hypertropia worsen in contralateral gaze? (3) Does it worsen with ipsilateral head tilt? If all three localize to the same muscle = CN IV palsy',
            'Compensatory head tilt: Patient tilts head AWAY from the affected side and tucks chin to minimize diplopia',
            'Patients often report difficulty reading and going down stairs (activities requiring downgaze)',
            'Treatment: Prism glasses for small deviations; surgical correction (inferior oblique weakening) for persistent, large deviations',
          ],
        ),
        HeaderBlock('Olfactory Nerve (CN I) Injury'),
        BulletCardBlock(
          title: 'Clinical Significance of Anosmia',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFF0FDF4),
          points: [
            'Most common CN injury in TBI (all severities)',
            'ONLY CN injury in mild TBI -- all other CN injuries require moderate-severe TBI',
            'Mechanism: Shearing of olfactory nerve filaments as they pass through the cribriform plate',
            'Associated with anterior fossa fractures and frontal lobe contusions',
            'Recovery: > 1/3 show improvement within 3 months; recovery is more likely if hyposmia (partial loss) rather than complete anosmia',
            'Clinical impact: Safety concern (cannot detect gas leaks, smoke, spoiled food); reduced taste perception (flavor is largely smell-dependent); decreased quality of life and appetite',
            'Testing: University of Pennsylvania Smell Identification Test (UPSIT) -- 40-item scratch-and-sniff test; most widely used standardized olfactory test',
          ],
        ),
      ],
    ),
  ],
);
