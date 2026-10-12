---
name: hypothesis
description: >-
  Stress-test the user's debugging hypothesis or systems mental model against
  the codebase without proposing or implementing a fix. Use when the user
  invokes /hypothesis or explicitly asks to verify a hypothesis before fixing.
argument-hint: [symptom and your hypothesis of what is causing it]
disable-model-invocation: true
---

# Hypothesis-First Debugging & Mental Model Check

Evaluate my mental model of how the system behaves before proposing any fix or writing any code.

Input: $ARGUMENTS

## Rules

1. **Require a hypothesis first**: If my input only describes a symptom, error message, or stack trace without stating my own hypothesis of why it happens, stop immediately. Ask me what I think is causing the behavior before you investigate or explain anything.
2. **No fixes or patches**: Do not edit files, do not write replacement code, and do not propose a fix in your response. Stay strictly focused on how the system currently works.
3. **Ground every claim in evidence**: Check the actual codebase (and read-only git history if relevant) rather than reasoning from general knowledge. Cite exact files, functions, and line ranges.

## Steps

1. Restate my hypothesis in one concise sentence so we know we are testing the same claim.
2. Trace the relevant execution path in the codebase and compare it against my mental model:
   - State clearly which parts of my hypothesis hold up and which parts break down, citing the exact code locations.
   - Where my hypothesis breaks down, show the specific invariant, state transition, or control-flow branch that contradicts it. If the root cause is further down the path, stop at the point where my model diverges from the code and ask how I want to revise my hypothesis rather than giving away the whole answer at once.
   - If the hypothesis cannot be confirmed or ruled out from static code alone, propose the smallest falsifiable check (such as a specific debugger breakpoint, log assertion, or minimal test input) that will prove it one way or the other.
3. End your turn by asking either how I want to revise my hypothesis (if it was refuted) or what invariant I think we should change to fix the issue (if the mechanism is now clear).
