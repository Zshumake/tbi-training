import '../../core/models/quiz_model.dart';
import 'notebooklm_acute_mgmt_quiz.dart';
import 'notebooklm_pathophys_quiz.dart';
import 'notebooklm_classification_quiz.dart';
import 'notebooklm_fundamentals_quiz.dart';
import 'notebooklm_neuroimaging_quiz.dart';
import 'notebooklm_doc_quiz.dart';
import 'notebooklm_complications_quiz.dart';
import 'notebooklm_pharmacology_quiz.dart';
import 'notebooklm_agitation_quiz.dart';
import 'notebooklm_spasticity_quiz.dart';
import 'notebooklm_neuroendocrine_quiz.dart';
import 'notebooklm_pediatric_geriatric_quiz.dart';
import 'notebooklm_rehab_continuum_quiz.dart';

class TBIQuizBank {
  static const List<QuizQuestion> _handwritten = [
    // =====================================================
    // MODULE 1: TBI FUNDAMENTALS
    // =====================================================
    QuizQuestion(
      question: 'What is the ONLY Level I recommendation in the BTF 4th Edition Guidelines?',
      options: [
        'ICP should be treated when >22 mmHg',
        'CPP should be maintained at 60-70 mmHg',
        'Steroids are NOT recommended for TBI',
        'Prophylactic hypothermia improves outcomes',
      ],
      correctIndex: 2,
      explanation: 'The CRASH trial (2004, >10,000 patients) showed methylprednisolone INCREASED 2-week mortality (RR 1.18). Steroids are contraindicated in TBI — this is the ONLY Level I recommendation in the entire BTF 4th edition.',
      moduleId: 'tbi-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'What is the ICP treatment threshold per the BTF 4th Edition (2016)?',
      options: [
        '>15 mmHg',
        '>20 mmHg',
        '>22 mmHg',
        '>25 mmHg',
      ],
      correctIndex: 2,
      explanation: 'The BTF 4th Edition changed the ICP treatment threshold from 20 to 22 mmHg. "22 is the new 20." Normal ICP is 2-5 mmHg.',
      moduleId: 'tbi-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'According to the ACRM definition, which of the following EXCEEDS criteria for mild TBI?',
      options: [
        'LOC of 15 minutes',
        'PTA of 18 hours',
        'GCS of 14',
        'PTA of 36 hours',
      ],
      correctIndex: 3,
      explanation: 'Mild TBI criteria: LOC <30 min, PTA <24 hrs, initial GCS ≥13. PTA of 36 hours exceeds the 24-hour limit, making this at least a moderate TBI.',
      moduleId: 'tbi-fundamentals',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question: 'What is the leading cause of TBI-related death in adults ≥75 years?',
      options: [
        'Motor vehicle crashes',
        'Falls',
        'Assault',
        'Sports injuries',
      ],
      correctIndex: 1,
      explanation: 'Falls are the leading cause of TBI in the very young (0-4) and elderly (≥75). Adults ≥75 have the highest mortality rate from TBI, primarily from falls.',
      moduleId: 'tbi-fundamentals',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question: 'A hypotensive patient with elevated ICP needs osmolar therapy. Which agent is preferred?',
      options: [
        'Mannitol 20%',
        'Hypertonic saline 3%',
        'Furosemide',
        'Dexamethasone',
      ],
      correctIndex: 1,
      explanation: 'Mannitol causes osmotic diuresis → volume depletion → worsening hypotension. Hypertonic saline does NOT cause diuresis and can actually expand intravascular volume. Dexamethasone (steroid) is contraindicated in TBI.',
      moduleId: 'tbi-fundamentals',
      difficulty: 'board',
    ),

    // =====================================================
    // MODULE 2: PATHOPHYSIOLOGY
    // =====================================================
    QuizQuestion(
      question: 'Which brain regions are MOST susceptible to contusions due to the rough inner skull surface?',
      options: [
        'Occipital lobes and cerebellum',
        'Inferior frontal and anterior temporal lobes',
        'Parietal lobes bilaterally',
        'Thalamus and basal ganglia',
      ],
      correctIndex: 1,
      explanation: 'The rough bony ridges of the anterior and middle cranial fossae make the orbitofrontal and anterior temporal regions most vulnerable to contusions (coup-contrecoup).',
      moduleId: 'pathophysiology',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question: 'A CT shows a biconvex (lens-shaped) hyperdense extra-axial collection. What is the most likely diagnosis?',
      options: [
        'Subdural hematoma',
        'Epidural hematoma',
        'Subarachnoid hemorrhage',
        'Intraparenchymal hemorrhage',
      ],
      correctIndex: 1,
      explanation: 'Epidural hematomas are biconvex/lenticular in shape, typically from rupture of the middle meningeal artery. They are bounded by suture lines. SDH appears crescent-shaped and crosses sutures.',
      moduleId: 'pathophysiology',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question: 'What is the Adams grading of DAI when hemorrhagic lesions are found in the corpus callosum?',
      options: [
        'Grade 1',
        'Grade 2',
        'Grade 3',
        'Grade 4',
      ],
      correctIndex: 1,
      explanation: 'Adams DAI grading: Grade 1 = white matter of cerebral hemispheres, Grade 2 = corpus callosum involvement, Grade 3 = brainstem (dorsolateral) involvement. Higher grade = worse prognosis.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which imaging modality is MOST sensitive for detecting diffuse axonal injury?',
      options: [
        'Non-contrast CT',
        'T1-weighted MRI',
        'Susceptibility-weighted imaging (SWI)',
        'Plain skull radiograph',
      ],
      correctIndex: 2,
      explanation: 'SWI is 3-6x more sensitive than conventional gradient-recalled echo (GRE) for detecting microhemorrhages associated with DAI. Standard CT misses most DAI. DTI can detect axonal disruption even without hemorrhage.',
      moduleId: 'pathophysiology',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question: 'Which neurotransmitter is primarily responsible for the excitotoxic cascade following TBI?',
      options: [
        'GABA',
        'Dopamine',
        'Glutamate',
        'Serotonin',
      ],
      correctIndex: 2,
      explanation: 'Within minutes of TBI, excessive glutamate release triggers NMDA receptor activation → unregulated calcium influx → activation of Ca²⁺-dependent proteases → mitochondrial injury → apoptosis. This excitotoxic cascade is the primary driver of secondary injury.',
      moduleId: 'pathophysiology',
      difficulty: 'basic',
    ),

    // =====================================================
    // MODULE 3: CLASSIFICATION & SEVERITY
    // =====================================================
    QuizQuestion(
      question: 'A patient opens eyes to pain, makes incomprehensible sounds, and has flexion withdrawal. What is their GCS?',
      options: [
        '7',
        '8',
        '9',
        '10',
      ],
      correctIndex: 1,
      explanation: 'Eye opening to pain = 2, Incomprehensible sounds = 2, Flexion withdrawal = 4. Total GCS = 2+2+4 = 8. This patient is at the threshold for coma (GCS ≤8).',
      moduleId: 'classification-severity',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question: 'Which component of the GCS is the strongest predictor of outcome?',
      options: [
        'Eye opening',
        'Verbal response',
        'Motor response',
        'All three equally',
      ],
      correctIndex: 2,
      explanation: 'The motor component of the GCS is the strongest single predictor of outcome after TBI. This is why the FOUR Score, which does not rely on verbal response, remains valid in intubated patients.',
      moduleId: 'classification-severity',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question: 'A patient at Rancho Level IV would be described as:',
      options: [
        'Localized response',
        'Confused-agitated',
        'Confused-inappropriate',
        'Automatic-appropriate',
      ],
      correctIndex: 1,
      explanation: 'Rancho IV = Confused and Agitated. Key features: heightened state of activity, bizarre/non-purposeful behavior, no short-term memory, unable to cooperate with treatment. Management: low-stimulation environment, 1:1 supervision, safety measures.',
      moduleId: 'classification-severity',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which of the following is the strongest single predictor of functional outcome after TBI?',
      options: [
        'Initial GCS score',
        'Duration of loss of consciousness',
        'Duration of posttraumatic amnesia',
        'CT findings on admission',
      ],
      correctIndex: 2,
      explanation: 'PTA duration is consistently the strongest single predictor of functional recovery after TBI. Longer PTA = poorer outcomes. PTA >1 week suggests severe injury.',
      moduleId: 'classification-severity',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'What is the misdiagnosis rate for disorders of consciousness (VS vs MCS)?',
      options: [
        '5-10%',
        '15-20%',
        '30-40%',
        '50-60%',
      ],
      correctIndex: 2,
      explanation: 'Studies consistently show a 30-40% misdiagnosis rate for disorders of consciousness, primarily VS being misdiagnosed in patients who are actually in MCS. The CRS-R helps reduce this rate through standardized behavioral assessment.',
      moduleId: 'classification-severity',
      difficulty: 'board',
    ),

    // =====================================================
    // MODULE 5: ACUTE MANAGEMENT
    // =====================================================
    QuizQuestion(
      question: 'A patient with mild-moderate TBI (GCS 12) presents 2 hours after injury. Which pharmacologic intervention has Level 1 evidence for reducing head injury death?',
      options: [
        'Methylprednisolone 30 mg/kg IV',
        'Tranexamic acid 1g IV bolus + 1g over 8h',
        'Erythropoietin 40,000 IU SC',
        'Progesterone IV infusion',
      ],
      correctIndex: 1,
      explanation: 'CRASH-3 (Lancet 2019): TXA 1g bolus + 1g over 8h reduces head injury death in GCS 9-15 when given within 3 hours (RR 0.78). Steroids INCREASE mortality (CRASH trial). EPO and progesterone both showed NO benefit in Phase III trials.',
      moduleId: 'acute-management',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'What are the normal values for the FDA-cleared TBI blood biomarkers GFAP and UCH-L1?',
      options: [
        'GFAP <100 pg/mL, UCH-L1 <500 pg/mL',
        'GFAP <30 pg/mL, UCH-L1 <360 pg/mL',
        'GFAP <50 ng/mL, UCH-L1 <100 ng/mL',
        'GFAP <10 pg/mL, UCH-L1 <50 pg/mL',
      ],
      correctIndex: 1,
      explanation: 'GFAP <30 pg/mL and UCH-L1 <360 pg/mL are the normal cutoffs per ACS 2024 guidelines. These are the first FDA-cleared blood tests for TBI, primarily used to rule out CT need in mild TBI with high negative predictive value. Abbott i-STAT (2024) gives bedside results in 15 minutes.',
      moduleId: 'acute-management',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'The BEST-TRIP trial demonstrated that ICP monitoring-guided care compared to imaging/clinical exam-guided care:',
      options: [
        'Significantly reduced mortality',
        'Was not superior; both groups had similar outcomes',
        'Increased mortality due to monitor complications',
        'Improved functional outcomes at 12 months',
      ],
      correctIndex: 1,
      explanation: 'BEST-TRIP (Chesnut, NEJM 2012): Mortality 39% vs 41% (P=0.60) — no difference. The imaging group received MORE empiric treatment (4.8 vs 3.4 days). This does NOT invalidate ICP monitoring — it tested treatment protocols, not monitoring utility. BTF still recommends monitoring.',
      moduleId: 'acute-management',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'In the SIBICC algorithm, at which tier is decompressive craniectomy classified?',
      options: [
        'Tier 1',
        'Tier 2',
        'Tier 3',
        'Not included',
      ],
      correctIndex: 2,
      explanation: 'SIBICC classifies DC as a Tier 3 (last resort, highest risk) intervention. Tier 1 = favorable side-effect profile (HOB elevation, sedation, normothermia, EVD, osmotherapy). Tier 2 = moderate risk (hyperventilation, NMBAs, MAP challenge). Tier 3 = barbiturate coma, therapeutic hypothermia, and DC.',
      moduleId: 'acute-management',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which of the following is the primary mechanism of acute coagulopathy in TBI?',
      options: [
        'Hemorrhagic shock causing dilutional coagulopathy',
        'DIC from systemic infection',
        'Massive tissue factor release from injured brain activating extrinsic cascade',
        'Vitamin K deficiency from poor nutrition',
      ],
      correctIndex: 2,
      explanation: 'TBI coagulopathy is brain-derived: injured brain releases massive tissue factor (brain has highest TF concentration of any organ), activating the extrinsic coagulation cascade → consumptive coagulopathy with fibrinogen nadir at 3-6 hours. Occurs in up to 60% of severe TBI. TEG/ROTEM is more sensitive than standard labs.',
      moduleId: 'acute-management',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which of the following neuroprotective agents has been proven INEFFECTIVE in TBI by Phase III trials? (Select the INCORRECT pairing)',
      options: [
        'Progesterone — ProTECT III (negative)',
        'EPO — EPO-TBI trial (negative)',
        'TXA — CRASH-3 (positive in GCS 9-15)',
        'Hypothermia — POLAR trial (negative)',
      ],
      correctIndex: 2,
      explanation: 'TXA (CRASH-3) showed BENEFIT in GCS 9-15 patients within 3 hours. All others are confirmed negative: ProTECT III and SyNAPSe (progesterone), EPO-TBI (erythropoietin), POLAR and Eurotherm (hypothermia), and CRASH (steroids — increased mortality).',
      moduleId: 'acute-management',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'What is the preferred neuromuscular blocking agent for ICP management and why?',
      options: [
        'Succinylcholine — fastest onset',
        'Cisatracurium — Hofmann elimination, no histamine release',
        'Vecuronium — longest duration',
        'Atracurium — cheapest option',
      ],
      correctIndex: 1,
      explanation: 'Cisatracurium is preferred: no histamine release (unlike atracurium), no effect on ICP/CPP, and organ-independent metabolism (Hofmann elimination) — ideal for renal/hepatic dysfunction. Succinylcholine can elevate ICP and cause hyperkalemia. NMBAs are a SIBICC Tier 2 intervention.',
      moduleId: 'acute-management',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question: 'The DECRA trial showed that early bifrontal decompressive craniectomy for diffuse TBI:',
      options: [
        'Improved neurological outcomes and reduced mortality',
        'Decreased ICP but was associated with MORE unfavorable outcomes',
        'Had no effect on ICP or outcomes',
        'Increased mortality compared to medical management',
      ],
      correctIndex: 1,
      explanation: 'DECRA (Cooper, NEJM 2011): Early bifrontal DC for diffuse TBI decreased ICP effectively but was associated with more unfavorable outcomes (increased vegetative state). The RESCUEicp trial later showed DC reduced mortality but increased severe disability.',
      moduleId: 'acute-management',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'What is the target CPP range recommended by the BTF 4th Edition?',
      options: [
        '40-50 mmHg',
        '50-60 mmHg',
        '60-70 mmHg',
        '70-80 mmHg',
      ],
      correctIndex: 2,
      explanation: 'CPP = MAP - ICP. Target: 60-70 mmHg. CPP <50 is associated with poor outcomes. The BTF specifically warns against pushing CPP >70 with vasopressors due to ARDS risk.',
      moduleId: 'acute-management',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question: 'When should feeding be initiated in severe TBI per BTF 4th Edition?',
      options: [
        'Within 24 hours',
        'By day 3',
        'By day 5-7',
        'After ICP normalizes',
      ],
      correctIndex: 2,
      explanation: 'BTF 4th Ed recommends feeding by day 5-7 to decrease mortality. TBI patients are hypermetabolic (140% caloric expenditure). Protein needs: 1.5-2 g/kg/day. Transgastric jejunal feeding reduces aspiration risk.',
      moduleId: 'acute-management',
      difficulty: 'intermediate',
    ),

    // =====================================================
    // MODULE 6: DISORDERS OF CONSCIOUSNESS
    // =====================================================
    QuizQuestion(
      question: 'Emergence from MCS requires demonstration of:',
      options: [
        'Eye opening to command',
        'Functional object use OR reliable communication',
        'Consistent localization to pain',
        'Spontaneous eye tracking',
      ],
      correctIndex: 1,
      explanation: 'Emergence from MCS requires reliable and consistent demonstration of EITHER: (1) functional object use, OR (2) interactive communication. Visual pursuit alone indicates MCS, not emergence.',
      moduleId: 'disorders-of-consciousness',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'The Giacino et al. NEJM 2012 amantadine trial showed:',
      options: [
        'No benefit for disorders of consciousness',
        'Faster DRS improvement during treatment, with convergence after washout',
        'Sustained improvement that persisted after medication was stopped',
        'Benefit only in vegetative state, not MCS',
      ],
      correctIndex: 1,
      explanation: 'Giacino trial: n=184, VS/MCS at 4-16 weeks post-injury. Amantadine 100-200 mg BID accelerated DRS recovery during treatment (p=0.007), but groups converged after 2-week washout. This suggests amantadine speeds recovery but may not change ultimate outcome.',
      moduleId: 'disorders-of-consciousness',
      difficulty: 'board',
    ),

    // =====================================================
    // MODULE 7: MEDICAL COMPLICATIONS
    // =====================================================
    QuizQuestion(
      question: 'AED prophylaxis has been proven effective for which duration after TBI?',
      options: [
        'First 24 hours only',
        'First 7 days only',
        'First 30 days',
        'First 2 years',
      ],
      correctIndex: 1,
      explanation: 'AEDs (phenytoin, levetiracetam) reduce EARLY PTS (≤7 days) but have NOT been proven effective for preventing LATE PTS (>7 days). The Temkin trial (1990) established this. Prophylaxis beyond 1 week is not recommended.',
      moduleId: 'medical-complications',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'What is the incidence of DVT in TBI rehabilitation patients WITHOUT prophylaxis?',
      options: [
        '10-15%',
        '25-30%',
        '40-45%',
        '54%',
      ],
      correctIndex: 3,
      explanation: 'DVT incidence without prophylaxis is approximately 54%. VTE is clinically silent in 70-80% of TBI patients, with sudden death from PE potentially being the first clinical sign. LMWH is superior to UFH for prophylaxis.',
      moduleId: 'medical-complications',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'What is the recommended timing for surgical resection of heterotopic ossification after TBI (Garland criteria)?',
      options: [
        '3-6 months',
        '6-12 months',
        '12-18 months',
        '24 months',
      ],
      correctIndex: 2,
      explanation: 'Garland timing: HO excision should wait 12-18 months after TBI for bone maturation (6 months after musculoskeletal injury, 12 months after SCI, 18 months after TBI). Ideal candidate: no joint pain/swelling, normal alkaline phosphatase, mature bone scan.',
      moduleId: 'medical-complications',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which cranial nerve is MOST commonly injured in TBI?',
      options: [
        'CN III (oculomotor)',
        'CN VII (facial)',
        'CN I (olfactory)',
        'CN VIII (vestibulocochlear)',
      ],
      correctIndex: 2,
      explanation: 'CN I (olfactory) is the most commonly injured CN in TBI (~7% overall, 19.4% in moderate, 24.5% in severe). Injury occurs from tearing of olfactory filaments at the cribriform plate. It is also the only CN neuropathy present in mild TBI.',
      moduleId: 'medical-complications',
      difficulty: 'intermediate',
    ),

    // =====================================================
    // MODULE 8: PHARMACOLOGY
    // =====================================================
    QuizQuestion(
      question: 'Which medication has the STRONGEST evidence for treating attention deficits after TBI?',
      options: [
        'Donepezil',
        'Amantadine',
        'Methylphenidate',
        'Modafinil',
      ],
      correctIndex: 2,
      explanation: 'Methylphenidate has the strongest evidence for improving attention and processing speed after TBI. It blocks dopamine and norepinephrine reuptake, increasing catecholamine availability. Start at 5 mg BID (morning and noon).',
      moduleId: 'pharmacology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Why should haloperidol be avoided in TBI patients?',
      options: [
        'It lowers the seizure threshold',
        'It causes hepatotoxicity',
        'It blocks D2 receptors and hinders neuroplasticity/motor recovery',
        'It causes serotonin syndrome',
      ],
      correctIndex: 2,
      explanation: 'Haloperidol is a typical antipsychotic that blocks D2 dopamine receptors, which are critical for cognitive recovery and neuroplasticity after TBI. Animal studies show it hinders spatial learning and motor recovery.',
      moduleId: 'pharmacology',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question: 'A TBI patient presents with apathy, decreased initiation, and flat affect. SSRIs have not helped. Which medication should be considered?',
      options: [
        'Quetiapine',
        'Methylphenidate or amantadine',
        'Gabapentin',
        'Lorazepam',
      ],
      correctIndex: 1,
      explanation: 'Apathy/abulia from frontal lobe injury responds better to dopaminergic agents (methylphenidate, amantadine, bromocriptine) than SSRIs. It is important to distinguish true depression from frontal lobe-mediated apathy.',
      moduleId: 'pharmacology',
      difficulty: 'board',
    ),

    // =====================================================
    // MODULE 9: AGITATION & BEHAVIORAL
    // =====================================================
    QuizQuestion(
      question: 'According to the Cochrane review, which medication class has the BEST evidence for treating posttraumatic agitation?',
      options: [
        'Atypical antipsychotics',
        'Benzodiazepines',
        'Beta-blockers',
        'Anticonvulsants',
      ],
      correctIndex: 2,
      explanation: 'The Cochrane review found beta-blockers (propranolol, pindolol) have the best evidence for efficacy in treating posttraumatic agitation. Propranolol can be used up to 520 mg/day. Monitor for hypotension and bradycardia.',
      moduleId: 'agitation-behavioral',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'What are the diagnostic criteria for Paroxysmal Sympathetic Hyperactivity (PSH)?',
      options: [
        'Presence of 2 of 4 autonomic signs',
        'Presence of 4 of 6 specified clinical features',
        'Fever >38.5°C plus tachycardia',
        'Any combination of autonomic dysfunction',
      ],
      correctIndex: 1,
      explanation: 'PSH requires 4 of 6: (1) fever, (2) tachycardia >120, (3) hypertension SBP >160, (4) tachypnea >30, (5) excessive diaphoresis, (6) extensor posturing/severe dystonia. Treatment: morphine + propranolol; ITB for refractory cases.',
      moduleId: 'agitation-behavioral',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'An ABS score of 32 indicates:',
      options: [
        'Normal behavior',
        'Mild agitation',
        'Moderate agitation',
        'Severe agitation',
      ],
      correctIndex: 2,
      explanation: 'ABS scoring: 14 items scored 1-4, range 14-56. Below 21: normal. 22-28: mild agitation. 29-35: moderate agitation. 35-54: severe agitation. A score of 32 falls in the moderate range.',
      moduleId: 'agitation-behavioral',
      difficulty: 'intermediate',
    ),

    // =====================================================
    // MODULE 11: NEUROENDOCRINE
    // =====================================================
    QuizQuestion(
      question: 'How do you differentiate SIADH from cerebral salt wasting (CSW)?',
      options: [
        'Serum sodium levels',
        'Urine osmolality',
        'Volume status (euvolemic vs hypovolemic)',
        'Serum potassium levels',
      ],
      correctIndex: 2,
      explanation: 'Both SIADH and CSW present with hyponatremia, but the KEY difference is volume status: SIADH = euvolemic (fluid restrict), CSW = hypovolemic (give volume). Treating CSW with fluid restriction (as for SIADH) is DANGEROUS — worsens cerebral perfusion.',
      moduleId: 'neuroendocrine',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'At what rate should sodium be corrected to avoid central pontine myelinolysis?',
      options: [
        '≤5 mEq/L per 24 hours',
        '≤10 mEq/L per 24 hours',
        '≤15 mEq/L per 24 hours',
        '≤20 mEq/L per 24 hours',
      ],
      correctIndex: 1,
      explanation: 'Sodium should be corrected no more than 10 mEq/L per 24 hours to prevent central pontine myelinolysis (osmotic demyelination syndrome). This applies to correction of hyponatremia from any cause.',
      moduleId: 'neuroendocrine',
      difficulty: 'board',
    ),

    // =====================================================
    // MODULE 12: CONCUSSION
    // =====================================================
    QuizQuestion(
      question: 'Second impact syndrome is characterized by:',
      options: [
        'Gradual onset of symptoms over weeks',
        'Rapid cerebral edema from impaired vascular autoregulation after a second concussion before recovery',
        'Bilateral subdural hematomas from repeated trauma',
        'Progressive white matter degeneration',
      ],
      correctIndex: 1,
      explanation: 'Second impact syndrome occurs when an athlete sustains a second concussion before recovering from the first. Impaired vascular autoregulation leads to malignant cerebral edema within minutes. Morbidity approaches 100% and mortality ~50%. Most common in adolescent athletes.',
      moduleId: 'concussion-mtbi',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'How many steps are in the graduated return-to-play protocol after concussion?',
      options: [
        '4 steps',
        '5 steps',
        '6 steps',
        '7 steps',
      ],
      correctIndex: 2,
      explanation: 'The 6-step graduated RTP protocol: (1) symptom-limited activity, (2) light aerobic exercise, (3) sport-specific exercise, (4) non-contact training drills, (5) full-contact practice (requires medical clearance), (6) return to competition. Each step takes at minimum 24 hours.',
      moduleId: 'concussion-mtbi',
      difficulty: 'intermediate',
    ),
  ];

  // Merge handwritten + NotebookLM questions
  static List<QuizQuestion> get allQuestions => [
    ..._handwritten,
    ...NotebookLMAcuteMgmtQuiz.questions,
    ...NotebookLMPathophysQuiz.questions,
    ...NotebookLMClassificationQuiz.questions,
    ...NotebookLMFundamentalsQuiz.questions,
    ...NotebookLMNeuroimagingQuiz.questions,
    ...NotebookLMDOCQuiz.questions,
    ...NotebookLMComplicationsQuiz.questions,
    ...NotebookLMPharmacologyQuiz.questions,
    ...NotebookLMAgitationQuiz.questions,
    ...NotebookLMSpasticityQuiz.questions,
    ...NotebookLMNeuroendocrineQuiz.questions,
    ...NotebookLMPediatricGeriatricQuiz.questions,
    ...NotebookLMRehabContinuumQuiz.questions,
  ];

  static List<QuizQuestion> getQuestionsForModule(String moduleId) {
    return allQuestions.where((q) => q.moduleId == moduleId).toList();
  }

  static List<QuizQuestion> getQuestionsByDifficulty(String difficulty) {
    return allQuestions.where((q) => q.difficulty == difficulty).toList();
  }

  static List<QuizQuestion> getRandomQuiz(int count) {
    final shuffled = List<QuizQuestion>.from(allQuestions)..shuffle();
    return shuffled.take(count).toList();
  }
}
