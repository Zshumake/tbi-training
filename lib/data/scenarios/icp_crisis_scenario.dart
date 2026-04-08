import '../models/clinical_scenario_model.dart';

/// A 5-step ICP crisis scenario covering acute TBI management,
/// refractory intracranial hypertension, herniation, and
/// post-injury sodium dysregulation.
class ICPCrisisScenario {
  static const ClinicalScenario scenario = ClinicalScenario(
    id: 'icp_crisis_01',
    title: 'ICP Crisis: Acute Subdural Hematoma',
    patientSummary:
        '45M, GCS 6 (E1V2M3), MVC at highway speed, intubated in '
        'field. Right temporal SDH on CT with 8 mm midline shift. '
        'ICP monitor placed, opening pressure 28 mmHg.',
    steps: [
      // ────────────────────────────────────────────
      // STEP 1 — Initial ICP management
      // ────────────────────────────────────────────
      ScenarioStep(
        id: 'step_1',
        narrative:
            'The patient arrives in the Neuro-ICU post-intubation. CT head '
            'shows a right temporal acute subdural hematoma with 8 mm '
            'midline shift. An ICP monitor is placed and reads 28 mmHg. '
            'CPP is 62 mmHg. The neurosurgeon is reviewing imaging and '
            'will be available in 20 minutes. What is your immediate '
            'first-line intervention to lower ICP?',
        vitals: VitalSigns(
          hr: 58,
          sbp: 152,
          dbp: 78,
          rr: 14,
          spo2: 99,
          icp: 28,
          cpp: 62,
          temp: 37.1,
          gcs: 6,
        ),
        imagingFinding:
            'CT Head: Right temporal acute SDH, 12 mm thickness, '
            '8 mm leftward midline shift. Effacement of right lateral '
            'ventricle. No hydrocephalus.',
        timeLimit: 60,
        choices: [
          ScenarioChoice(
            text: 'A) Administer Mannitol 1 g/kg IV bolus',
            isCorrect: true,
            consequence:
                'Mannitol is administered. Over 15 minutes the ICP drops '
                'from 28 to 22 mmHg and CPP improves to 70 mmHg. The '
                'neurosurgical team is en route.',
            explanation:
                'Mannitol (0.5-1 g/kg IV bolus) is a first-line osmotic '
                'agent for acute ICP reduction. It works by creating an '
                'osmotic gradient across the intact blood-brain barrier, '
                'drawing water from brain parenchyma into the '
                'intravascular space. Onset is 15-30 minutes with peak '
                'effect at 1-2 hours. Monitor serum osmolality (hold if '
                '>320 mOsm/L) and watch for rebound ICP elevation.',
            nextStepId: 'step_2',
            updatedVitals: VitalSigns(
              hr: 62,
              sbp: 148,
              dbp: 76,
              rr: 14,
              spo2: 99,
              icp: 22,
              cpp: 70,
              temp: 37.1,
              gcs: 6,
            ),
          ),
          ScenarioChoice(
            text: 'B) Take patient immediately to the OR for evacuation',
            isCorrect: false,
            consequence:
                'The OR is not yet available and the neurosurgeon has not '
                'finished reviewing imaging. While awaiting OR, the ICP '
                'continues to rise to 32 mmHg without medical management.',
            explanation:
                'While surgical evacuation is the definitive treatment '
                'for a large SDH with midline shift, the OR is not '
                'immediately available. Medical ICP management with '
                'osmotic therapy should be initiated as a bridge to '
                'surgery. The BTF guidelines recommend first-line medical '
                'management with osmotic agents while preparing for '
                'operative intervention.',
            nextStepId: 'step_2',
            updatedVitals: VitalSigns(
              hr: 55,
              sbp: 160,
              dbp: 82,
              rr: 14,
              spo2: 99,
              icp: 32,
              cpp: 56,
              temp: 37.1,
              gcs: 6,
            ),
          ),
          ScenarioChoice(
            text: 'C) Hyperventilate to PaCO2 of 25 mmHg',
            isCorrect: false,
            consequence:
                'Aggressive hyperventilation causes cerebral '
                'vasoconstriction. ICP drops to 20, but cerebral blood '
                'flow is dangerously reduced, risking secondary ischemic '
                'injury to already vulnerable brain tissue.',
            explanation:
                'Prophylactic or aggressive hyperventilation (PaCO2 < 30 '
                'mmHg) is NOT recommended by BTF guidelines as a '
                'first-line ICP treatment. While mild hyperventilation '
                '(PaCO2 30-35) may be used briefly as a temporizing '
                'measure in acute herniation, sustained hyperventilation '
                'reduces CBF and can worsen secondary ischemic injury. '
                'It should never be used within the first 24 hours when '
                'CBF is already critically reduced.',
            nextStepId: 'step_2',
            updatedVitals: VitalSigns(
              hr: 72,
              sbp: 140,
              dbp: 72,
              rr: 22,
              spo2: 100,
              icp: 20,
              cpp: 66,
              temp: 37.1,
              gcs: 6,
            ),
          ),
          ScenarioChoice(
            text: 'D) Administer Dexamethasone 10 mg IV',
            isCorrect: false,
            consequence:
                'Steroids are given. There is no ICP reduction. Meanwhile '
                'the patient develops hyperglycemia (glucose 245 mg/dL), '
                'which is associated with worse outcomes in TBI.',
            explanation:
                'Corticosteroids are CONTRAINDICATED in traumatic brain '
                'injury. The CRASH trial (2004, >10,000 patients) '
                'demonstrated increased 14-day mortality with '
                'methylprednisolone in moderate-to-severe TBI. Steroids '
                'increase infection risk, hyperglycemia, and do NOT '
                'reduce ICP from cytotoxic edema. This is a high-yield '
                'board point: steroids help with vasogenic edema (tumors, '
                'abscesses) but HARM patients with TBI.',
            nextStepId: 'step_2',
            updatedVitals: VitalSigns(
              hr: 60,
              sbp: 150,
              dbp: 78,
              rr: 14,
              spo2: 99,
              icp: 30,
              cpp: 60,
              temp: 37.2,
              gcs: 6,
            ),
          ),
        ],
      ),

      // ────────────────────────────────────────────
      // STEP 2 — Refractory ICP elevation
      // ────────────────────────────────────────────
      ScenarioStep(
        id: 'step_2',
        narrative:
            'Thirty minutes later, the ICP begins climbing again. The '
            'monitor now reads 30 mmHg and CPP has fallen to 58 mmHg. '
            'The patient has an EVD (external ventricular drain) in '
            'place. The neurosurgeon wants to try additional medical '
            'management before committing to OR. What is your next best '
            'intervention?',
        vitals: VitalSigns(
          hr: 54,
          sbp: 148,
          dbp: 74,
          rr: 14,
          spo2: 98,
          icp: 30,
          cpp: 58,
          temp: 37.2,
          gcs: 6,
        ),
        imagingFinding: null,
        timeLimit: 45,
        choices: [
          ScenarioChoice(
            text: 'A) Drain CSF via the EVD and give 23.4% HTS 30 mL',
            isCorrect: true,
            consequence:
                'You open the EVD to drain CSF and administer 23.4% '
                'hypertonic saline via central line. ICP drops from 30 '
                'to 18 mmHg over 20 minutes. CPP improves to 72 mmHg. '
                'Sodium rises to 148 mEq/L.',
            explanation:
                'CSF drainage via EVD is a Tier 1 intervention per BTF '
                'guidelines -- it provides immediate ICP reduction by '
                'reducing intracranial volume. Hypertonic saline (HTS) '
                'is an alternative or adjunct osmotic agent to mannitol. '
                '23.4% HTS must be given via central line. Unlike '
                'mannitol, HTS does not cause diuresis (preserves '
                'intravascular volume) and may be preferred in '
                'hypotensive patients. Target sodium 145-155 mEq/L.',
            nextStepId: 'step_3',
            updatedVitals: VitalSigns(
              hr: 64,
              sbp: 142,
              dbp: 72,
              rr: 14,
              spo2: 99,
              icp: 18,
              cpp: 72,
              temp: 37.0,
              gcs: 6,
            ),
          ),
          ScenarioChoice(
            text: 'B) Repeat Mannitol 1 g/kg IV',
            isCorrect: false,
            consequence:
                'A second mannitol dose is given. Serum osmolality rises '
                'to 315 mOsm/L. ICP drops briefly to 24 but rebounds to '
                '28 within 30 minutes. Urine output surges to 400 mL/hr '
                'with risk of hypovolemia.',
            explanation:
                'While repeat mannitol can be used, you have an EVD in '
                'place that should be utilized first as a Tier 1 '
                'intervention. Repeated mannitol dosing risks '
                'hyperosmolality (hold if >320 mOsm/L), renal tubular '
                'injury, and intravascular depletion from its diuretic '
                'effect. Adding HTS as an alternative osmotic agent '
                'while draining CSF provides a multi-modal approach.',
            nextStepId: 'step_3',
            updatedVitals: VitalSigns(
              hr: 68,
              sbp: 136,
              dbp: 68,
              rr: 14,
              spo2: 99,
              icp: 28,
              cpp: 56,
              temp: 37.1,
              gcs: 6,
            ),
          ),
          ScenarioChoice(
            text: 'C) Start Propofol infusion for sedation',
            isCorrect: false,
            consequence:
                'Propofol is started. ICP drops modestly to 26 due to '
                'reduced cerebral metabolic rate, but blood pressure also '
                'falls. CPP decreases to 52 mmHg -- below the critical '
                'threshold of 60.',
            explanation:
                'While adequate sedation and analgesia are important '
                'baseline measures for ICP management, starting propofol '
                'at this point without first utilizing the EVD and '
                'osmotic therapy misses the more effective Tier 1 '
                'interventions. Propofol can cause hypotension, '
                'reducing CPP. The patient should already be adequately '
                'sedated per ICU protocol. Propofol infusion syndrome is '
                'a risk with prolonged high-dose use (>5 mg/kg/hr for '
                '>48 hours).',
            nextStepId: 'step_3',
            updatedVitals: VitalSigns(
              hr: 70,
              sbp: 118,
              dbp: 62,
              rr: 14,
              spo2: 99,
              icp: 26,
              cpp: 52,
              temp: 37.0,
              gcs: 6,
            ),
          ),
          ScenarioChoice(
            text: 'D) Initiate therapeutic hypothermia to 33 degrees C',
            isCorrect: false,
            consequence:
                'Cooling is started. It takes 4-6 hours to reach target '
                'temperature. During that time, ICP remains elevated at '
                '30-32 mmHg. The patient develops shivering and cardiac '
                'arrhythmia.',
            explanation:
                'Prophylactic hypothermia is NOT recommended by the BTF '
                '4th edition guidelines for ICP management in TBI. The '
                'Eurotherm3235 trial (2015) showed increased mortality '
                'with hypothermia as a primary ICP intervention. It is '
                'too slow to address acute ICP crisis and carries risks '
                'of coagulopathy, arrhythmia, infection, and electrolyte '
                'disturbances. If used at all, it is a late-tier rescue '
                'therapy.',
            nextStepId: 'step_3',
            updatedVitals: VitalSigns(
              hr: 48,
              sbp: 146,
              dbp: 76,
              rr: 14,
              spo2: 98,
              icp: 31,
              cpp: 55,
              temp: 35.5,
              gcs: 6,
            ),
          ),
        ],
      ),

      // ────────────────────────────────────────────
      // STEP 3 — Refractory ICP: escalation decision
      // ────────────────────────────────────────────
      ScenarioStep(
        id: 'step_3',
        narrative:
            'Despite CSF drainage and osmotic therapy, ICP has risen again '
            'to 35 mmHg and remains refractory for 30 minutes. CPP is '
            '53 mmHg. Repeat CT shows worsening midline shift to 10 mm '
            'with early uncal herniation. The neurosurgeon asks for your '
            'recommendation on the next escalation step.',
        vitals: VitalSigns(
          hr: 52,
          sbp: 148,
          dbp: 76,
          rr: 14,
          spo2: 98,
          icp: 35,
          cpp: 53,
          temp: 37.0,
          gcs: 5,
        ),
        imagingFinding:
            'Repeat CT: Enlarging right SDH, now 15 mm. Midline shift '
            '10 mm. Effacement of right basal cisterns consistent with '
            'early right uncal herniation. Left lateral ventricle '
            'dilated (early obstructive component).',
        timeLimit: 45,
        choices: [
          ScenarioChoice(
            text: 'A) Emergent decompressive craniectomy with SDH evacuation',
            isCorrect: true,
            consequence:
                'The patient is taken emergently to the OR. A large '
                'right frontotemporal decompressive craniectomy is '
                'performed with SDH evacuation and duraplasty. Post-op '
                'ICP drops to 12 mmHg and CPP recovers to 78 mmHg.',
            explanation:
                'With refractory ICP elevation, worsening midline shift '
                '(>5 mm), and signs of early herniation, emergent '
                'decompressive craniectomy with mass lesion evacuation '
                'is the appropriate escalation. The DECRA trial (2011) '
                'showed that EARLY bifrontal craniectomy for diffuse '
                'injury reduced ICP but worsened functional outcomes, '
                'while the RESCUEicp trial (2016) demonstrated that '
                'craniectomy as LAST-TIER rescue therapy for refractory '
                'ICP reduces mortality (though with increased rates of '
                'vegetative state and severe disability). In the setting '
                'of a surgical mass lesion (SDH) with refractory ICP, '
                'surgery is clearly indicated.',
            nextStepId: 'step_4',
            updatedVitals: VitalSigns(
              hr: 72,
              sbp: 134,
              dbp: 70,
              rr: 14,
              spo2: 99,
              icp: 12,
              cpp: 78,
              temp: 36.8,
              gcs: 6,
            ),
          ),
          ScenarioChoice(
            text: 'B) Initiate pentobarbital coma',
            isCorrect: false,
            consequence:
                'Pentobarbital loading is started. Blood pressure drops '
                'significantly, requiring vasopressor support. ICP '
                'decreases to 25 mmHg but the mass lesion remains '
                'unaddressed. The risk of herniation persists.',
            explanation:
                'Barbiturate coma (pentobarbital or thiopental) is a '
                'Tier 3 intervention for refractory ICP that works by '
                'suppressing cerebral metabolic rate. However, in the '
                'setting of a SURGICAL mass lesion (expanding SDH with '
                '10 mm midline shift and herniation signs), medical '
                'management alone is insufficient. The mass must be '
                'evacuated. Barbiturate coma may be considered for '
                'refractory ICP WITHOUT a surgical lesion. Side effects '
                'include severe hypotension, immunosuppression, and '
                'ileus. Monitor with continuous EEG for burst '
                'suppression.',
            nextStepId: 'step_4',
            updatedVitals: VitalSigns(
              hr: 78,
              sbp: 102,
              dbp: 58,
              rr: 14,
              spo2: 98,
              icp: 25,
              cpp: 43,
              temp: 36.5,
              gcs: 3,
            ),
          ),
          ScenarioChoice(
            text: 'C) Increase HTS infusion and continue monitoring',
            isCorrect: false,
            consequence:
                'Sodium rises to 158 mEq/L but ICP remains 32-35 mmHg. '
                'The patient develops a fixed dilated right pupil '
                'indicating active uncal herniation.',
            explanation:
                'Continuing medical management alone in the face of a '
                'worsening surgical lesion with herniation signs is '
                'inappropriate and dangerous. The SDH is expanding and '
                'causing direct mass effect. Osmotic therapy treats '
                'parenchymal edema but cannot address the volume of an '
                'expanding hematoma. Surgical evacuation is required. '
                'Delaying surgery in this scenario worsens outcomes.',
            nextStepId: 'step_4',
            updatedVitals: VitalSigns(
              hr: 50,
              sbp: 168,
              dbp: 84,
              rr: 14,
              spo2: 97,
              icp: 38,
              cpp: 50,
              temp: 37.0,
              gcs: 4,
            ),
          ),
          ScenarioChoice(
            text: 'D) Lumbar drain placement for additional CSF drainage',
            isCorrect: false,
            consequence:
                'A lumbar drain is placed. CSF drainage from below '
                'worsens the transtentorial pressure gradient. The '
                'patient herniates within minutes -- right pupil becomes '
                'fixed and dilated.',
            explanation:
                'Lumbar drainage in the setting of significant '
                'supratentorial mass effect and midline shift is '
                'CONTRAINDICATED. Removing CSF from below the tentorium '
                'increases the transtentorial pressure gradient, '
                'accelerating downward (uncal/transtentorial) '
                'herniation. This is a critical safety concept. Lumbar '
                'drains may be used cautiously only when there is '
                'communicating hydrocephalus WITHOUT significant mass '
                'effect.',
            nextStepId: 'step_4',
            updatedVitals: VitalSigns(
              hr: 45,
              sbp: 178,
              dbp: 90,
              rr: 8,
              spo2: 94,
              icp: 45,
              cpp: 40,
              temp: 37.0,
              gcs: 3,
            ),
          ),
        ],
      ),

      // ────────────────────────────────────────────
      // STEP 4 — Post-op herniation event
      // ────────────────────────────────────────────
      ScenarioStep(
        id: 'step_4',
        narrative:
            'Post-operatively (or following delayed intervention), the '
            'patient is back in the Neuro-ICU. Six hours after surgery, '
            'the nurse reports the left pupil is now 7 mm and '
            'non-reactive (ipsilateral to the craniectomy site was '
            'right-sided). ICP has acutely risen to 32 mmHg. This '
            'suggests contralateral pathology. What is your immediate '
            'management?',
        vitals: VitalSigns(
          hr: 48,
          sbp: 172,
          dbp: 88,
          rr: 12,
          spo2: 97,
          icp: 32,
          cpp: 56,
          temp: 37.3,
          gcs: 4,
        ),
        imagingFinding:
            'Clinical exam: Left pupil 7 mm, fixed. Right pupil 3 mm, '
            'reactive. Cushing triad developing (bradycardia, '
            'hypertension, irregular respirations).',
        timeLimit: 30,
        choices: [
          ScenarioChoice(
            text:
                'A) Bolus 23.4% HTS, brief hyperventilation, and STAT '
                'repeat CT head',
            isCorrect: true,
            consequence:
                'You administer 30 mL 23.4% HTS via central line and '
                'briefly hyperventilate to PaCO2 30-32 mmHg as a '
                'temporizing measure. ICP drops to 22. STAT CT reveals a '
                'new contralateral (left) epidural hematoma -- the '
                'patient is taken back to OR for emergent evacuation.',
            explanation:
                'A newly dilated pupil contralateral to the surgical '
                'site with rising ICP suggests a new mass lesion '
                '(contralateral EDH is classic after decompressive '
                'craniectomy -- the "talk and die" lesion). Management '
                'is: (1) Bolus osmotic therapy for immediate ICP '
                'reduction, (2) Brief hyperventilation to PaCO2 30-35 '
                'as a TEMPORIZING bridge (not sustained), (3) STAT CT '
                'to identify the new lesion, (4) Emergent surgical '
                'evacuation if mass lesion confirmed. The Cushing triad '
                '(bradycardia, hypertension, irregular breathing) is a '
                'late sign of herniation.',
            nextStepId: 'step_5',
            updatedVitals: VitalSigns(
              hr: 66,
              sbp: 144,
              dbp: 74,
              rr: 14,
              spo2: 99,
              icp: 16,
              cpp: 74,
              temp: 37.1,
              gcs: 6,
            ),
          ),
          ScenarioChoice(
            text: 'B) Administer Mannitol and observe for 30 minutes',
            isCorrect: false,
            consequence:
                'Mannitol provides some ICP reduction but you delay '
                'imaging. Over 30 minutes, the patient develops '
                'bilateral fixed dilated pupils. Emergency CT finally '
                'reveals a large contralateral EDH that has expanded '
                'during the observation period.',
            explanation:
                'While mannitol is appropriate as a temporizing measure, '
                'observation without immediate imaging is dangerous in '
                'this scenario. A new neurological deficit (contralateral '
                'pupil dilation) after surgery demands STAT imaging to '
                'rule out a new surgical lesion. Delays in diagnosis of '
                'contralateral EDH dramatically worsen outcomes. The '
                'time from pupil dilation to irreversible brain damage '
                'can be as short as 60-90 minutes.',
            nextStepId: 'step_5',
            updatedVitals: VitalSigns(
              hr: 42,
              sbp: 182,
              dbp: 92,
              rr: 8,
              spo2: 95,
              icp: 28,
              cpp: 50,
              temp: 37.2,
              gcs: 3,
            ),
          ),
          ScenarioChoice(
            text: 'C) Increase sedation and paralyze the patient',
            isCorrect: false,
            consequence:
                'Paralysis masks further neurological decline. The new '
                'pupil finding is no longer assessable. ICP remains '
                'elevated at 30 mmHg without addressing the underlying '
                'cause.',
            explanation:
                'Neuromuscular blockade obscures the neurological exam, '
                'which is the most important monitoring tool in TBI. '
                'While sedation/paralysis can lower ICP by reducing '
                'intrathoracic pressure and metabolic demand, it must '
                'NEVER be used to mask a new neurological finding. A '
                'new fixed dilated pupil demands urgent investigation '
                '(CT scan), not suppression of the exam. If paralysis '
                'is required, continuous EEG and ICP monitoring become '
                'even more critical.',
            nextStepId: 'step_5',
            updatedVitals: VitalSigns(
              hr: 46,
              sbp: 170,
              dbp: 86,
              rr: 14,
              spo2: 98,
              icp: 30,
              cpp: 54,
              temp: 37.2,
              gcs: 3,
            ),
          ),
          ScenarioChoice(
            text: 'D) Elevate head of bed to 45 degrees and recheck in 1 hour',
            isCorrect: false,
            consequence:
                'Head of bed elevation provides minimal ICP benefit. One '
                'hour later, both pupils are fixed and dilated. The '
                'patient has herniated from an undiagnosed contralateral '
                'EDH.',
            explanation:
                'Head of bed elevation to 30 degrees is a standard '
                'baseline measure in TBI (promotes venous drainage), '
                'but it is NOT adequate as the sole intervention for '
                'acute herniation with a new pupil finding. Waiting one '
                'hour with signs of active herniation (Cushing triad, '
                'new pupil dilation) is a critical error. Every minute '
                'of delay with an expanding mass lesion increases the '
                'risk of irreversible brainstem damage.',
            nextStepId: 'step_5',
            updatedVitals: VitalSigns(
              hr: 38,
              sbp: 192,
              dbp: 96,
              rr: 6,
              spo2: 93,
              icp: 42,
              cpp: 38,
              temp: 37.3,
              gcs: 3,
            ),
          ),
        ],
      ),

      // ────────────────────────────────────────────
      // STEP 5 — Day 3: Hyponatremia
      // ────────────────────────────────────────────
      ScenarioStep(
        id: 'step_5',
        narrative:
            'The patient is now post-op day 3 and has stabilized '
            'neurologically. ICP is well-controlled at 10-12 mmHg. '
            'However, morning labs reveal serum sodium 126 mEq/L '
            '(down from 148 yesterday). Urine output has been 250-300 '
            'mL/hr. Urine osmolality is 450 mOsm/kg and urine sodium '
            'is 180 mEq/L. The patient is clinically euvolemic to '
            'slightly dry. What is the most likely diagnosis and '
            'appropriate treatment?',
        vitals: VitalSigns(
          hr: 82,
          sbp: 118,
          dbp: 68,
          rr: 14,
          spo2: 99,
          icp: 11,
          cpp: 69,
          temp: 37.0,
          gcs: 8,
        ),
        imagingFinding: null,
        timeLimit: 60,
        choices: [
          ScenarioChoice(
            text:
                'A) Cerebral salt wasting (CSW) -- treat with isotonic '
                'saline volume repletion and fludrocortisone',
            isCorrect: true,
            consequence:
                'You diagnose CSW based on the clinical picture: '
                'hyponatremia with high urine output, high urine sodium, '
                'and volume depletion after TBI. Aggressive isotonic '
                'saline replacement and fludrocortisone 0.1 mg BID are '
                'started. Sodium gradually corrects to 134 over 48 hours '
                'with improved volume status.',
            explanation:
                'Cerebral salt wasting (CSW) is the most common cause '
                'of hyponatremia after TBI/SAH. Key distinguishing '
                'features from SIADH: (1) CSW = volume DEPLETED with '
                'high urine output; SIADH = euvolemic/hypervolemic with '
                'low urine output. (2) Both have high urine sodium and '
                'concentrated urine. (3) CSW is mediated by BNP/ANP '
                'release from injured brain. Treatment: volume repletion '
                'with normal saline + fludrocortisone (mineralocorticoid '
                'to promote sodium retention). SIADH treatment (fluid '
                'restriction) would worsen CSW by further depleting '
                'volume. Board pearl: in TBI, assume CSW until proven '
                'otherwise.',
            nextStepId: null,
            updatedVitals: VitalSigns(
              hr: 76,
              sbp: 128,
              dbp: 72,
              rr: 14,
              spo2: 99,
              icp: 10,
              cpp: 72,
              temp: 37.0,
              gcs: 8,
            ),
          ),
          ScenarioChoice(
            text: 'B) SIADH -- treat with fluid restriction to 1 L/day',
            isCorrect: false,
            consequence:
                'Fluid restriction is initiated. The patient becomes '
                'more hypovolemic -- urine output remains high (the '
                'kidneys continue wasting sodium). Blood pressure drops '
                'to 98/58, CPP falls, and sodium continues to decline '
                'to 122 mEq/L.',
            explanation:
                'This presentation is NOT SIADH. The key distinction: '
                'this patient has HIGH urine output (250-300 mL/hr) and '
                'is volume depleted, both pointing to CSW rather than '
                'SIADH. SIADH patients are euvolemic with LOW-NORMAL '
                'urine output because they are retaining free water. '
                'Fluid restriction for CSW is dangerous -- it worsens '
                'hypovolemia and can precipitate cerebral vasospasm and '
                'secondary ischemia. In TBI, always assess volume '
                'status carefully before restricting fluids.',
            nextStepId: null,
            updatedVitals: VitalSigns(
              hr: 96,
              sbp: 98,
              dbp: 58,
              rr: 16,
              spo2: 99,
              icp: 14,
              cpp: 52,
              temp: 37.0,
              gcs: 8,
            ),
          ),
          ScenarioChoice(
            text: 'C) Acute hyponatremia -- bolus 3% HTS to correct quickly',
            isCorrect: false,
            consequence:
                'Aggressive HTS correction raises sodium from 126 to '
                '138 over 12 hours. The rapid correction rate of '
                '12 mEq/L/day puts the patient at risk for osmotic '
                'demyelination syndrome (central pontine myelinolysis).',
            explanation:
                'While 3% HTS may be used for symptomatic hyponatremia '
                '(seizures, obtundation from low sodium), rapid '
                'correction is dangerous. The safe rate is no more than '
                '8-10 mEq/L in 24 hours (some guidelines say 6-8). '
                'Exceeding this risks osmotic demyelination syndrome '
                '(ODS), which causes devastating locked-in syndrome or '
                'death. More importantly, this does not address the '
                'underlying cause (CSW). The correct approach is volume '
                'repletion with isotonic saline + fludrocortisone for '
                'the underlying CSW, with HTS reserved only for acute '
                'symptomatic correction.',
            nextStepId: null,
            updatedVitals: VitalSigns(
              hr: 78,
              sbp: 132,
              dbp: 72,
              rr: 14,
              spo2: 99,
              icp: 10,
              cpp: 74,
              temp: 37.0,
              gcs: 8,
            ),
          ),
          ScenarioChoice(
            text: 'D) Diabetes insipidus -- start DDAVP',
            isCorrect: false,
            consequence:
                'DDAVP is given. The patient retains free water, and '
                'sodium drops further to 120 mEq/L. The patient '
                'develops seizures from severe hyponatremia.',
            explanation:
                'Diabetes insipidus (DI) causes HYPERnatremia (not '
                'hyponatremia) because the kidneys cannot concentrate '
                'urine (low ADH). DI urine would be DILUTE (low '
                'osmolality <300) with high volume, and serum sodium '
                'would be ELEVATED. This patient has HYPOnatremia with '
                'CONCENTRATED urine -- the opposite of DI. Giving DDAVP '
                'to a patient with CSW-mediated hyponatremia would '
                'worsen the hyponatremia by causing water retention. '
                'Board pearl: DI = high sodium + dilute urine; '
                'CSW = low sodium + concentrated urine + volume depleted; '
                'SIADH = low sodium + concentrated urine + euvolemic.',
            nextStepId: null,
            updatedVitals: VitalSigns(
              hr: 88,
              sbp: 124,
              dbp: 66,
              rr: 14,
              spo2: 99,
              icp: 12,
              cpp: 64,
              temp: 37.0,
              gcs: 7,
            ),
          ),
        ],
      ),
    ],
  );
}
