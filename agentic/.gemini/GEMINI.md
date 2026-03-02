## General best practices

- Run shell scripts through shellcheck.
- Use `tmp/` (project-local) for intermediate files and comparison artifacts, not `/tmp`. This keeps outputs discoverable and project-scoped, and avoids requesting permissions for `/tmp`.

### SESSION.md

While working, if you come across any bugs, missing features, or other oddities about the implementation, structure, or workflow, **add a concise description of them to SESSION.md** to defer solving such incidental tasks until later. You do not need to fix them all straight away unless they block your progress; writing the down is often sufficient. **Do not write your accomplishments into this file.**

## Rust guidelines

- When adding dependencies to Rust projects, use `cargo add`.
- In code that uses `eyre` or `anyhow` `Result`s, consistently use `.context()` prior to every error-propagation with `?`. Context messages in `.context` should be simple present tense, such as to complete the sentence "while attempting to ...".
- Prefer `expect()` over `unwrap()`. The `expect` message should be very concise, and should explain why that expect call cannot fail.
- 
