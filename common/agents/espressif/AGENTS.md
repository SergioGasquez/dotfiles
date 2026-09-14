# Espressif development

These instructions apply when working in an `esp-rs` repository, fork, or test project under this directory.

## Repository location and publication

- `esp-rs` repositories are direct children of `$HOME/Documents/Espressif/esp-rs`. Their expected remotes are `origin` for the personal fork and `upstream` for the canonical `esp-rs/<repo>` repository. Verify actual destinations before remote mutations; do not assume test projects use this arrangement.
- Issue implementation requires a task branch, including dependency-only or lockfile-only changes. Use the `branching` skill for creation or continuation; new esp-rs fork branches start from fetched `upstream/main`. Do not implement on `main`.
- Issue implementation requests grant standing permission to verify, commit the scoped changes, and push the issue branch to the verified personal `origin`, unless the user requests local-only work. Audits, reviews, discussion, and naming-only requests do not authorize these mutations.
- Push personal branches with `git push -u origin HEAD`, never an unqualified push. Never push to `upstream/main`. This permission does not authorize force-pushing, merging, releases, or PR creation.
- Report local implementation, validation, commit, and push status separately, including the issue branch. A local fix is not a pushed or merged fix; a blocked push does not erase completed local work.

## Task context

- For target-dependent behavior, identify the affected chip, board, enabled features, and toolchain.
- For chip or peripheral behavior, verify assumptions against the relevant [Technical Reference Manual](https://www.espressif.com/en/support/documents/technical-documents). Use the [ESP-IDF documentation](https://docs.espressif.com/projects/esp-idf/en/latest/) and [implementation](https://github.com/espressif/esp-idf) as supporting references while accounting for differences from Rust.
- For crates other than `esp-hal`, use the repository documentation and published API documentation on `docs.rs` as needed. Follow each repository's changelog policy for the change type. Include a PR number only when one exists; do not invent one or create a PR just to obtain it.

## esp-hal

- Use the current checkout's `documentation/DEVELOPER-GUIDELINES.md` for API/driver changes, feature gating, generated metadata, and documentation conventions. Technical references are under `documentation/`; published crate docs are at https://docs.espressif.com/projects/rust/.
- Do not edit changelog files; changelog entries belong in the pull request description when preparing an authorized PR.
- Preserve stable API compatibility. If a breaking change is required but not authorized, explain its impact and ask before implementing it.

## Validation and completion

- Implementation completion includes the documented checks for affected crate/chip/feature/toolchain combinations and fixes to regressions introduced by the change. Report unavailable coverage rather than implying exhaustive verification.
- Hardware is available, but connection and operation are not implicitly authorized. Identify the exact board, chip, connection method, and physical setup; ask the user to connect it and confirm the requested operation. After confirmation, run the appropriate test, flash, or monitoring commands yourself.
- Complete independent static review and safe build/test work while hardware validation is pending. Treat hardware-dependent behavior as unverified until tested on the relevant device.

## espflash

Compare behavior with [esptool](https://github.com/espressif/esptool) and its
[chip-specific documentation](https://docs.espressif.com/projects/esptool/en/latest/)
when useful, especially for image formats, flashing, reset behavior, and target detection.
