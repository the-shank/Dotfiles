---
name: claude-resume-session
description: Resume/continue work from a Claude Code session that ran under a DIFFERENT config dir (~/.claude1..4). Given a session id and the old session's config dir, locate its raw .jsonl transcript, distill it to readable markdown, and reconstruct enough context to keep working here. Use when the user says something like "resume session <id> from c2", "continue the session I had in ~/.claude3", or otherwise wants to pick up work started in another Claude Code instance/config dir. `claude --resume` only sees the current config dir, so this fills that gap.
---

# Resume a session from another config dir

`claude --resume` only lists sessions under the *current* `CLAUDE_CONFIG_DIR`. This
skill reads a transcript belonging to a different config dir and rebuilds working
context from it.

## Config-dir shorthand

The user's config dirs are numbered. Everywhere below, a shorthand `cN` means
`~/.claudeN`:

| shorthand | config dir |
|---|---|
| `c1` | `~/.claude1` |
| `c2` | `~/.claude2` |
| `c3` | `~/.claude3` |
| `c4` | `~/.claude4` |

`distill.py` accepts either the shorthand (`--config-dir c2`) or a real path
(`--config-dir ~/.claude2`).

## Inputs

You need two things from the user (ask if either is missing):

1. **session id** — the old session's id (a full uuid, or a unique prefix).
2. **config dir** — where that session lived: a shorthand `c1`..`c4`, or a path.

The config dir is a **hint, not a hard requirement**. If the session isn't found
under the given dir, `distill.py` automatically searches every other `~/.claude*`
config dir and uses the first match, printing a `note:` line saying where it
actually found it. So a wrong-but-plausible config dir (e.g. the user says `c3`
but the session lived in `c4`) still resolves — just double-check the `note:` line
and the reported `transcript` path so you know which config dir you're really
reading.

## Step 1 — distill the transcript

The raw `.jsonl` transcript is large (several MB) and mostly non-conversational
(attachments, file-history snapshots, mode/permission events). Do **not** read it
directly. Run the distiller, which drops the bulk and keeps prompts, assistant
text, and a summary of every tool call:

```bash
python3 "$(dirname "$0")/distill.py" --config-dir <cN|path> --session-id <id>
```

(Invoke it by its real path — this skill dir. `distill.py` uses the standard
library only.) It prints a summary and writes distilled markdown to a temp file:

```
transcript : /home/shank/.claude2/projects/<munged-cwd>/<id>.jsonl
title      : ...
cwd(s)     : ...
branch(es) : ...
turns      : N user / M assistant
distilled  : /tmp/session-distill-XXXX.md (NNNN bytes)
```

Pass `--thinking` to include the old assistant's reasoning blocks if you need them.

## Step 2 — read the distilled markdown

`Read` the `distilled: ...` file. It contains, in order: the session title, the
old **cwd** and **git branch**, and every turn tagged with `uuid=…`.

## Step 3 — reconcile the environment

Before acting on anything, compare the old session's **cwd** and **git branch**
(from the distilled header) against where you are now (`pwd`, `git branch --show-current`).
If they differ, say so and confirm with the user whether to switch worktree/branch
or map the old work onto the current tree. Old absolute paths may not be valid here.

## Step 4 — drill into the raw transcript when needed

The distillation intentionally drops tool-result bodies, full file contents, and
exact tool arguments. When you need one of those, use the `uuid=` anchor from the
distilled markdown to fetch the exact original entry from the raw `.jsonl`:

```bash
jq -c 'select(.uuid=="<uuid>")' <raw-transcript-path>
```

To pull, say, the full output a command produced, fetch the assistant `tool_use`
entry by its uuid, then find the following `user` turn whose `tool_result` block
carries the matching `tool_use_id`. This keeps the multi-MB file out of context —
you retrieve only the specific pieces the distillation elided.

## Step 5 — continue the work

Summarize back to the user what the old session was doing (goal, current state,
last actions, any open thread from the final turns), then continue from there in
the current instance.
