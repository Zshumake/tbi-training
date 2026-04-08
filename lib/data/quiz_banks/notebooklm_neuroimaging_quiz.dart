// NotebookLM-generated quiz questions — DO NOT REWRITE
// Source: notebooklm-handoff/neuroimaging/quiz-questions.json

import '../../core/models/quiz_model.dart';

class NotebookLMNeuroimagingQuiz {
  static const List<QuizQuestion> questions = [
    QuizQuestion(
      question: 'Which of the following blood biomarkers is specifically released from damaged astrocytes and serves as a marker of astrocyte activation in TBI?',
      options: [
        'GFAP (Glial Fibrillary Acidic Protein)',
        'UCH-L1 (Ubiquitin C-Terminal Hydrolase L1)',
        'S100B',
        'Tau protein',
      ],
      correctIndex: 0,
      explanation: 'GFAP is a protein found in the cytoskeleton of astrocytes and is released into the blood following glial cell injury or activation.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'According to the FDA-cleared thresholds for TBI blood biomarkers, which combination of results suggests that a head CT may be unnecessary due to a high negative predictive value (NPV)?',
      options: [
        'GFAP < 30 pg/mL AND UCH-L1 < 360 pg/mL',
        'GFAP > 30 pg/mL AND UCH-L1 < 360 pg/mL',
        'GFAP < 30 pg/mL AND UCH-L1 > 360 pg/mL',
        'GFAP > 30 pg/mL OR UCH-L1 > 360 pg/mL',
      ],
      correctIndex: 0,
      explanation: 'When both biomarkers are below their respective FDA-cleared thresholds (Abbott i-STAT TBI plasma assay), the negative predictive value for an intracranial lesion is approximately 99.6%.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which CT scoring system is unique because it treats midline shift as a continuous variable rather than a binary threshold (e.g., >5 mm)?',
      options: [
        'Stockholm CT Score',
        'Helsinki CT Score',
        'Marshall CT Classification',
        'Rotterdam CT Score',
      ],
      correctIndex: 0,
      explanation: 'The Stockholm system incorporates midline shift as a continuous measurement, which contributes to its superior prognostic performance.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'In the Helsinki CT Score, which finding is assigned a negative point value (-3), indicating a relatively better prognosis compared to other mass lesions?',
      options: [
        'Epidural Hematoma (EDH)',
        'Subdural Hematoma (SDH)',
        'Intraventricular Hemorrhage (IVH)',
        'Traumatic Subarachnoid Hemorrhage (tSAH)',
      ],
      correctIndex: 0,
      explanation: 'EDH is often associated with better outcomes than SDH or ICH if treated promptly, leading to its \'protective\' negative score in this system.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which advanced DTI metric is used to estimate neurite density, where a lower value typically indicates axonal loss?',
      options: [
        'NDI (Neurite Density Index)',
        'ODI (Orientation Dispersion Index)',
        'FW-VF (Free Water Volume Fraction)',
        'FA (Fractional Anisotropy)',
      ],
      correctIndex: 0,
      explanation: 'NDI is a specific output of the NODDI model that quantifies the density of neurites within a voxel.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'A PET scan using the tracer Flortaucipir (AV-1451) shows increased uptake specifically at the depths of the cortical sulci. Which condition does this pattern most likely represent?',
      options: [
        'Chronic Traumatic Encephalopathy (CTE)',
        'Alzheimer Disease (AD)',
        'Acute Mild TBI',
        'Vascular Dementia',
      ],
      correctIndex: 0,
      explanation: 'The perivascular accumulation of p-tau at the depths of cortical sulci is the pathognomonic histological and imaging signature of CTE.',
      moduleId: 'neuroimaging',
      difficulty: 'emerging',
    ),
    QuizQuestion(
      question: 'Which MRI technique has been shown to outperform SWI in the detection of microhemorrhages and individualized iron dysregulation in mTBI?',
      options: [
        'QSM (Quantitative Susceptibility Mapping)',
        'DWI (Diffusion Weighted Imaging)',
        'FLAIR (Fluid-Attenuated Inversion Recovery)',
        'MRS (Magnetic Resonance Spectroscopy)',
      ],
      correctIndex: 0,
      explanation: 'QSM quantifies tissue magnetic susceptibility and provides more unambiguous signals for iron and microbleeds than SWI phase imaging.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'In the context of severe TBI and CT Perfusion (CTP), what specific threshold in the brainstem is highly specific for in-hospital mortality according to the ACT-TBI study?',
      options: [
        'CBF < 10 mL/100g/min AND CBV < 2 mL/100g',
        'CBF > 50 mL/100g/min AND CBV > 4 mL/100g',
        'MTT < 2 seconds',
        'CPP < 60 mmHg',
      ],
      correctIndex: 0,
      explanation: 'A matched decrease in both cerebral blood flow and volume in the brainstem signifies non-survivable injury patterns.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which PET tracer target is upregulated in activated microglia and astrocytes, serving as a marker for chronic neuroinflammation up to 17 years post-TBI?',
      options: [
        'TSPO (Translocator Protein 18 kDa)',
        'FDG (Fluorodeoxyglucose)',
        'Beta-amyloid',
        'NAA (N-acetylaspartate)',
      ],
      correctIndex: 0,
      explanation: 'TSPO PET imaging detects persistent neuroinflammation and is often elevated in deep gray matter structures years after the initial injury.',
      moduleId: 'neuroimaging',
      difficulty: 'emerging',
    ),
    QuizQuestion(
      question: 'According to research on AI in neuroimaging, what is the primary clinical role of FDA-cleared platforms like Aidoc and Viz.ai?',
      options: [
        'Triage and prioritization of urgent scans',
        'Replacing the radiologist for final diagnosis',
        'Determining the legal liability in TBI cases',
        'Replacing the need for follow-up MRI',
      ],
      correctIndex: 0,
      explanation: 'AI is used to flag critical findings like intracranial hemorrhage for immediate physician review, reducing time-to-treatment.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which of the following statements is true regarding the comparison between the Stockholm and Marshall CT scoring systems?',
      options: [
        'Stockholm incorporates Traumatic Subarachnoid Hemorrhage (tSAH) as a separate, strong predictor.',
        'Marshall is more accurate than Stockholm for predicting long-term functional outcome.',
        'Stockholm is limited to only 6 categorical grades.',
        'Neither system accounts for the presence of Diffuse Axonal Injury (DAI).',
      ],
      correctIndex: 0,
      explanation: 'tSAH is the single strongest predictor of unfavorable outcomes in the Stockholm system, a feature missing in the Marshall classification.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
    QuizQuestion(
      question: 'Which advanced imaging metric overcomes the \'crossing fiber\' limitation of standard DTI by analyzing individual fiber populations within a single voxel?',
      options: [
        'Fixel-Based Analysis (FBA)',
        'Fractional Anisotropy (FA)',
        'Mean Diffusivity (MD)',
        'Cerebral Blood Flow (CBF)',
      ],
      correctIndex: 0,
      explanation: 'FBA provides metrics for individual fiber bundles (\'fixels\') within voxels, allowing for a more accurate assessment of white matter integrity.',
      moduleId: 'neuroimaging',
      difficulty: 'board',
    ),
  ];
}
