# Espressif development

These instructions apply when working in an `esp-rs` repository, fork, or test project under this directory.

## Repository location and publication

- `esp-rs` repositories are direct children of `$HOME/Documents/Espressif/esp-rs`. Their expected remotes are `origin` for the personal fork and `upstream` for the canonical `esp-rs/<repo>` repository. Verify actual destinations before remote mutations; do not assume test projects use this arrangement.
- Issue implementation requires a task branch, including dependency-only or lockfile-only changes. Use the branching reference in the `git` skill for creation or continuation; new esp-rs fork branches start from fetched `upstream/main`. Do not implement on `main`.
- Issue implementation requests grant standing permission to verify, commit the scoped changes, and push the issue branch to the verified personal `origin`, unless the user requests local-only work. Audits, reviews, discussion, and naming-only requests do not authorize these mutations.
- Push all created branches to `origin` with `git push -u origin HEAD`, never an unqualified push. Never push to `upstream/main`. This permission does not authorize force-pushing, merging, releases, or PR creation.
- Report local implementation, validation, commit, and push status separately, including the issue branch. A local fix is not a pushed or merged fix; a blocked push does not erase completed local work.

## Task context

- For target-dependent behavior, identify the affected chip, board, enabled features, and toolchain.
- For chip or peripheral behavior, verify assumptions against the relevant [Technical Reference Manual](https://www.espressif.com/en/support/documents/technical-documents). Use the [ESP-IDF documentation](https://docs.espressif.com/projects/esp-idf/en/latest/) and [implementation](https://github.com/espressif/esp-idf) as supporting references while accounting for differences from Rust.
- For crates other than `esp-hal`, use the repository documentation and published API documentation on `docs.rs` as needed. Follow each repository's changelog policy for the change type. Include a PR number only when one exists; do not invent one or create a PR just to obtain it.

## esp-hal

- Use the current checkout's `documentation/DEVELOPER-GUIDELINES.md` for API/driver changes, feature gating, generated metadata, and documentation conventions. Technical references are under `documentation/`; published crate docs are at https://docs.espressif.com/projects/rust/.
- Do not edit changelog files; changelog entries belong in the pull request description when preparing an authorized PR.
- Preserve stable API compatibility. If a breaking change is required but not authorized, explain its impact and ask before implementing it.
- When drafting a PR, suggesting one, or reviewing one, follow `.github/PULL_REQUEST_TEMPLATE.md` and the changelog section of `documentation/CONTRIBUTING.md`:
  - Provide the `# Changelog` entries per crate (`Added`/`Changed`/`Fixed`/`Removed`, or `No changelog necessary.`).
  - State explicitly whether a migration guide is needed. It is needed whenever user code must change; provide the `# Migration guide` section with `## <crate>/<area>` and a `### Title` per breaking change.
  - In reviews, flag missing, wrong, or unnecessary changelog and migration guide entries.
- When opening, suggesting, or reviewing a PR, state which HIL runs should be triggered, as `/hil` comment commands from `documentation/HIL-GUIDE.md`:
  - Map the changed drivers to `hil-test/src/bin/*` binaries (or `hil-test-radio` for radio code) and to the affected chips, e.g. `/hil esp32c3 esp32s3 --tests spi, i2s`.
  - Use `/hil quick` for small changes that are not chip-specific, and `/hil full` for cross-cutting changes such as interrupts, DMA, clocks, linker scripts, or `esp-metadata`.
  - Say when no HIL run is needed, e.g. for docs-only or tooling-only changes.
  - Posting the comment publishes it; suggest the command unless the user asks you to post it.

## espflash

- Compare behavior with [esptool](https://github.com/espressif/esptool) and its [chip-specific documentation](https://docs.espressif.com/projects/esptool/en/latest/) when useful, especially for image formats, flashing, reset behavior, and target detection.
- Breaking changes are allowed only when the next release is a major version. `espflash` and `cargo-espflash` follow SemVer, and their public surface includes the `espflash` library API, CLI arguments and defaults, config files, and machine-readable output. Before implementing a breaking change, explain its impact and ask whether a major release is planned; prefer additive or deprecating alternatives. In reviews, flag unannounced breaking changes as blocking.
- Run HIL tests when a change affects device interaction: flashing, connection, reset, stubs, target detection, chip support, eFuses, secure download mode, image formats, or monitoring. When opening, suggesting, or reviewing a PR, state which `/hil` command from `.github/HIL.md` should be triggered (`/hil quick`, `/hil <chips>` using `.github/hil-targets.json`, `/hil sdm`, or `/hil full`). Say when no HIL run is needed. Posting the comment publishes it; suggest the command unless the user asks you to post it.

## Validation and completion

- Implementation completion includes the documented checks for affected crate/chip/feature/toolchain combinations and fixes to regressions introduced by the change. Report unavailable coverage rather than implying exhaustive verification.
- Hardware is available, but connection and operation are not implicitly authorized. Identify the exact board, chip, connection method, and physical setup; ask the user to connect it and confirm the requested operation. After confirmation, run the appropriate test, flash, or monitoring commands yourself.
- Complete independent static review and safe build/test work while hardware validation is pending. Treat hardware-dependent behavior as unverified until tested on the relevant device.
