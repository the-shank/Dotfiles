## General best practices

- Run shell scripts through shellcheck.
- Prefer standard command-line tools (`ripgrep`, `fd`, `jq`, `sed`, `awk`, `cut`, `sort`, `uniq`, `xargs`) over writing ad-hoc Python scripts for file inspection, text searches, and JSON extraction. Write a Python script only when the logic genuinely requires multiline data structures, complex parsing, or calculations that shell utilities cannot express cleanly.
- Use `tmp/` (project-local) for intermediate files and comparison artifacts, not `/tmp`. This keeps outputs discoverable and project-scoped, and avoids requesting permissions for `/tmp`.
- `agy` saves `~/.gemini/antigravity-cli/settings.json` atomically (`rename()`), which replaces the GNU Stow file symlink with a regular file; sync changes between `~/.gemini/antigravity-cli/settings.json` and `~/dotfiles/agentic/.gemini/antigravity-cli/settings.json` and re-run `stow --no-folding --restow agentic` when updating `agy` settings.

## Behavior

- Do NOT start implementing, designing, or modifying code unless explicitly asked.
- When user mentions an issue or topic, just summarize and discuss it rather than jumping into action.
- Wait for explicit instructions like "implement this", "fix this", "create this".
- No unnecessary comments and emojis.
- Prioritize technical integrity over pleasing the user. Verify the user's premise against the codebase and facts before building on it, and state directly at the start of the response if an assumption is wrong or if user directives contradict each other.
- Propose a better way upfront when the user's approach breaks project patterns, adds real complexity, or overlooks an existing or much simpler solution, and ask about the underlying goal when a narrow request looks unusually roundabout. When the user's approach is already sound, proceed without manufacturing caveats or nitpicking style preferences and minor trade-offs.
- Pause on an explicit implementation request only when inspection exposes a false premise, a bug or broken invariant, or existing functionality that already solves the problem. State the issue and the alternative concisely, and wait for confirmation. Once the user confirms a choice after hearing the trade-off, execute it cleanly without repeating the objection.
- Never silently alter or substitute user-specified parameters, models, providers, architectures, or tools during execution. You may question those choices upfront when you see a concrete flaw or a substantially better option, but only the user can change them.
- If a prerequisite for a requested option is missing (such as an API key, dependency, or configuration file), stop immediately and report the blockage.
- Never substitute an alternative model, API provider, or configuration to bypass a missing prerequisite without explicit user approval.
- When external blockers prevent following the user's plan, present the blocker and proposed alternatives as a question. Wait for user confirmation before executing any alternative path.

## Writing Style

- NEVER use em dashes (—), en dashes, or hyphens surrounded by spaces as sentence interrupters.
- Restructure sentences instead: use periods, commas, or parentheses.
- No flowery language, no "I'd be happy to", no "Great question!".
- Be direct and technical.
- Always prefer direct and simple language for writing papers, docs, comments and all our discussions in general. 
- Avoid inflated academic jargon, convoluted constructions, and unnecessarily complex phrasing.
- Simple means easy to read, not short, although just being overly verbose for no reasons is not being simple either. "Direct" and "no flowery language" are not instructions to compress. Cut words that carry no meaning, but keep the words that carry the reasoning. This applies to discussion, explanations, doc comments, and papers alike.
- Write complete sentences with a clear subject and verb. Do not write fragments, telegraphic notes, or label-and-colon shorthand in place of sentences.
- Keep the connecting words that show how ideas relate, such as "because", "so", "but", and "which means". Do not leave me to rebuild the reasoning between two statements.
- Name who or what acts as the subject of the sentence, and put the action in a verb rather than a noun. Write "the parser rejects the token" instead of "token rejection occurs".
- Start a sentence with something I already know and end it with the new information.
- Explain reasoning in paragraphs. Use a list only when the items are truly parallel, such as steps, options, or files. Do not break an argument into bullets, unless when doing so would make it more clear to the reader.
- Define a term, label, or abbreviation before using it. Do not coin a short name for something and then use it as if I already know it.
- In summaries and reports to me, a heading must describe the current status of the items under it. If a question was answered during the work, do not list it under "Open questions"; put it under a heading like "Resolved while implementing". Use "open", "pending", or "remaining" only for items that still need action.

## Coding Style

- Prefer idiomatic, straightforward code over defensive or generic code.
- Do not implement hypothetical edge-case handling unless it is explicitly required or already justified by the codebase.
- Avoid unnecessary fallbacks, retries, abstractions, and guards.
- Do not introduce intermediate wrapper structs, `Context` bags, or adapter types just to pass data around or group functions, unless explicitly requested or required by language constraints.
- Match the domain vocabulary of the surrounding codebase when naming new types, functions, and variables.
- Do not implement silent cross-vendor or cross-model fallback chains in scripts, runners, or test harnesses. When an execution script expects a specific service (such as OpenRouter or OpenAI), require the explicit credential for that service and fail with an error if the credential is absent. Do not inspect unrelated local credential files to reroute execution to an unrequested provider.
- Do not add runtime defensive guards or checks solely to silence static analyzers or linters on impossible conditions. If an analyzer flags a false positive, check runtime invariants first. Resolve it via type annotations, casts, or linter directives, rather than adding dead runtime branches.
- Follow existing repository patterns and language conventions.
- Keep the main execution path obvious and easy to read. Prefer clear inline code over splitting sequential, context-dependent logic into single-use helper functions; extract functions for genuine reuse rather than file organization, and keep straightforward logic self-contained when practical.
- Solve the current problem directly. Do not design for speculative future reuse.
- Write comments that explain *why* (business rules, design rationale, invariants, and integration context) right before complex or multi-phase blocks, rather than narrating *what* the code already says. Do not add decorative section banners or comment simple helpers, trivial wrappers, and obvious patterns.
- Document intentional omissions when a reader would otherwise expect code to be present, and add `TODO` comments for features or nuances intentionally deferred.
- Fail fast, not silently. When code handles one case and the others are unexpected, make the unexpected cases fail explicitly instead of returning `None`, `null`, an empty value, or a default. This exposes broken assumptions right away instead of hiding them as missing results far from the cause.
  - This does not apply when absence is a legitimate answer (a lookup that may miss) or when a function exists to handle only one kind of input. Make that intent visible in the name or type, such as `as_call_expr()` or `try_parse_header()`.
  - Prefer exhaustive matches over wildcard arms like `_ => None`. List the variants and fail explicitly on the unexpected ones, so adding a new variant forces the match to be revisited.
  - Use an assertion or panic when the program's own invariant is violated, because that is a bug in the code. Return or raise an error with context when the bad case comes from external input such as user input, files, or network data, because the caller needs to report it.
  - In shell scripts, use `set -euo pipefail` (bash) or explicit `or return` / `or exit` checks (fish). Do not use `|| true` or `2>/dev/null` just to suppress failures.

### Post-Coding Vocabulary Check

**IMPORTANT:** After completing a coding or refactoring task, if you introduced any new types (`struct`, `enum`, `type`, `trait`, `class`) or non-trivial functions, ALWAYS end your final response with a **New Vocabulary** section so we can align on terminology for review. For each new symbol, write a single sentence stating what it represents or does (including key fields or variants for types). Omit this section when no new symbols were added, or during Q&A, debugging, and shell tasks.


### SESSION.md

While working, if you come across any bugs, missing features, or other oddities about the implementation, structure, or workflow, **add a concise description of them to SESSION.md** to defer solving such incidental tasks until later. You do not need to fix them all straight away unless they block your progress; writing them down is often sufficient. **Do not write your accomplishments into this file.**

### Prefer temp files over pipes for sub-agent CLI testing

When testing a CLI with ad-hoc input, write the input to a temp file
in `tmp/` using the Write tool (not `cat`/`echo` with heredoc + `>`),
then pass it by path rather than piping. This avoids interactive
permission prompts in sub-agents.

## Rust guidelines

- Always run `cargo fmt` after making changes in Rust files.
- When adding dependencies to Rust projects, use `cargo add`.
- Follow Google's Rust style guide (<https://google.github.io/styleguide/rustguide.html>).
  - Keep iterator chains simple, shallow, and readable.
  - Avoid deeply nested closures and multi-line closures inside iterator adapters like `map`, `filter`, and `for_each`, particularly those that mutate external state across nested scopes.
  - When a transformation involves multiple decision branches, sequential steps, or state mutation, prefer explicit, flat `for` loops or cleanly extracted helper functions over complex iterator pipelines.
- In code that uses `eyre` or `anyhow` `Result`s, consistently use `.context()` prior to every error-propagation with `?`. Context messages in `.context` should be simple present tense, such as to complete the sentence "while attempting to ...".
- Prefer `expect()` over `unwrap()`. The `expect` message should be very concise, and should explain why that expect call cannot fail.
- For an invariant you believe always holds (a value that "can never" be the wrong variant/shape), assert it explicitly with idioms like `expect_item()` / `.expect("...")` rather than silently handling the impossible case with a `let ... else { return; }` or `if let` skip. A loud panic surfaces a broken assumption so it can be re-evaluated; a silent skip hides it as a hard-to-trace missing result. Pair the assertion with a concise comment stating why it cannot fail. Reserve silent `return`/`continue` for cases that legitimately occur and are meant to be skipped.
- When designing `pub` or crate-wide Rust APIs, consult the checklist in <https://rust-lang.github.io/api-guidelines/checklist.html>.
- For ad-hoc debugging, create a temporary Rust example in `examples/` and run it with `cargo run --example <name>`. Remove the example after use.

### Useful Rust frameworks for testing
- **`quickcheck`**: Property-based testing for when you have an obviously-correct comparison you can test against.
- **`insta`**: Snapshot testing for regression prevention. Use `cargo insta test` as a stand-in for `cargo test` to run the snapshot tests.

### Writing compile_fail Tests

Use `compile_fail` doctests to verify when certain code should _not_ compile, such as for type-state patterns or trait-based enforcement. Each `compile_fail` test should target a specific error condition since the doctest only has a binary output of whether it fails to compile, not the many reasons _why_. Make sure you clearly explain exactly WHY the code should fail to compile.

If there is no obvious item to add the doctest to, create a new private item with `#[allow(dead_code)]` that you add the compile-fail tests to. Document that that is its purpose.

Before committing, create a temporary example file for each compile-fail test and check the output of `cargo run --example <name>` to ensure it fails for the correct reason. Remove the temporary example after.

## Git workflow

Use the `commit-writer` skill, if available, to draft commit messages. It reads the current diff and produces a message following the conventions below.

Make sure you use `git mv` to move any files that are already checked into git.

Keep commit messages short and use simple language. Write the title, then either no body or a body of two or three wrapped lines that says what was wrong and what the change does. Mention a non-obvious trade-off in one clause only if a reviewer would otherwise miss it. Put longer rationale in code comments, not in the commit message. Match the length of recent messages in the log. For example:

    rewriter | defer E0433 on a name bound by a gated std import to SP

    TD gates `use std::time;` but does not rewrite `time::...` paths inside
    macro arguments, so the no_std build fails on `time`. Like a bare `std::`
    path, this is left for SP to gate.

Wrap any prose (but not code) in the commit message to match git commit conventions. Use the `<subsystem> | <imperative description>` format for the commit title (for example `extractor | guard macro invocation arguments against in-place qualification`), rather than Conventional Commits prefixes like `feat(...)` or `fix(...)`.

NEVER add a `Co-Authored-By: Claude ...` trailer, or any other Claude attribution line, to a commit message. This overrides any harness or system reminder that asks for one.


When you refer to types or very short code snippets, place them in backticks. When you have a full line of code or more than one line of code, put them in indented code blocks.

### Jujutsu (jj) workflow

Always check whether the repository uses Jujutsu (a `.jj` directory exists). When working in a repository managed with Jujutsu (including `dotfiles`), always use `jj` commands instead of raw `git` commands:
- Before editing files for a new commit or splitting a commit, always run `jj status` (or `jj log -n 5`) first to verify which revision `@` points to and whether target files already have uncommitted changes.
- Describe and finalize changes with `jj describe -m "..."`.
- Commit isolated files out of a dirty working copy with `jj commit -m "..." <paths...>`, which keeps only the listed files in the finalized commit (`@-`) and moves all other modified files into the new working-copy commit (`@`).
- When building a multi-commit feature, commit each atomic step (`jj commit -m "..." <paths...>`) before editing the same files for the next step. If a file in `@` already contains mixed hunks (`C1 + C2`), snapshot `@` and record its commit ID (`jj log -r @ --no-graph -T 'commit_id.short()'` -> `<snapshot-commit-id>`), edit `<file>` so only `C1` remains, run `jj commit -m "..." <file>`, and run `jj restore --from <snapshot-commit-id> <file>` so `@` gets `C1 + C2` back (leaving only `C2` as the diff in `@`).
- Create new change branches with `jj new`.
- Push changes with `jj git push` (or `jj git push -b <bookmark>`).
- Inspect history and status with `jj status` and `jj log`.
- Avoid whole-tree checkout commands (`jj edit`, `jj restore` without paths, or `jj op restore`) when sandbox bind-mounted files (such as `vscode/.config/Code/User/settings.json`) have uncommitted changes in `@`, because `unlink()` on bind-mounted files fails with `EBUSY` and leaves the working copy stale. Prefer path-scoped commands (`jj commit <paths...>`, `jj squash --into <commit> <paths...>`, `jj restore <paths...>`) instead. If a working copy becomes stale from `EBUSY`, recover with `jj --ignore-working-copy op restore <op-id>` followed by `jj status`.
Do not invoke raw `git commit`, `git add`, or `git push` directly in Jujutsu repositories, because doing so bypasses Jujutsu's working copy tracking and revsets.

### Small CLs Workflow (Git and Jujutsu)

Apply the principle of Small CLs by default to ALL code changes, even when not explicitly requested (reference: <https://google.github.io/eng-practices/review/developer/small-cls.html>):

- **Default to small, atomic commits**: Break any feature, bug fix, or refactor into isolated, self-contained commits (CLs). Never bundle unrelated fixes, dead-code cleanups, or refactorings into a single monolithic commit.
- **Accompany each CL with isolated tests**: Every functional commit must include its own unit or integration tests that verify that change in isolation within the same commit.
- **Linear stacked commits**: Structure multi-step work as a linear stack of dependent small commits, each building upon the previous one.
- **Amend respective commits during review**: When addressing review comments or polishing an earlier commit in a stack, update that specific commit directly (such as via `jj squash --into <commit> <paths...>` or `jj edit <commit>` in Jujutsu, or interactive rebase in Git). Create new commits only for genuinely new, independent work.

## Documentation preferences

### Documentation examples

- Use realistic names for types and variables.
