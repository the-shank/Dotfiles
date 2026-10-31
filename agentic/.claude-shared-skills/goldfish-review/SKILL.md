---
name: goldfish-review
description: >-
  Conduct an isolated, adversarial review of a plan using a fresh zero-context
  sub-agent. Audits the plan against the codebase for missing invariants,
  ungrounded assumptions, and execution risks before implementation begins.
argument-hint: [optional plan file path or focus area]
disable-model-invocation: true
---

# Goldfish Plan Review

Perform an isolated, adversarial review of a plan using a fresh, zero-context sub-agent. The goal is to catch ungrounded assumptions, missing codebase invariants, broken conventions, and edge cases before executing the plan.

Focus / Path: $ARGUMENTS

## Core Rules

1. **Strict Context Isolation**: The reviewer must run in an isolated sub-agent session with zero memory of the conversational history that produced the plan.
2. **Context Firewall**: When launching the sub-agent, provide only the plan file path, the codebase path, and any specific focus area from `$ARGUMENTS`. Do not summarize previous discussions, explain architectural trade-offs, or defend choices made in the current conversation.
3. **No Guessing**: The reviewer must not invent definitions for ambiguous terms or assume unstated invariants. Anything not formally defined in the plan or verifiable in the repository code must be flagged as an ungrounded assumption.
4. **Read-Only Audit**: The sub-agent must never modify code or edit the plan file. It performs a read-only inspection of the repository and returns its findings to the parent agent.
5. **Separate Critique from Resolution**: The sub-agent outputs its critique. The parent agent presents the findings to the user and updates the plan once agreed upon.

## Execution Steps

### Step 1: Resolve or Extract the Target Plan
Identify the plan file to audit:
- **Explicit path provided**: If `$ARGUMENTS` specifies an existing file or a path ending in `.md`, use that file. Any remaining text in `$ARGUMENTS` serves as the focus area.
- **Existing plan file or artifact**: If no path is given, check the most recent turns. If a plan file was created, modified, or written to an artifact in this session, use that file.
- **Auto-extraction from chat**: If the latest plan exists only in previous chat turns, extract the complete, unabridged plan and write it to `tmp/plans/<slug>.md`. Inform the user of the created path before proceeding.

### Step 2: Prepare the Reviewer Prompt
Construct the sub-agent prompt containing:
1. The absolute path to the target plan markdown file.
2. The absolute path to the repository root.
3. The specific focus area from `$ARGUMENTS`, if provided.
4. Review instructions that command an adversarial audit:
   - Read the plan file completely.
   - Use search and read tools to verify every referenced function, class, type, API endpoint, database schema, and configuration against the actual codebase.
   - Audit execution steps for adherence to Small CL principles: verify that changes are broken into small, atomic, linear commits accompanied by isolated tests.
   - Forbid generous interpretation: flag any missing definition, undocumented acronym, or unverified invariant.
   - Prohibit speculative nitpicking: do not demand unnecessary enterprise abstractions, framework bloat, or telemetry on simple tasks. Focus strictly on correctness, missing edge cases, and runtime invariants.

### Step 3: Launch the Isolated Sub-Agent
Launch a fresh, read-only sub-agent using the tool provided by the active environment:
- In Antigravity: Call `invoke_subagent` using `TypeName: "research"`, `Role: "Plan Reviewer"`, and the prepared prompt.
- In Claude Code: Call the `Task` tool with a fresh read-only sub-agent prompt.

Wait for the sub-agent to complete its audit and deliver its structured critique.

### Step 4: Review and Resolve Findings
When the sub-agent returns its review, categorize the findings for the user:
- **Blocking Defects**: Codebase invariant violations, non-existent APIs or types, unhandled failure modes, missing test coverage, or steps that break existing callers.
- **Advisory Notes**: Minor performance trade-offs, documentation gaps, or naming suggestions.

Discuss any valid objections with the user. Once aligned on resolutions, update the plan file in place to eliminate the identified gaps before any implementation begins.
