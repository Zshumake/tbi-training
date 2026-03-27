# Reference Text Generation Prompt
## For: SCI, Pediatric Rehab, P&O, EDX/EMG-NCS, CVA/Stroke Training Modules

Paste this entire prompt into Claude when starting a new project. Replace `[TOPIC]` with your subject area.

---

## PROMPT START

You are helping me build a comprehensive, original medical reference text for **[TOPIC]** — the same way we built the TBI Training reference library. I am a PM&R physician building Flutter-based training apps for medical residents. I need my own reference text that I own outright, not derivative of any single textbook.

### What We're Building
A multi-chapter PDF reference library (each chapter 30-50 pages / 8,000-15,000 words) covering everything a PM&R resident needs for their **[TOPIC]** rotation AND board exam. This reference text will serve as the source data for a Flutter training app, NotebookLM notebooks, flashcards, quiz questions, and podcasts.

### How the TBI Project Was Built (Follow This Exact Process)

**Phase 1 — Source Material Absorption**
- I dropped textbook chapter PDFs into the project folder (Cuccurullo, DeLisa, Braddom, etc.)
- Claude read all PDFs and extracted key clinical facts, tables, scales, and board pearls
- This gave us a "skeleton framework" of what the textbook authors considered essential

**Phase 2 — Deep Research (/deepen-plan)**
- Launched parallel research agents to find the LATEST evidence beyond the textbooks
- Sources used: BTF guidelines, AAN practice parameters, Cochrane reviews, landmark clinical trials, CDC/NIH data, AAPM&R board content outlines, and web searches for current guidelines
- **NEW RESOURCE: Physiatry Discord** — I am a member of a physiatry Discord server. Search for and use resources shared there including study guides, board review materials, clinical protocols, and crowd-sourced high-yield content. Ask me to share relevant channels/threads if you need specific topics.
- Each research agent handled 2-3 chapters and searched extensively before writing

**Phase 3 — Chapter Writing (Parallel Agents)**
- Launched 5 parallel agents, each writing 2-3 chapters simultaneously
- Each agent:
  1. Read existing app content (Dart module files from Phase 1)
  2. Read compiled research files from Phase 2
  3. Searched the web for additional sources (guidelines, trials, reviews)
  4. Wrote comprehensive original chapters in markdown
  5. Included full academic citations (Author et al. Title. Journal. Year;Vol:Pages.)

**Phase 4 — Hallucination Check (Critical)**
- Launched 3 parallel verification agents covering all chapters
- Each verifier read every chapter and checked EVERY specific factual claim:
  - Cross-referenced against source textbook PDFs
  - Web-searched specific trial results, drug dosing, scoring systems
  - Flagged anything unverifiable with `⚠️ UNVERIFIED:`
  - Corrected errors in-place
  - Added verification HTML comment at end of each chapter
- TBI result: 992 claims checked, 9 corrections, 0 unverifiable (99.1% accuracy)

**Phase 5 — PDF Generation**
- Installed pandoc + typst via homebrew
- Stripped `[BOARD]`/`[COMPREHENSIVE]` tags for clean PDF rendering
- Batch converted all chapters: `pandoc input.md --to=typst --pdf-engine=typst -o output.pdf`
- Final output: 14 PDFs totaling 120,000 words / 5MB

### Critical Formatting Rules

**Dual-Tagging System** — Every section MUST be tagged:
- `[BOARD]` = High-yield for ABPM&R boards (scales, classifications, drug choices, management algorithms, diagnostic criteria)
- `[COMPREHENSIVE]` = Detailed clinical knowledge (pathophysiology deep dives, evidence reviews, emerging research)

This tagging makes it trivial to later extract board-only content for flashcards/quizzes.

**Chapter Template:**
```markdown
# Chapter N: [Title]

## Learning Objectives
- [BOARD] ...
- [COMPREHENSIVE] ...

## Section 1: [Topic]
### [BOARD] Key Concepts
(High-yield facts, tables, board pearls)

### [COMPREHENSIVE] Detailed Discussion
(Full clinical discussion, pathophysiology, evidence review)

> **Clinical Pearl:** [Board-relevant pearl in blockquote]

| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| data     | data     | data     |

## References
1. Author et al. Title. Journal. Year;Vol:Pages.
```

### Source Priority (in order)
1. **Source textbook PDFs** I drop into the folder (Cuccurullo, DeLisa, Braddom, Cifu)
2. **UpToDate** — I have a subscription; use Chrome automation to scrape articles (extract facts/data, NOT verbatim prose)
3. **Clinical Practice Guidelines** — AAN, AAPM&R, ACRM, specialty society guidelines
4. **Landmark Clinical Trials** — RCTs cited in guidelines (know the study name, year, N, key finding)
5. **Physiatry Discord** — Ask me to search for crowd-sourced resources, study guides, and clinical protocols from the PM&R community
6. **Cochrane/Systematic Reviews** — For treatment evidence levels
7. **CDC/NIH/WHO** — For epidemiology and public health data
8. **PubMed Web Searches** — For recent evidence updates

### AAPM&R Board Content — What Gets [BOARD] Tagged
For any PM&R subspecialty topic, the following categories are ALWAYS board-relevant:
- Epidemiology (incidence, prevalence, demographics)
- Classification/severity scales with scoring
- Diagnostic criteria and assessment tools
- Prognosis indicators and outcome measures
- Acute management algorithms
- Medication management (drugs to use, drugs to avoid, with mechanisms)
- Rehabilitation-specific interventions
- Complications and their management
- Functional outcome measures (FIM, specific scales)
- Anatomy relevant to the condition
- Contraindications and precautions

### Output Structure
Save everything to a `reference-text/` folder in the project root:
```
reference-text/
├── 01-[First-Topic].md    → .pdf
├── 02-[Second-Topic].md   → .pdf
├── ...
├── NN-[Last-Topic].md     → .pdf
└── 00-References-Master.md
```

### What to Do Right Now
1. **Read any source PDFs** I've dropped into this project folder
2. **Propose a chapter outline** — How many chapters? What topics? (Model it after how a comprehensive textbook would organize this subject)
3. **Ask me** what textbook chapters I have available to drop in
4. **Ask me** to search the Physiatry Discord for relevant resources
5. Once I approve the outline, begin the 5-phase process above

### Topic-Specific Starter Prompts

**If [TOPIC] = Spinal Cord Injury:**
Chapters should cover: Anatomy & Classification (ASIA/ISNCSCI), Acute Management, Autonomic Dysreflexia, Neurogenic Bladder/Bowel, Respiratory Management, Cardiovascular Complications, Spasticity, Pain, Skin/Pressure Injuries, Sexual Function, Pediatric SCI, Aging with SCI, Community Reintegration

**If [TOPIC] = Pediatric Rehabilitation:**
Chapters should cover: Normal Development, Cerebral Palsy, Spina Bifida, Muscular Dystrophies, Brachial Plexus Injuries, Pediatric TBI, Pediatric SCI, Limb Deficiencies, Developmental Disabilities, Transition to Adult Care

**If [TOPIC] = Prosthetics & Orthotics:**
Chapters should cover: Amputation Levels & Epidemiology, Surgical Principles, Prosthetic Components (Transtibial, Transfemoral, Upper Limb), Gait Analysis, Socket Design, Orthotic Principles, AFOs/KAFOs, Spinal Orthoses, Upper Limb Orthoses, Myoelectric Prosthetics, Outcomes

**If [TOPIC] = Electrodiagnostics (EDX/EMG-NCS):**
Chapters should cover: Neurophysiology Fundamentals, NCS Techniques, Late Responses, Needle EMG, Radiculopathy, Plexopathy, Entrapment Neuropathies, Polyneuropathy, Motor Neuron Disease, Myopathy, NMJ Disorders, Pediatric EDX, Report Writing

**If [TOPIC] = Stroke/CVA:**
Chapters should cover: Epidemiology & Risk Factors, Vascular Anatomy, Stroke Syndromes, Acute Management (tPA, thrombectomy), Neuroimaging, Motor Recovery & Neuroplasticity, Spasticity, Dysphagia, Aphasia/Communication, Cognitive Deficits, Depression/Mood, Shoulder Pain, Falls/Balance, Community Reintegration, Secondary Prevention

## PROMPT END

---

## Notes for Zach
- Drop your textbook PDFs into the project folder BEFORE starting
- The Physiatry Discord is a goldmine — search channels for "board review", "high yield", study guides
- Each project will produce ~100,000-150,000 words across all chapters
- The `[BOARD]`/`[COMPREHENSIVE]` tagging is what makes this reusable — you can grep for `[BOARD]` to extract board-only content
- The hallucination check phase is non-negotiable — it caught 9 errors in TBI that would have been in your PDFs
- Total time per project: ~3-4 hours with parallel agents
- You'll end up with a personal medical reference library across all PM&R subspecialties
