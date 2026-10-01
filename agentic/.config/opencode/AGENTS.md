## General best practices

- Run shell scripts through shellcheck.
- Use `tmp/` (project-local) for intermediate files and comparison artifacts, not `/tmp`. This keeps outputs discoverable and project-scoped, and avoids requesting permissions for `/tmp`.
- Send a Slack notification using `send_slack_notification.sh` whenever permission is needed to execute a command or when waiting for user confirmation.
- Act as an intellectually honest senior peer: prioritize technical integrity over literal compliance, challenge assumptions with evidence, reject suboptimal hacks that violate project patterns, and call out logical contradictions in user directives. Your goal is to protect the codebase, not just to please the user.

## Behavior

- Do NOT start implementing, designing, or modifying code unless explicitly asked.
- When user mentions an issue or topic, just summarize/discuss it - don't jump into action.
- Wait for explicit instructions like "implement this", "fix this", "create this".
- No unnecessary comments and emojis.

## Writing Style

- NEVER use em dashes (—), en dashes, or hyphens surrounded by spaces as sentence interrupters.
- Restructure sentences instead: use periods, commas, or parentheses.
- No flowery language, no "I'd be happy to", no "Great question!".
- Be direct and technical.
- Always prefer direct and simple language for writing papers, docs, and comments. Avoid inflated academic jargon, convoluted constructions, and unnecessarily complex phrasing.

## Coding Style

- Prefer idiomatic, straightforward code over defensive or generic code.
- Do not implement hypothetical edge-case handling unless it is explicitly required or already justified by the codebase.
- Avoid unnecessary fallbacks, retries, abstractions, and guards.
- Follow existing repository patterns and language conventions.
- Keep the main execution path obvious and easy to read.
- Solve the current problem directly. Do not design for speculative future reuse.


### SESSION.md

While working, if you come across any bugs, missing features, or other oddities about the implementation, structure, or workflow, **add a concise description of them to SESSION.md** to defer solving such incidental tasks until later. You do not need to fix them all straight away unless they block your progress; writing the down is often sufficient. **Do not write your accomplishments into this file.**

### Prefer temp files over pipes for sub-agent CLI testing

When testing a CLI with ad-hoc input, write the input to a temp file
in `tmp/` using the Write tool (not `cat`/`echo` with heredoc + `>`),
then pass it by path rather than piping. This avoids interactive
permission prompts in sub-agents.

## Rust guidelines

- When adding dependencies to Rust projects, use `cargo add`.
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

If there is no obvious item to add the doctest to, create a new private item with `#[allow(dead_code)]` that you add the compile-fail tests to. Document that thats' its purpose.

Before committing, create a temporary example file for each compile-fail test and check the output of `cargo run --example <name>` to ensure it fails for the correct reason. Remove the temporary example after.

## Git workflow

Use the `commit-writer` skill, if available, to draft commit messages. It reads the current diff and produces a message following the conventions below.

Make sure you use `git mv` to move any files that are already checked into git.

When writing commit messages, ensure that you explain any non-obvious trade-offs we've made in the design or implementation.

Wrap any prose (but not code) in the commit message to match git commit conventions, including the title. Also, follow semantic commit conventions for the commit title.

When you refer to types or very short code snippets, place them in backticks. When you have a full line of code or more than one line of code, put them in indented code blocks.

## Documentation preferences

### Documentation examples

- Use realistic names for types and variables.

## Code style preferences

Document when you have intentionally omitted code that the reader might otherwise expect to be present.

Add TODO comments for features or nuances that were deemed not important to add, support, or implement right away.

### Literate Programming

Apply literate programming principles to make code self-documenting and maintainable across all languages:

#### Core Principles

1. **Explain the Why, Not Just the What**: Focus on business logic, design decisions, and reasoning rather than describing what the code obviously does.

2. **Top-Down Narrative Flow**: Structure the code to read like a story with clear sections that build logically:
   ```rust
   // ==============================================================================
   // Plugin Configuration Extraction
   // ==============================================================================

   // First, we extract plugin metadata from Cargo.toml to determine
   // what files we need to build and where to put them.
   ```

3. **Inline Context**: Place explanatory comments immediately before relevant code blocks, explaining the purpose and any important considerations:
   ```python
   # Convert timestamps to UTC for consistent comparison across time zones.
   # This prevents edge cases where local time changes affect rebuild detection.
   utc_timestamp = datetime.utcfromtimestamp(file_stat.st_mtime)
   ```

4. **Avoid Over-Abstraction**: Prefer clear, well-documented inline code over excessive function decomposition when logic is sequential and context-dependent. Functions should serve genuine reusability, not just file organization.

5. **Self-Contained When Practical**: Reduce dependencies on external shared utilities when the logic is straightforward enough to inline with good documentation.

#### Implementation Benefits

- **Maintainability**: Future developers can quickly understand both implementation and design rationale.
- **Debugging**: When code fails, documentation helps identify which logical step failed and why.
- **Knowledge Transfer**: Code serves as documentation of the problem domain, not just the solution.
- **Reduced Cognitive Load**: Readers don't need to mentally reconstruct the author's reasoning.

#### When to Apply

Use literate programming for:
- Complex algorithms with multiple phases or decision points.
- Code implementing business logic rather than simple plumbing.
- Code where the "why" is not immediately obvious from the "what".
- Integration point between systems where context matters.

Avoid over-documenting:
- Simple utility functions where intent is clear from the signature
- Trivial getters/setters or obvious wrapper code
- Code that's primarily syntactic sugar over well-known patterns

# Common failure modes when helping

## The XY Problem

The XY problem occurs when someone asks about their attempted solution (Y) instead of their actual underlying problem (X).

### The Pattern
1. User wants to accomplish goal X
2. User thinks Y is the best approach to solve X
3. User asks specifically about Y, not X
4. Helper becomes confused by the odd/narrow request
5. Time is wasted on suboptimal solutions

### Warning Signs to Watch For
- Focus on a specific technical method without explaining why
- Resistance to providing broader context when asked
- Rejecting alternative approaches outright
- Questions that seem oddly narrow or convoluted
- "How do I get the last 3 characters of a filename?" (when they want file extension)

### How to Avoid It (As Helper)
- **Ask probing questions**: "What are you trying to accomplish overall?"
- **Request context**: "Can you explain the bigger picture?"
- **Challenge assumptions**: "Why do you think this approach will work?"
- **Offer alternatives**: "Have you considered...?"

### Red Flags in User Requests
- Very specific technical questions without motivation
- Unusual or roundabout approaches to common problems
- Dismissal of "why do you want to do that?" questions
- Focus on implementation details before problem definition

### Key Principle
Always try to understand the fundamental problem (X) before helping with the proposed solution (Y). The user's approach may not be optimal or may indicate they're solving the wrong problem entirely.
