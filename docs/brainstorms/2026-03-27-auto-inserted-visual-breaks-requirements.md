---
date: 2026-03-27
topic: auto-inserted-visual-breaks
---

# Auto-Inserted Contextual Visual Breaks

## Problem Frame
Module content is currently rendered as sequential text blocks (headers, bullets, tables, pearls) with no visual imagery inline. A resident scrolling through the Pathophysiology module reads about coup-contrecoup injuries but never sees the actual anatomy diagram that's already in the asset library. The 39 infographics and 10 real anatomy images we have are siloed in a separate "Infographics" gallery — they don't appear where they'd teach the most.

## Requirements
- R1. Content blocks should be interspersed with contextual images when the topic matches an available infographic or anatomy diagram
- R2. Images should appear inline within the scrollable content, not as pop-ups or separate screens
- R3. Images should be tappable to open the full interactive viewer (zoom/pan, or layer viewer for anatomy)
- R4. Image insertion should be automatic based on keyword/topic matching — no manual placement per module
- R5. Images should have a caption bar showing the title and a "Tap to explore" hint
- R6. Visual breaks should appear at natural content boundaries (between major sections, not mid-paragraph)
- R7. The system should work with the existing infographic and anatomy asset library without requiring new assets

## Success Criteria
- Every module with relevant infographics shows at least 1-2 inline images when scrolling through content
- Images appear contextually (hemorrhage diagram appears near hemorrhage content, not randomly)
- Residents can tap an inline image to enter the full viewer without leaving the module

## Scope Boundaries
- NOT adding new image assets — using existing 39 infographics + 10 anatomy PNGs
- NOT adding inline quizzes or gamification (separate brainstorm)
- NOT redesigning the content block system — adding a new block type that auto-inserts

## Key Decisions
- Keyword-based matching: Map each infographic to a set of trigger keywords. When a content block contains those keywords, insert the image after that block.
- New `InlineImageBlock` content block type: Rendered as a rounded card with the image, caption, and tap target.
- Deduplication: Each image appears at most once per tab to avoid repetition.

## Next Steps
→ Proceed directly to implementation — scope is clear and bounded.
