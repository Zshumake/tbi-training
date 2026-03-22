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
      ],
    ),
  ],
);
