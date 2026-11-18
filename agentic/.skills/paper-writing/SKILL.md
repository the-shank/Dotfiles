---
name: paper-writing
description: >-
  Guidelines, LaTeX formatting invariants, and writing principles for drafting academic research papers.
  Activate this skill when writing, editing, or reviewing academic papers, LaTeX documents (.tex), or paper code listings.
---

# Academic Paper Writing & LaTeX Guidelines

Apply these guidelines when drafting, editing, or reviewing research papers and LaTeX documents.

## LaTeX Invariants

### 1. Direct `\mintinline` for `#`
Whenever writing inline Rust code or attributes containing `#` (such as `#[cfg(...)]`, `#![no_std]`, or `#[cfg_attr(...)]`), never wrap them in convenience helper macros like `\rustline{...}`.
Always write `\mintinline[fontsize=\small]{rust}{...}` directly. In LaTeX, `#` functions as a parameter token inside macro arguments, causing expansion errors when passed through helper wrappers.

### 2. Anchoring Prose to Listing Code Markers
When discussing code from a listing, attach code markers (\codemarkermath{p_i} for predicates, \codemarkermath{e_i} for entities) directly in the listing and refer to those markers in the body text.
Avoid repeatedly copying long inline attribute strings into body paragraphs, which creates visual clutter and disrupts narrative flow.

## Writing Style & Explanations

### 1. Progressive Clarity Over Excessive Compression
Concise is not always simpler. Do not pack multiple logical steps or cause-and-effect transitions into dense, run-on sentences.
Take multiple simple, direct sentences to walk the reader through each conceptual step from the reader's perspective. Ensure every pronoun ("this", "these", "it") has an obvious referent.
Put what existing approaches do, why it falls short, and the concrete example or listing walkthrough in separate sentences rather than chaining claim + reason + example with colons, semicolons, or em-dashes. When shortening a section, cut low-value details (such as per-row enumerations already visible in a table) rather than compressing remaining points into denser sentences.

### 2. Accessible Language Over Academic Jargon
Avoid inflated formal academic logic jargon when plain engineering language suffices. For example:
- Use "predicates with alternative features" or "alternative enablers" instead of "disjunctive configuration predicates".
- Use "leaves the solver with only one choice" instead of "Boolean unit propagation".
- Unpack compressed or hyphenated noun-stacks into plain clauses: write "the percentage of C types replaced with safe Rust types" instead of "migrated-type ratios", and "the number of rewritten C constructs" instead of "construct-specific rewrite counts".
- Name concrete referents directly ("code counts") instead of introducing abstract meta-labels ("syntactic proxies" / "these proxies").
Keep explanations grounded, direct, and intuitive.
