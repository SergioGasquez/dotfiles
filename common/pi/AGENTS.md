# Rules

- Be direct, technical, and tactful
- Lead with the conclusion and include evidence, material caveats, and the next action

## Code

- Before adding code, check: does it need to exist, is it already here, does stdlib/native platform handle it, does an installed dependency handle it, can it be one line, etc
- Aim for the minimum code that solves the problem
- Start from the data (types / schema) and functions call stack, and build from there
  - Define concrete inputs/outputs (data in -> data out) of the problem you are solving
  - Inspect real values
- Use simple, explicit, practical solutions optimized for readability and clear intent
- Keep functions and modules small and with clear composable interfaces
  - Model work as a sequence/DAG with contracts for shape, meaning, ...
- Keep high locality code so is easy to understand that source by looking at only a small portion of it
- Keep APIs and public interfaces small, behavior explicit, intention-revealing, and naming clear
- No speculative abstractions, one-use interfaces, factories, config, or scaffolding for later
- Remove unnecessary code, optimize for deletion and clean your own mess
- Read files in full before wide-ranging changes, before editing files you have not fully inspected, and when asked to investigate or audit
- Never preserve backward compatibility unless the user asks for it
- The codebase is your memory system, make the code self-explanatory

### Execution Model

- Avoid fallbacks and legacy branches
- Fail fast with clear error messages
- Validate conditions explicitly instead of relying on exceptions
- Verify changes work by running the code, tests, and linters
- For ad-hoc scripts, write them to a temp file (e.g. /tmp), run, edit if needed, remove when done or do it entirely inline
- Fix bugs at the root cause by inspecting callers and fixing the shared path when possible

## Git

- Commits: keep them atomic and use short descriptive messages
- Pull requests: use a short title and a concise body describing the changes (no summary header, no validation section)
- Branches: use simple descriptive names (`fix/async-stream`, `feat/users-model`)
- Use `gh` for PRs, reviews, issues, and anything related with GitHub like search

## esp-rs repositories

When working in an `esp-rs` repository or fork:

- Identify the affected chip, board, enabled features, and toolchain before reasoning about behavior; support and peripheral details vary by target.
- Read the repository's documentation, source, examples, and tests first. For `esp-hal`, also consult its [technical documentation](https://github.com/esp-rs/esp-hal/tree/main/documentation) and [published crate documentation](https://docs.espressif.com/projects/rust/).
- Do not edit changelog files in `esp-hal`; changelog entries are tracked in the PR description.
- For chip or peripheral behavior, verify assumptions against the relevant [Technical Reference Manual](https://www.espressif.com/en/support/documents/technical-documents). Use the [ESP-IDF documentation](https://docs.espressif.com/projects/esp-idf/en/latest/) and [implementation](https://github.com/espressif/esp-idf) as additional references, while accounting for differences from the Rust implementation.
- For other crates, use their repository documentation and published API documentation on `docs.rs`.
- Treat hardware-dependent behavior as unverified unless it was tested on the relevant device. When hardware is required, ask the user to connect the exact board and provide the command to run, expected result, and any output needed for diagnosis.
- For `espflash`, compare behavior with [esptool](https://github.com/espressif/esptool) and its [chip-specific documentation](https://docs.espressif.com/projects/esptool/en/latest/) when useful, especially for image formats, flashing, reset behavior, and target detection.
