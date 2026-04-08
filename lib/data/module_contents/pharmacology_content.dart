import 'package:flutter/material.dart';
import '../models/topic_content_model.dart';

final TopicData pharmacologyContent = TopicData(
  id: 'tbi-pharmacology',
  title: 'TBI Pharmacology',
  tabs: [
    TopicTab(
      title: 'Medications to AVOID',
      blocks: [
        HeaderBlock('Medications to AVOID After TBI'),
        TextBlock(
          'The catecholaminergic hypothesis of TBI recovery posits that dopaminergic, noradrenergic, and cholinergic neurotransmitter systems are critical for neural repair, plasticity, and functional recovery. Medications that antagonize these systems can impede recovery and worsen outcomes. The following medications should be AVOIDED or used with extreme caution after TBI. This is one of the highest-yield pharmacology topics on the PM&R board exam.',
          isIntro: true,
        ),
        MedicationCardBlock(
          name: 'Haloperidol',
          drugClass: 'Typical Antipsychotic (Butyrophenone)',
          mechanism:
              'D2 dopamine receptor antagonist; blocks dopaminergic pathways in ALL four dopamine tracts (mesolimbic, mesocortical, nigrostriatal, tuberoinfundibular)',
          indication: 'AVOID in TBI whenever possible',
          sideEffects:
              'Hinders spatial learning and motor recovery in animal models; prolongs PTA; extrapyramidal symptoms (EPS); neuroleptic malignant syndrome risk; QTc prolongation',
          boardPearl:
              'Haloperidol is the prototypical medication to AVOID in TBI. Typical antipsychotics as a class impair neuroplasticity and slow motor and cognitive recovery post-TBI. If an antipsychotic is absolutely necessary, use an ATYPICAL at the lowest dose for the shortest duration.',
          isAvoid: true,
        ),
        MedicationCardBlock(
          name: 'Phenytoin (Chronic Use)',
          drugClass: 'Anticonvulsant (Hydantoin)',
          mechanism:
              'Sodium channel blocker; slows neuronal firing. Also induces CYP450 enzymes (multiple drug interactions)',
          indication:
              'APPROPRIATE for ACUTE use: 7-day seizure prophylaxis per BTF guidelines. AVOID for chronic use (> 7 days)',
          sideEffects:
              'Cognitive impairment (attention, processing speed, memory); impairs motor recovery; gingival hyperplasia; cerebellar toxicity; osteoporosis; hepatotoxicity; teratogenicity',
          boardPearl:
              'Phenytoin is effective for EARLY PTS prophylaxis (Temkin trial) but NOT for late PTS. Chronic use impedes cognitive and motor recovery. After 7 days, DISCONTINUE unless treating documented seizures. Consider switching to levetiracetam for ongoing seizure management.',
          isAvoid: true,
        ),
        MedicationCardBlock(
          name: 'Benzodiazepines',
          drugClass: 'GABA-A Receptor Positive Allosteric Modulator',
          mechanism:
              'Enhances GABA-A receptor function by increasing chloride channel opening frequency; produces widespread CNS depression',
          indication:
              'AVOID in TBI for agitation, anxiety, insomnia. EXCEPTION: Acute seizure management (IV lorazepam for status epilepticus)',
          sideEffects:
              'Excessive sedation; impairs cognitive function, attention, and new learning; paradoxical agitation (especially in elderly and brain-injured); impairs neuroplasticity; dependence and withdrawal risk',
          boardPearl:
              'Benzodiazepines are one of the most commonly tested "avoid" medications in TBI. They impair motor recovery, worsen confusion, and can cause paradoxical agitation. The ONLY acceptable use is for acute seizure management. Never use for agitation or insomnia in TBI.',
          isAvoid: true,
        ),
        MedicationCardBlock(
          name: 'Anticholinergics',
          drugClass: 'Muscarinic Acetylcholine Receptor Antagonists',
          mechanism:
              'Block muscarinic acetylcholine receptors; acetylcholine is critical for memory formation, learning, and attention in the hippocampus and cortex',
          indication: 'AVOID in TBI -- the cholinergic system is already impaired after injury',
          sideEffects:
              'Worsened cognition, delirium, confusion, urinary retention, constipation, dry mouth, tachycardia, blurred vision',
          boardPearl:
              'Common anticholinergic offenders to remember: diphenhydramine (Benadryl), oxybutynin (Ditropan), tricyclic antidepressants (amitriptyline, nortriptyline), promethazine, scopolamine. The cholinergic system is ALREADY impaired after TBI; further blockade worsens cognition dramatically.',
          isAvoid: true,
        ),
        MedicationCardBlock(
          name: 'Dopamine Antagonists (as a Class)',
          drugClass: 'D2 Receptor Blockers',
          mechanism:
              'Block D2 receptors in frontal-subcortical circuits essential for executive function, motivation, initiation, and motor recovery',
          indication:
              'AVOID: typical antipsychotics (haloperidol, chlorpromazine), metoclopramide (Reglan), prochlorperazine (Compazine), droperidol',
          sideEffects:
              'Impaired neuroplasticity, slowed motor recovery, prolonged PTA, EPS, hyperprolactinemia, neuroleptic malignant syndrome',
          boardPearl:
              'The catecholaminergic hypothesis: dopaminergic systems are critical for neural repair. Blocking D2 receptors impedes recovery. If antiemetics are needed, use ondansetron (5-HT3 antagonist) instead of metoclopramide. If an antipsychotic is necessary, use an atypical (quetiapine at lowest dose) rather than a typical.',
          isAvoid: true,
        ),
        MedicationCardBlock(
          name: 'Phenobarbital',
          drugClass: 'Barbiturate Anticonvulsant',
          mechanism:
              'Enhances GABA-A receptor function by increasing chloride channel opening DURATION (contrast with benzodiazepines which increase FREQUENCY); also directly activates GABA-A at high doses',
          indication:
              'AVOID as first-line anticonvulsant in TBI; high-dose pentobarbital coma is a last-tier therapy for refractory ICP elevation',
          sideEffects:
              'Profound sedation; cognitive impairment; respiratory depression; impairs motor and cognitive recovery; dependence; narrow therapeutic index',
          boardPearl:
              'Phenobarbital is listed alongside benzodiazepines as a medication that impairs TBI recovery via GABAergic mechanism. Key pharmacology distinction: barbiturates increase chloride channel opening DURATION, benzodiazepines increase opening FREQUENCY. Both are tested on boards.',
          isAvoid: true,
        ),
        HeaderBlock('Summary: The AVOID List'),
        TableBlock(
          title: 'Quick Reference: Medications to AVOID in TBI',
          columns: ['Drug/Class', 'Mechanism of Harm', 'Mnemonic Aid'],
          headerColor: const Color(0xFFDC2626),
          rows: [
            ['Haloperidol / Typical antipsychotics', 'D2 blockade impairs recovery', 'Blocks dopamine = blocks recovery'],
            ['Phenytoin (chronic)', 'Cognitive impairment, impedes recovery', 'Use for 7 days ONLY'],
            ['Benzodiazepines', 'GABAergic sedation, paradoxical agitation', 'Paradoxical agitation in TBI'],
            ['Anticholinergics', 'Block ACh needed for memory/learning', 'Cholinergic system already damaged'],
            ['Metoclopramide', 'D2 antagonist', 'Use ondansetron instead'],
            ['Phenobarbital', 'GABAergic sedation', 'Never first-line AED in TBI'],
          ],
        ),
        PearlBlock(
          'Board Pearl: General Principle',
          '"START LOW, GO SLOW" is the cardinal rule of TBI pharmacology. The injured brain has altered blood-brain barrier permeability, disrupted neurotransmitter systems, and heightened sensitivity to sedating medications. Always start at the lowest effective dose and titrate slowly. Avoid polypharmacy whenever possible -- every additional medication increases the risk of drug interactions and cognitive side effects.',
        ),
      ],
    ),
    TopicTab(
      title: 'Medications to PROMOTE',
      blocks: [
        HeaderBlock('Medications That PROMOTE Recovery After TBI'),
        TextBlock(
          'Medications that enhance catecholaminergic (dopaminergic, noradrenergic) and cholinergic neurotransmission may facilitate neurological recovery after TBI. These agents target specific neurocognitive deficits including attention, arousal, memory, and processing speed. Understanding the mechanism, evidence level, and appropriate indication for each agent is critical for board preparation.',
          isIntro: true,
        ),
        MedicationCardBlock(
          name: 'Methylphenidate',
          drugClass: 'Psychostimulant (Phenethylamine)',
          mechanism:
              'Blocks dopamine transporter (DAT) and norepinephrine transporter (NET) reuptake; increases catecholamine availability in the synaptic cleft',
          indication:
              'Attention deficits, processing speed impairment, cognitive fatigue after TBI',
          dosing:
              'Start 5 mg BID (morning and noon); titrate by 5 mg every 3-7 days; max 60 mg/day; avoid evening dosing (insomnia)',
          sideEffects:
              'Insomnia, decreased appetite, tachycardia, anxiety, headache; may lower seizure threshold (low risk)',
          boardPearl:
              'Methylphenidate has the STRONGEST evidence among neurostimulants for attention improvement post-TBI. It is the first-line pharmacotherapy for attention deficits after TBI. Key mechanism: blocks REUPTAKE of DA and NE (does not release dopamine like amphetamines).',
        ),
        MedicationCardBlock(
          name: 'Amantadine',
          drugClass: 'Dopaminergic Agent / NMDA Antagonist',
          mechanism:
              'Enhances presynaptic dopamine RELEASE (exogenous dopamine); weak NMDA receptor antagonist (may reduce excitotoxicity); has mild anticholinergic properties',
          indication:
              '(1) Disorders of consciousness -- accelerates functional recovery (Giacino NEJM 2012, Level B); (2) Irritability/agitation at 100 mg BID; (3) Fatigue; (4) Cognitive slowing and initiation deficits',
          dosing:
              'DOC: 100 mg BID, titrate to max 200 mg BID; second dose by NOON to avoid insomnia; adjust for renal impairment (renally cleared)',
          sideEffects:
              'Insomnia, agitation (dose-related), seizures (may lower threshold), livedo reticularis, peripheral edema; nephrotoxicity (renal clearance)',
          boardPearl:
              'Amantadine is the ONLY medication with Level 1 / Class I evidence (AAN Level B recommendation) for accelerating recovery from disorders of consciousness. The Giacino 2012 trial showed faster DRS improvement in VS/MCS patients 4-16 weeks post-TBI. Effect is PHARMACOLOGICAL (not disease-modifying) -- groups converged after washout.',
        ),
        MedicationCardBlock(
          name: 'Bromocriptine',
          drugClass: 'Ergot Dopamine Agonist',
          mechanism:
              'Direct D2 dopamine receptor agonist; stimulates postsynaptic D2 receptors (increases ENDOGENOUS dopaminergic activity)',
          indication:
              'Executive dysfunction, initiation deficits, akinetic mutism, apathy/abulia (frontal lobe-mediated deficits)',
          dosing: 'Start 1.25-2.5 mg daily; titrate slowly to 5-15 mg/day in divided doses',
          sideEffects:
              'Hypotension (significant, especially first dose), nausea, dizziness, headache, confusion at high doses',
          boardPearl:
              'Bromocriptine is the agent of choice for frontal lobe-mediated executive dysfunction and akinetic mutism. It increases ENDOGENOUS dopamine (direct D2 agonist) -- contrast with amantadine which increases EXOGENOUS dopamine (presynaptic release). Watch for hypotension, especially with the first dose.',
        ),
        MedicationCardBlock(
          name: 'Modafinil',
          drugClass: 'Wakefulness-Promoting Agent',
          mechanism:
              'Exact mechanism not fully understood; may enhance dopamine, norepinephrine, and histamine neurotransmission; inhibits DAT weakly; distinct from traditional stimulants',
          indication:
              'Excessive daytime sleepiness (EDS), fatigue post-TBI, sleep-wake cycle disruption',
          dosing: '100-200 mg daily (morning); start low, may increase to 400 mg if needed',
          sideEffects:
              'Headache, nausea, anxiety, insomnia; rare: Stevens-Johnson syndrome (especially in pediatric populations)',
          boardPearl:
              'Modafinil is preferred over traditional stimulants for fatigue and EDS when attention is not the primary deficit. Lower abuse potential than methylphenidate. Does not significantly affect blood pressure or heart rate at standard doses.',
        ),
        MedicationCardBlock(
          name: 'Donepezil',
          drugClass: 'Acetylcholinesterase Inhibitor',
          mechanism:
              'Inhibits acetylcholinesterase enzyme, increasing acetylcholine availability at cholinergic synapses; targets the cholinergic deficit that occurs after TBI',
          indication:
              'Memory deficits post-TBI, particularly declarative/episodic memory impairment',
          dosing: 'Start 5 mg daily; may increase to 10 mg daily after 4-6 weeks',
          sideEffects:
              'Nausea, diarrhea, insomnia, vivid dreams, bradycardia, muscle cramps',
          boardPearl:
              'Donepezil targets the CHOLINERGIC deficit after TBI. Acetylcholine is critical for memory formation in the hippocampus. Acetylcholinesterase inhibitors have evidence for memory improvement after TBI. Complements dopaminergic agents which primarily target attention and executive function.',
        ),
        HeaderBlock('Summary: The PROMOTE List'),
        TableBlock(
          title: 'Quick Reference: Medications to PROMOTE Recovery',
          columns: ['Drug', 'Primary Target', 'Mechanism Key Word', 'First-Line For'],
          headerColor: const Color(0xFF059669),
          rows: [
            ['Methylphenidate', 'Attention, processing speed', 'DA/NE REUPTAKE blocker', 'Attention deficits (strongest evidence)'],
            ['Amantadine', 'Arousal, DOC recovery', 'DA RELEASE + NMDA antagonist', 'Disorders of consciousness (only Level B evidence)'],
            ['Bromocriptine', 'Executive function, initiation', 'Direct D2 AGONIST', 'Akinetic mutism, frontal lobe deficits'],
            ['Modafinil', 'Wakefulness, fatigue', 'Multiple (DA/NE/histamine)', 'Excessive daytime sleepiness'],
            ['Donepezil', 'Memory', 'AChE INHIBITOR', 'Declarative memory deficits'],
          ],
        ),
        HeaderBlock('Amantadine Evidence Deep Dive: Giacino NEJM 2012'),
        TextBlock(
          'The Giacino et al. 2012 NEJM trial is the landmark study establishing amantadine as the only agent with Class I evidence for disorders of consciousness after TBI. This is one of the most frequently referenced TBI pharmacology studies on board exams.',
        ),
        BulletCardBlock(
          title: 'Giacino NEJM 2012: Key Study Details',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Design: Multicenter, randomized, double-blind, placebo-controlled trial (n=184)',
            'Population: Patients in vegetative state (VS) or minimally conscious state (MCS), 4-16 weeks post-TBI, receiving inpatient rehabilitation',
            'Intervention: Amantadine escalated dosing (100 mg BID weeks 1-2, 150 mg BID week 3, 200 mg BID week 4 based on response) for 4 weeks, followed by 2-week washout',
            'Primary outcome: Disability Rating Scale (DRS) slope of improvement during treatment',
            'Result: Amantadine group had significantly faster DRS improvement -- 0.24 points/week faster than placebo (P = .007)',
            'Washout finding: After discontinuation, improvement SLOWED in the amantadine group (0.30 points/week slower, P = .02), and groups converged by week 6',
            'Interpretation: Amantadine has a PHARMACOLOGICAL effect (accelerates recovery during use) but is NOT disease-modifying (groups equalized after washout)',
            'AAN guideline: Level B recommendation for amantadine 100-200 mg BID to promote functional recovery from VS/MCS after TBI',
          ],
        ),
        BulletCardBlock(
          title: 'Amantadine Mechanism and Uses Beyond DOC',
          themeColor: const Color(0xFF0D9488),
          backgroundColor: const Color(0xFFF0FDFA),
          points: [
            'Dual mechanism: (1) Enhances presynaptic dopamine RELEASE, (2) Weak NMDA receptor antagonist reducing excitotoxicity',
            'Also has mild anticholinergic properties and may increase norepinephrine release',
            'Beyond DOC: Used for fatigue, cognitive slowing, and initiation deficits in higher-functioning TBI patients',
            'Agitation: 100 mg BID effective for posttraumatic agitation (also in Cochrane-reviewed agents)',
            'Dosing pearl: Second dose by NOON to avoid insomnia; renally cleared -- adjust for renal impairment',
            'Key side effects to know: insomnia, agitation at higher doses, livedo reticularis, peripheral edema, may lower seizure threshold',
          ],
        ),
        PearlBlock(
          'Board Pearl: Amantadine Key Takeaways',
          'Amantadine is the ONLY medication with Level 1/Class I evidence (AAN Level B recommendation) for disorders of consciousness after TBI. The Giacino 2012 trial is the landmark study: n=184, VS/MCS patients 4-16 weeks post-TBI, 100 mg BID escalated to 200 mg BID. Faster DRS improvement during treatment, but groups converged after washout -- meaning the effect is pharmacological, NOT disease-modifying. Beyond DOC, amantadine is also used for fatigue, initiation deficits, and agitation.',
        ),
        HeaderBlock('Modafinil Evidence Update'),
        TextBlock(
          'Modafinil is a wakefulness-promoting agent increasingly used for fatigue and excessive daytime sleepiness (EDS) after TBI. The evidence base is growing but remains mixed, making it important to understand what it does and does not treat.',
        ),
        BulletCardBlock(
          title: 'Modafinil: Evidence Summary',
          themeColor: const Color(0xFF6366F1),
          backgroundColor: const Color(0xFFEEF2FF),
          points: [
            'Excessive daytime sleepiness (EDS): Class I evidence supports modafinil 100-200 mg daily for post-TBI EDS; improved maintenance of wakefulness test scores',
            'Fatigue: Evidence is INCONSISTENT; some studies show benefit, but a Class I trial found NO improvement in post-TBI fatigue vs placebo',
            'Clinical distinction: EDS (difficulty staying awake) is different from fatigue (subjective exhaustion); modafinil is better for EDS than for fatigue',
            'Dosing: Start 100 mg daily in the morning; may increase to 200 mg; maximum 400 mg/day if needed',
            'Mechanism: Weak DAT inhibitor plus enhancement of NE, histamine, and orexin pathways; distinct pharmacology from traditional stimulants',
            'Advantages over methylphenidate: Lower abuse potential (Schedule IV vs Schedule II); less cardiovascular stimulation; fewer appetite effects',
            'Disadvantages vs methylphenidate: Less evidence for attention deficits; does not primarily target attention/processing speed',
            'Rare but serious: Stevens-Johnson syndrome (especially in pediatric populations); discontinue immediately if rash develops',
          ],
        ),
        PearlBlock(
          'Board Pearl: Modafinil vs Methylphenidate',
          'Modafinil and methylphenidate target DIFFERENT symptoms. Methylphenidate is first-line for ATTENTION deficits (strongest evidence). Modafinil is preferred for EXCESSIVE DAYTIME SLEEPINESS when attention is not the primary problem. Modafinil has lower abuse potential (Schedule IV) and less cardiovascular stimulation. For pure fatigue without EDS, neither agent has strong evidence, but modafinil is more commonly trialed. Key teaching point: always clarify whether the patient has an attention deficit, sleepiness, or fatigue -- the treatment differs for each.',
        ),
        HeaderBlock('Bromocriptine Evidence Update'),
        TextBlock(
          'Bromocriptine is a direct D2 dopamine receptor agonist used for frontal lobe-mediated deficits after TBI. The Whyte et al. studies provide the primary evidence base for its use in executive dysfunction.',
        ),
        BulletCardBlock(
          title: 'Bromocriptine: Key Evidence and Clinical Use',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFF0FDF4),
          points: [
            'Whyte 2008 (pilot study): Placebo-controlled trial of low-dose bromocriptine for attention deficits after TBI',
            'Key finding: Improved executive function and dual-task performance, but did NOT improve simple working memory maintenance',
            'Interpretation: Bromocriptine targets EXECUTIVE/FRONTAL deficits (planning, initiation, cognitive flexibility), not basic memory storage',
            'McDowell 1998: Earlier study showing bromocriptine improved executive function measures in TBI patients with frontal lobe injury',
            'Best indications: Akinetic mutism, severe apathy/abulia, executive dysfunction, initiation deficits -- all frontal lobe-mediated',
            'Mechanism: Direct D2 agonist (ENDOGENOUS dopamine stimulation) vs amantadine which enhances EXOGENOUS dopamine release',
            'Dosing: Start 1.25-2.5 mg daily; titrate slowly to 5-15 mg/day in divided doses',
            'Major side effect: HYPOTENSION (especially first-dose phenomenon); also nausea, dizziness, confusion at higher doses',
            'Recommended by Neurostimulant Task Force for executive dysfunction after TBI, though evidence level remains moderate',
          ],
        ),
        HeaderBlock('SSRIs in TBI: Beyond Depression'),
        TextBlock(
          'Selective serotonin reuptake inhibitors are first-line for depression and anxiety after TBI, but emerging evidence suggests potential roles in motor recovery and agitation management.',
        ),
        BulletCardBlock(
          title: 'SSRI Evidence in TBI and Brain Injury',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'FLAME Trial (Chollet 2011): Fluoxetine 20 mg daily improved MOTOR RECOVERY after acute ischemic stroke (Fugl-Meyer score); NOTE: this was a STROKE trial, not TBI, but often cited in TBI pharmacology discussions',
            'FLAME showed motor benefit was INDEPENDENT of antidepressant effect -- suggesting direct neuroplasticity mechanism via BDNF upregulation',
            'IMPORTANT: Subsequent larger trials (FOCUS, AFFINITY, EFFECTS) did NOT confirm motor recovery benefit of fluoxetine after stroke; increased fracture and hyponatremia risk',
            'Sertraline: Preferred SSRI for depression and anxiety in TBI; fewest drug interactions (minimal CYP450 inhibition); well-tolerated',
            'Citalopram/Escitalopram: Evidence for agitation reduction in TBI; citalopram 20 mg studied for irritability and emotional lability post-TBI',
            'SSRIs and seizure risk: SSRIs are generally SAFE regarding seizure threshold (unlike bupropion or TCAs); preferred in patients with seizure history',
            'Caution: SSRIs may worsen APATHY by dampening emotional reactivity -- always distinguish depression from apathy before prescribing',
            'Serotonin syndrome risk: Monitor when combining SSRIs with tramadol, triptans, or other serotonergic agents commonly used in TBI rehab',
          ],
        ),
        PearlBlock(
          'Board Pearl: FLAME Trial Context',
          'The FLAME trial (2011) showed fluoxetine improved motor recovery after ischemic stroke, generating excitement about SSRIs for neuroplasticity. However, three larger subsequent trials (FOCUS, AFFINITY, EFFECTS) FAILED to replicate motor benefits and showed increased adverse effects (fractures, hyponatremia). For board purposes: (1) SSRIs remain FIRST-LINE for depression/anxiety after TBI, (2) the motor recovery hypothesis is NOT supported by current evidence, (3) sertraline has the fewest drug interactions, (4) always distinguish depression from apathy -- SSRIs may worsen apathy.',
        ),
        HeaderBlock('Cannabis and CBD in TBI'),
        TextBlock(
          'Cannabis and cannabidiol (CBD) are increasingly used by TBI survivors. Understanding the current evidence, policies, and risks is essential for clinical practice and board preparation.',
        ),
        BulletCardBlock(
          title: 'Cannabis/CBD: Current Evidence and Risks',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Preclinical evidence: CBD has anti-inflammatory, antioxidant, and anticonvulsant properties with theoretical neuroprotective potential against secondary injury cascade',
            'Clinical evidence: NO randomized controlled trials of cannabis or CBD specifically for TBI recovery outcomes; all evidence is preclinical or observational',
            'VA/DOD position: Strongly AGAINST medical marijuana use; VA cannot prescribe or recommend cannabis (remains Schedule I federally)',
            'VA policy: VA clinicians may discuss cannabis use with patients but cannot recommend it; veterans using cannabis are not penalized in VA care',
            'Key risk -- Cognitive dysfunction: A 2024 study found veterans with TBI and cannabis use disorder (CUD) had significantly higher risk of developing cognitive disorders including dementia',
            'Psychosis risk: Cannabis use increases risk of psychotic symptoms; particularly concerning in TBI patients who already have frontal lobe vulnerability',
            'Seizure threshold: THC may LOWER seizure threshold (concerning in TBI population); CBD may have anticonvulsant effects (FDA-approved for certain epilepsy syndromes as Epidiolex)',
            'Other risks: Impaired motivation and executive function (worsens frontal lobe deficits), memory impairment (worsens hippocampal dysfunction), dependency potential',
            'Drug interactions: Cannabis inhibits CYP2C19 and CYP3A4; may interact with anticonvulsants, antidepressants, and other medications',
            'Bottom line: Insufficient evidence to recommend; significant risks in TBI population; discuss openly with patients but do not prescribe',
          ],
        ),
        PearlBlock(
          'Board Pearl: Cannabis in TBI',
          'Cannabis and CBD lack RCT evidence for TBI. Key risks include worsened cognition (especially with cannabis use disorder), psychosis risk, and potential lowering of seizure threshold with THC. The VA cannot prescribe cannabis. CBD (Epidiolex) is FDA-approved for certain epilepsy syndromes but NOT for TBI. For board purposes: cannabis is NOT recommended for TBI recovery, and cannabis use disorder is associated with worse cognitive outcomes in TBI veterans.',
        ),
        HeaderBlock('Neurostimulant Comparison'),
        TableBlock(
          title: 'Neurostimulant Comparison: Head-to-Head',
          columns: ['Feature', 'Methylphenidate', 'Amantadine', 'Modafinil', 'Bromocriptine'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'Mechanism',
              'DA/NE reuptake inhibitor',
              'DA release + NMDA antagonist',
              'Weak DAT inhibitor + NE/histamine',
              'Direct D2 agonist',
            ],
            [
              'Primary target',
              'Attention, processing speed',
              'Arousal, DOC, agitation',
              'Excessive daytime sleepiness',
              'Executive function, initiation',
            ],
            [
              'Evidence level',
              'Strongest for attention',
              'Only Class I for DOC (Giacino 2012)',
              'Class I for EDS; inconsistent for fatigue',
              'Moderate (Whyte 2008 pilot)',
            ],
            [
              'Typical dosing',
              '5-20 mg BID (max 60 mg/day)',
              '100-200 mg BID (by noon)',
              '100-200 mg daily (AM)',
              '1.25-15 mg/day (divided)',
            ],
            [
              'Key side effects',
              'Insomnia, anorexia, tachycardia',
              'Insomnia, livedo reticularis, edema',
              'Headache, nausea, rare SJS',
              'HYPOTENSION (first-dose), nausea',
            ],
            [
              'Schedule',
              'Schedule II (highest abuse potential)',
              'Not scheduled',
              'Schedule IV (low abuse potential)',
              'Not scheduled',
            ],
            [
              'Renal adjustment',
              'No',
              'YES (renally cleared)',
              'No (hepatic metabolism)',
              'No (hepatic metabolism)',
            ],
            [
              'Unique advantage',
              'Best evidence for attention',
              'Only proven agent for DOC; also treats agitation',
              'Lowest abuse potential; wakefulness-specific',
              'Best for frontal lobe deficits; direct D2 agonist',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: Choosing the Right Neurostimulant',
          'Match the neurostimulant to the deficit: (1) Attention/processing speed = methylphenidate (first-line, strongest evidence), (2) Disorders of consciousness = amantadine (ONLY Class I evidence, AAN Level B), (3) Excessive daytime sleepiness = modafinil (lower abuse potential), (4) Executive dysfunction/akinetic mutism = bromocriptine (direct D2 agonist). The agents are NOT interchangeable -- choosing the wrong one for the wrong deficit will not work. Also remember donepezil for MEMORY deficits (cholinergic mechanism, complements dopaminergic agents).',
        ),
      ],
    ),
    TopicTab(
      title: 'Sleep, Mood & Interactions',
      blocks: [
        HeaderBlock('Sleep Medications in TBI'),
        TextBlock(
          'Sleep disturbance affects 30-70% of TBI patients and can impair cognitive recovery, increase agitation, and worsen mood disorders. Medication selection must account for the TBI-impaired brain. Many common sleep aids are contraindicated due to anticholinergic or GABAergic properties.',
          isIntro: true,
        ),
        TableBlock(
          title: 'Sleep Medication Choices in TBI',
          columns: ['Medication', 'Mechanism', 'Status', 'Board Pearl'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'Trazodone',
              '5-HT2A antagonist, mild H1 antihistamine',
              'FIRST CHOICE',
              'Non-habit forming; 50-100 mg QHS; also used for agitation; does not significantly impair cognition',
            ],
            [
              'Melatonin',
              'MT1/MT2 melatonin receptor agonist',
              'SAFE -- Recommended',
              'Helps circadian rhythm disruption; start 3-5 mg QHS; safe, non-habit forming; particularly useful for sleep-wake cycle disruption',
            ],
            [
              'Quetiapine (low dose)',
              'D2/5-HT2A antagonist, H1 antagonist',
              'Use cautiously',
              'May impair recovery at higher doses (dopamine blockade); 25-50 mg QHS; sedation from H1 antagonism at low doses',
            ],
            [
              'Benzodiazepines',
              'GABA-A positive allosteric modulator',
              'AVOID',
              'Impair cognition, paradoxical agitation, dependence, impair neuroplasticity',
            ],
            [
              'Diphenhydramine',
              'H1 antihistamine / anticholinergic',
              'AVOID',
              'Significant anticholinergic effects worsen cognition in TBI; not just sedating -- actively harmful',
            ],
            [
              'Zolpidem',
              'GABA-A modulator (imidazopyridine)',
              'AVOID (for sleep)',
              'Falls risk, paradoxical excitation possible; note: paradoxical arousal effect in some DOC patients (separate phenomenon)',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: Sleep in TBI',
          'Trazodone is the first-line sleep medication in TBI: serotonergic mechanism, non-habit forming, no significant cognitive impairment, and may have mild antidepressant benefit. Melatonin is also recommended for circadian rhythm disruption. AVOID benzodiazepines, diphenhydramine, and zolpidem for sleep in TBI patients.',
        ),
        HeaderBlock('Depression & Anxiety Treatment in TBI'),
        TextBlock(
          'Depression affects 25-50% of TBI survivors and is the most common psychiatric complication. Anxiety disorders (including PTSD) affect 11-24%. Appropriate pharmacotherapy must balance efficacy with seizure risk and cognitive effects.',
        ),
        BulletCardBlock(
          title: 'Preferred Agents for Depression',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFF0FDF4),
          points: [
            'SSRIs: FIRST-LINE (sertraline, citalopram); fewest drug interactions, best tolerated, do not impair cognition',
            'SNRIs: Venlafaxine, duloxetine -- useful if comorbid pain or fatigue; dual mechanism may address both mood and energy',
            'Methylphenidate: Can help apathy/abulia that MIMICS depression -- important distinction; frontal lobe injury causes apathy that looks like depression but does not respond well to SSRIs',
          ],
        ),
        BulletCardBlock(
          title: 'Agents to Use with Caution',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Bupropion: Lowers seizure threshold -- CONTRAINDICATED if active seizure disorder or high seizure risk; may be used cautiously if no seizure history and antidepressant + smoking cessation benefit outweighs risk',
            'TCAs (Tricyclic antidepressants): Anticholinergic effects impair cognition; lower seizure threshold; amitriptyline and imipramine are worst offenders; nortriptyline and desipramine are least anticholinergic but still not preferred',
            'MAOIs: Multiple drug and food interactions (hypertensive crisis with tyramine); avoid in TBI populations who may have impaired compliance and supervision',
          ],
        ),
        PearlBlock(
          'Board Pearl: Depression vs Apathy',
          'Always distinguish depression from apathy/abulia in TBI. Both present with decreased motivation, social withdrawal, and reduced activity. Depression = sad mood, hopelessness, guilt, suicidality. Apathy = indifference, emotional flatness, lack of concern WITHOUT sadness. Apathy responds better to DOPAMINERGIC agents (methylphenidate, amantadine, bromocriptine) than to SSRIs. SSRIs may actually WORSEN apathy by further dampening emotional reactivity.',
        ),
        HeaderBlock('Anticonvulsant Drug Interactions'),
        TextBlock(
          'For TBI patients who require ongoing anticonvulsant therapy for posttraumatic epilepsy, understanding drug interactions is critical for medication management across the rehabilitation continuum.',
        ),
        TableBlock(
          title: 'Anticonvulsant Drug Interaction Profiles',
          columns: ['Drug', 'CYP450 Effect', 'Key Interactions', 'Impact on TBI Recovery'],
          headerColor: const Color(0xFF1B2A4A),
          rows: [
            [
              'Phenytoin',
              'Strong CYP450 INDUCER (2C9, 2C19, 3A4)',
              'Reduces levels of: warfarin, oral contraceptives, corticosteroids, methadone, many antibiotics; protein-bound (albumin displacement)',
              'Impairs cognition; chronic use impedes recovery; narrow therapeutic index requires monitoring',
            ],
            [
              'Carbamazepine',
              'Strong CYP450 INDUCER (3A4)',
              'Auto-induction (induces own metabolism); reduces efficacy of oral contraceptives, warfarin; risk of hyponatremia (SIADH)',
              'Moderate cognitive effects; hyponatremia risk is important in TBI (already at risk for sodium disorders)',
            ],
            [
              'Valproic acid',
              'CYP450 INHIBITOR (2C9)',
              'Increases levels of lamotrigine (critical -- may cause SJS); displaces phenytoin from albumin; inhibits epoxide hydrolase; hepatotoxic',
              'Moderate cognitive effects; useful as mood stabilizer; monitor LFTs; causes weight gain and tremor',
            ],
            [
              'Levetiracetam',
              'NO significant CYP450 interactions',
              'Minimal drug interactions (renally excreted); does not affect other drug levels',
              'LEAST cognitive impairment; preferred in TBI for this reason; may cause behavioral irritability',
            ],
            [
              'Lamotrigine',
              'Mild CYP450 inducer (glucuronidation)',
              'Level DOUBLED by valproic acid (requires dose reduction); risk of Stevens-Johnson syndrome with rapid titration',
              'Minimal cognitive effects; mood stabilizing properties; must titrate very slowly (SJS risk)',
            ],
          ],
        ),
        PearlBlock(
          'Board Pearl: Why Levetiracetam Is Preferred in TBI',
          'Levetiracetam (Keppra) is increasingly preferred over phenytoin in TBI for several reasons: (1) No significant CYP450 drug interactions (renally excreted), (2) No need for therapeutic drug level monitoring, (3) Less cognitive impairment, (4) Does not impede neurological recovery. The main side effect to know is behavioral irritability/aggression -- which can be problematic in TBI patients already prone to agitation. Despite these advantages, the BTF states there is "insufficient evidence to recommend levetiracetam over phenytoin" due to the need for more head-to-head RCT data.',
        ),
        HeaderBlock('The Cardinal Principle'),
        PearlBlock(
          'Board Pearl: "Start Low, Go Slow"',
          'This is the overarching principle of ALL pharmacotherapy in TBI. The injured brain has: (1) Altered blood-brain barrier permeability (drugs reach higher CNS concentrations), (2) Disrupted neurotransmitter systems (heightened sensitivity to receptor modulation), (3) Impaired drug metabolism (hepatic and renal function may be compromised), (4) Increased susceptibility to sedation and cognitive side effects. Always start at the lowest dose, titrate slowly, use the fewest medications possible, and reassess regularly for continued need.',
        ),
        HeaderBlock('Progesterone Phase III Trial Failures'),
        TextBlock(
          'Progesterone showed promising neuroprotective effects in Phase II trials for acute severe TBI (anti-inflammatory, anti-excitotoxic, anti-apoptotic, anti-edema). However, both Phase III trials definitively failed.',
        ),
        BulletCardBlock(
          title: 'Progesterone Trials: Important Negative Results',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'PROTECT III (Wright et al., NEJM 2014): Phase III RCT -- NO benefit for acute severe TBI despite promising Phase II data',
            'SyNAPSe (Skolnick et al., NEJM 2014): Phase III RCT of 1,195 patients -- NO benefit; however, NO adverse effects reported (confirmed safety)',
            'Possible explanations for failure: heterogeneity of TBI, timing of administration, multifactorial nature of secondary injury',
            'Key board lesson: Promising Phase II results do NOT guarantee Phase III success; this is a classic example of translational failure in TBI neuroprotection research',
          ],
        ),
        HeaderBlock('CNS Polypharmacy in TBI'),
        PearlBlock(
          'Board Pearl: Polypharmacy as Strongest Predictor',
          'CNS polypharmacy had the STRONGEST association with neurobehavioral symptom distress in TBI, even after controlling for injury severity and demographics. 45-85% of TBI patients are prescribed psychotropic and pain medications. Sedating medications are the most problematic contributors. Key principles: minimize CNS-active agents, regularly reassess need for each medication, watch for cumulative anticholinergic burden from multiple medications (common hidden anticholinergics: diphenhydramine, oxybutynin, TCAs, promethazine).',
        ),
        HeaderBlock('Key AED Drug Interactions'),
        BulletCardBlock(
          title: 'High-Yield Anticonvulsant Interactions',
          themeColor: const Color(0xFFD97706),
          backgroundColor: const Color(0xFFFFFBEB),
          points: [
            'Carbamazepine AUTO-INDUCES its own metabolism: requires dose increases over 2-4 weeks as clearance rises; monitor levels closely after initiation',
            'Valproic acid DOUBLES lamotrigine levels by inhibiting glucuronidation: requires halving lamotrigine dose when co-prescribed; increases Stevens-Johnson syndrome risk',
            'Ondansetron is the PREFERRED antiemetic over metoclopramide in TBI (metoclopramide is a dopamine antagonist that may impair recovery, similar to haloperidol)',
          ],
        ),
      ],
    ),
  ],
);
