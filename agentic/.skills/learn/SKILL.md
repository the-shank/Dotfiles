---
name: learn
description: Distill this session into proposed rules and skills, review them, then save
argument-hint: [optional focus, e.g. "save the retry pattern as a rule"]
disable-model-invocation: true
---

Review this session and propose things worth remembering in future sessions. Do not write anything until I approve.

Focus: $ARGUMENTS
(If the focus is empty, review the whole session.)

## Steps

1. Call EnterPlanMode first. If I decline plan mode, show the proposals in chat, end your turn, and write nothing until I reply.

2. Look through the session for:
   - corrections I gave you
   - feedback on how I want you to work
   - debugging problems and how they were solved
   - project facts that are not obvious from the code

   Skip anything that is already in the code, git history, or existing rule files, and anything that only matters to this session.

3. Read the current rule files before proposing, so you update instead of duplicating:
   - project rules: `CLAUDE.md` in the project root
   - personal rules for all projects: `~/.claude/CLAUDE.md`
   - project skills: `.claude/skills/*/SKILL.md`

4. Decide where each item goes:
   - **Project rule** (`CLAUDE.md`): a convention or fact for this project.
   - **Personal rule** (`~/.claude/CLAUDE.md`): a preference of mine that applies to every project.
   - **Skill** (`.claude/skills/<name>/SKILL.md`): a multi-step procedure worth reusing. Give it frontmatter with `name` and `description`.

5. Write the plan as a numbered list. For each item, show:
   - target file
   - new, update, or delete
   - the exact text to add or change
   - one line on why, pointing to what happened in the session

   Keep each rule short and direct. If there is nothing worth saving, say so and stop.

6. Call ExitPlanMode. If I comment, revise the plan and ask again.

7. After I approve, write only the approved items, exactly as approved. Then list the files you changed.
