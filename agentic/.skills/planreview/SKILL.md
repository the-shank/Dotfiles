---
name: planreview
description: >-
  Critically review the most recently created plan in the session (whether for
  code, presentations, documents, or general tasks) and update it in place with
  any improvements or corrections. Use when the user invokes /planreview or asks
  for another round of review on a plan.
argument-hint: [optional focus area or concern to check]
disable-model-invocation: true
---

# Review and Refine the Latest Plan

Perform a critical second-pass review of the plan you just created before the user reviews or executes it, and update the plan if you find flaws, unverified assumptions, weak structure, or simpler alternatives.

Focus: $ARGUMENTS
(If the focus is empty, review the entire latest plan.)

## Rules

1. **Review only the latest plan**: In a long session that may contain multiple plans from earlier tasks, inspect your recent turns and tool calls to determine where the most recent plan was written: directly in chat, in an artifact, or in a markdown file you created or updated. Review only that latest plan and ignore older plans from earlier in the session.
2. **Stay in planning mode**: Do not execute the plan yet (do not modify project source files, target documents, presentations, or external state). Only update the plan itself.
3. **Do not rubber-stamp your own work**: Re-reading the plan prose alone repeats the same blind spots. Check the plan's claims against the relevant source material (such as the codebase, reference documents, existing slides, data, or user constraints).

## Steps

1. Locate the most recent plan from the latest planning turn:
   - If you created or updated a plan artifact or a markdown plan file in that turn, read that file or artifact so you review its exact current contents.
   - If the latest plan was written directly in your chat response, review that chat plan.
2. Audit that plan across the dimensions that apply to the task (paying special attention to `$ARGUMENTS` if provided):
   - **Goal alignment and completeness**: Check whether every user requirement and constraint is addressed, and whether any necessary step or prerequisite was skipped.
   - **Unverified assumptions**: Identify any claims, file paths, APIs, data points, or reference details that the plan assumed without checking. Verify those details against the actual files or source material now.
   - **Simplicity and structure**:
     - For coding or system tasks: cut speculative abstractions and unnecessary moving parts, check affected callers and tests, and ensure multi-step changes are broken into small, atomic commits.
     - For presentations, papers, or documents: check narrative flow, logical progression, audience framing, and pacing, and cut redundant or unfocused sections/slides.
     - For general workflows: check step ordering, dependencies, and whether a more direct path exists.
3. Briefly state what held up and what needed to change (and why). If the plan is already tight and needs no changes, state what you verified and leave it as is.
4. If improvements or corrections are needed, update the plan in the same place where it lives:
   - If the latest plan is in a markdown file or artifact, edit that file or artifact in place.
   - If the latest plan is in chat, output the complete revised plan in chat rather than a partial diff.
   Wait for user approval before executing the plan.
