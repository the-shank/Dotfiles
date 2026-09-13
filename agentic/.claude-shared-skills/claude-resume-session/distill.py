#!/usr/bin/env python3
"""Distill a Claude Code session transcript into readable markdown.

Given a config dir and a session id, locate the raw .jsonl transcript and emit a
compact markdown rendering: user prompts, assistant text, and a summary of each
tool call, with the bulky parts (tool-result bodies, file snapshots, attachments)
dropped. Every emitted turn is anchored with the raw entry's `uuid` so the reader
can fetch the full original entry from the .jsonl on demand:

    jq -c 'select(.uuid=="<uuid>")' <transcript.jsonl>

Standard library only; works with any python3.
"""

import argparse
import glob
import json
import os
import re
import sys


def resolve_config_dir(spec):
    """Accept a shorthand like 'c2' (-> ~/.claude2) or a real path."""
    m = re.fullmatch(r"c(\d+)", spec.strip())
    if m:
        return os.path.expanduser(f"~/.claude{m.group(1)}")
    return os.path.expanduser(spec)


def find_transcript(config_dir, session_id):
    """Return the list of matching paths. Try exact id, then prefix, across all projects."""
    base = os.path.join(config_dir, "projects")
    exact = glob.glob(os.path.join(base, "*", session_id + ".jsonl"))
    if exact:
        return exact
    return glob.glob(os.path.join(base, "*", session_id + "*.jsonl"))


def all_config_dirs():
    """Discover every ~/.claudeN config dir that has a projects/ subdir."""
    home = os.path.expanduser("~")
    dirs = []
    for base in sorted(glob.glob(os.path.join(home, ".claude*"))):
        if os.path.isdir(os.path.join(base, "projects")):
            dirs.append(base)
    return dirs


def find_transcript_anywhere(session_id, skip=None):
    """Search every config dir for the session, returning (config_dir, matches) for
    the first that has any. `skip` is a config dir already tried, excluded here."""
    skip = os.path.normpath(skip) if skip else None
    for cdir in all_config_dirs():
        if skip and os.path.normpath(cdir) == skip:
            continue
        matches = find_transcript(cdir, session_id)
        if matches:
            return cdir, matches
    return None, []


def as_blocks(content):
    """Normalize a message .content field to a list of block dicts."""
    if content is None:
        return []
    if isinstance(content, str):
        return [{"type": "text", "text": content}]
    if isinstance(content, list):
        return content
    return [{"type": "text", "text": str(content)}]


def trunc(s, n):
    s = s.replace("\r", "")
    if len(s) <= n:
        return s
    return s[:n] + f" …[+{len(s) - n} chars]"


def render_tool_input(inp, max_field):
    if not isinstance(inp, dict):
        return trunc(str(inp), max_field)
    parts = []
    for k, v in inp.items():
        if isinstance(v, str):
            vs = v
        else:
            vs = json.dumps(v, ensure_ascii=False)
        vs = " ".join(vs.split())  # collapse whitespace/newlines for the summary
        parts.append(f"{k}={trunc(vs, max_field)!r}")
    return ", ".join(parts)


def content_len(content):
    try:
        if isinstance(content, str):
            return len(content)
        return len(json.dumps(content, ensure_ascii=False))
    except Exception:
        return 0


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--config-dir", required=True,
                    help="the old session's config dir: a shorthand like c2 "
                         "(-> ~/.claude2) or a real path")
    ap.add_argument("--session-id", required=True,
                    help="session id, or a unique prefix of it")
    ap.add_argument("--out", default=None,
                    help="output markdown path (default: a temp file, path printed)")
    ap.add_argument("--thinking", action="store_true",
                    help="include assistant thinking blocks (off by default)")
    ap.add_argument("--max-field", type=int, default=300,
                    help="truncate each tool-input field to this many chars")
    ap.add_argument("--max-user", type=int, default=8000,
                    help="truncate a single user message to this many chars")
    ap.add_argument("--max-text", type=int, default=6000,
                    help="truncate a single assistant text block to this many chars")
    args = ap.parse_args()

    given_config_dir = resolve_config_dir(args.config_dir)
    config_dir = given_config_dir
    matches = find_transcript(config_dir, args.session_id)
    if not matches:
        # The given config dir is a hint, not a hard requirement: the session id
        # may have been paired with the wrong dir. Fall back to searching every
        # ~/.claudeN dir before giving up.
        found_dir, found = find_transcript_anywhere(args.session_id, skip=given_config_dir)
        if found:
            sys.stderr.write(
                f"note: session '{args.session_id}' not found under {given_config_dir}; "
                f"found it under {found_dir} instead\n")
            config_dir, matches = found_dir, found
        else:
            base = os.path.join(given_config_dir, "projects")
            sys.exit(f"error: no transcript for session '{args.session_id}' under "
                     f"{base} (nor any other ~/.claude* config dir)")
    if len(matches) > 1:
        sys.stderr.write("warning: multiple transcripts matched; using the first:\n")
        for m in matches:
            sys.stderr.write("  " + m + "\n")
    transcript = matches[0]

    # Metadata accumulated across the file.
    title = None
    last_prompt = None
    cwds, branches, versions = set(), set(), set()
    n_user = n_assistant = n_bad = 0

    out_lines = []
    ap_note = ("> Each turn below is anchored with `uuid=…`. To retrieve the full "
               "original entry (tool-result bodies, full file contents, exact args) "
               "run:\n>\n> ```\n> jq -c 'select(.uuid==\"<uuid>\")' "
               + transcript + "\n> ```\n")

    with open(transcript, "r", errors="replace") as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            try:
                e = json.loads(line)
            except Exception:
                n_bad += 1
                continue

            t = e.get("type")
            if t == "ai-title":
                title = e.get("aiTitle") or title
                continue
            if t == "last-prompt":
                last_prompt = e.get("lastPrompt") or last_prompt
                continue
            if e.get("cwd"):
                cwds.add(e["cwd"])
            if e.get("gitBranch"):
                branches.add(e["gitBranch"])
            if e.get("version"):
                versions.add(e["version"])

            if t not in ("user", "assistant", "system"):
                continue  # attachment, file-history-*, mode, permission-mode, etc.

            uuid = e.get("uuid", "?")
            ts = e.get("timestamp", "")
            side = " · SIDECHAIN(subagent)" if e.get("isSidechain") else ""

            if t == "system":
                if e.get("isMeta"):
                    continue
                txt = e.get("content", "")
                if not isinstance(txt, str):
                    txt = json.dumps(txt, ensure_ascii=False)
                txt = txt.strip()
                if not txt:
                    continue
                out_lines.append(f"#### system · {ts} · uuid={uuid}{side}")
                out_lines.append(trunc(txt, 1500))
                out_lines.append("")
                continue

            msg = e.get("message", {}) or {}
            blocks = as_blocks(msg.get("content"))

            if t == "user":
                texts, notes = [], []
                for b in blocks:
                    bt = b.get("type") if isinstance(b, dict) else None
                    if bt == "text" or bt is None and isinstance(b, str):
                        texts.append(b if isinstance(b, str) else b.get("text", ""))
                    elif bt == "tool_result":
                        clen = content_len(b.get("content"))
                        tid = b.get("tool_use_id", "?")
                        err = " (is_error)" if b.get("is_error") else ""
                        notes.append(f"[tool_result for {tid}{err} — {clen} chars omitted]")
                    elif bt == "image":
                        notes.append("[image omitted]")
                    else:
                        notes.append(f"[{bt} block omitted]")
                body = "\n".join(x for x in texts if x).strip()
                if body:
                    n_user += 1
                    out_lines.append(f"#### 🧑 user · {ts} · uuid={uuid}{side}")
                    out_lines.append(trunc(body, args.max_user))
                    out_lines.append("")
                elif notes:
                    # A turn that only fed tool results back to the model.
                    out_lines.append(f"<!-- tool-result turn · uuid={uuid} · "
                                     + "; ".join(notes) + " -->")
                continue

            if t == "assistant":
                n_assistant += 1
                effort = e.get("effort") or e.get("perTurnEffort")
                hdr = f"#### 🤖 assistant · {ts} · uuid={uuid}{side}"
                if effort:
                    hdr += f" · effort={effort}"
                out_lines.append(hdr)
                text_out, think_out, tools = [], [], []
                for b in blocks:
                    if not isinstance(b, dict):
                        continue
                    bt = b.get("type")
                    if bt == "text":
                        text_out.append(trunc(b.get("text", ""), args.max_text))
                    elif bt == "thinking" and args.thinking:
                        think_out.append(trunc(b.get("thinking", ""), args.max_text))
                    elif bt == "tool_use":
                        name = b.get("name", "?")
                        tools.append(f"- {name}({render_tool_input(b.get('input'), args.max_field)})")
                if text_out:
                    out_lines.append("\n".join(x for x in text_out if x).strip())
                if think_out:
                    out_lines.append("<details><summary>thinking</summary>\n")
                    out_lines.append("\n".join(think_out))
                    out_lines.append("</details>")
                if tools:
                    out_lines.append("_tool calls:_")
                    out_lines.extend(tools)
                out_lines.append("")
                continue

    header = [
        f"# Session transcript (distilled): {args.session_id}",
        "",
        f"- **title**: {title or '(none)'}",
        f"- **config_dir**: {args.config_dir} ({config_dir})",
        f"- **raw transcript**: `{transcript}`",
        f"- **cwd(s)**: {', '.join(sorted(cwds)) or '(unknown)'}",
        f"- **git branch(es)**: {', '.join(sorted(branches)) or '(unknown)'}",
        f"- **cli version(s)**: {', '.join(sorted(versions)) or '(unknown)'}",
        f"- **turns**: {n_user} user / {n_assistant} assistant"
        + (f" · {n_bad} unparseable lines skipped" if n_bad else ""),
    ]
    if last_prompt:
        header.append(f"- **last prompt**: {trunc(last_prompt, 500)}")
    header += ["", ap_note, "---", ""]

    out_path = args.out
    if not out_path:
        import tempfile
        fd, out_path = tempfile.mkstemp(prefix="session-distill-", suffix=".md")
        os.close(fd)
    with open(out_path, "w") as fh:
        fh.write("\n".join(header) + "\n")
        fh.write("\n".join(out_lines) + "\n")

    size = os.path.getsize(out_path)
    print(f"transcript : {transcript}")
    print(f"title      : {title or '(none)'}")
    print(f"cwd(s)     : {', '.join(sorted(cwds)) or '(unknown)'}")
    print(f"branch(es) : {', '.join(sorted(branches)) or '(unknown)'}")
    print(f"turns      : {n_user} user / {n_assistant} assistant")
    print(f"distilled  : {out_path} ({size} bytes)")


if __name__ == "__main__":
    main()
