# Espressif development

These instructions apply when working in an `esp-rs` repository, fork, or test project under this directory.

## Repository location and remotes

- `esp-rs` repositories are direct children of `$HOME/Documents/Espressif/esp-rs`.
- In each repository, `origin` is the `SergioGasquez/<repo>` fork and `upstream` is the canonical `esp-rs/<repo>` repository.
- Never push commits to `upstream/main`.
- Push personal branches to `origin` and fetch canonical changes from `upstream`. Verify remote names before any command that could change remote branches.
- Push personal branches with `git push -u origin HEAD`. Never use an unqualified `git push` when the branch tracks `upstream/main`; inspect the configured upstream and correct it to `origin/<branch>` first.
- Before changing any file for a GitHub issue, read the applicable `AGENTS.md` files, activate the `branching` skill, inspect the current branch and remotes, and create the issue branch. Do not begin issue work on `main`, including dependency-only or lockfile-only changes.
- When `upstream` is `esp-rs/<repo>`, fetch `upstream/main` and create the branch from `upstream/main` using the naming convention in the `branching` skill. Make, verify, and commit all issue changes on that branch, then push it to `origin` (`SergioGasquez/<repo>`).
- Before reporting an issue as fixed, confirm that the current branch is the issue branch and that its commits containing the fix have been pushed to `origin`; include the branch name in the report.

## General workflow

- Identify the affected chip, board, enabled features, and toolchain before reasoning about behavior; support and peripheral details vary by target.
- Read the repository's documentation, source, examples, and tests before making changes.
- For chip or peripheral behavior, verify assumptions against the relevant [Technical Reference Manual](https://www.espressif.com/en/support/documents/technical-documents). Use the [ESP-IDF documentation](https://docs.espressif.com/projects/esp-idf/en/latest/) and [implementation](https://github.com/espressif/esp-idf) as additional references while accounting for differences from the Rust implementation.
- For crates other than `esp-hal`, consult their repository documentation and published API documentation on `docs.rs`.
- Relevant Espressif hardware is available for testing. When hardware validation is needed, identify the exact board, chip, connection method, and physical setup; ask the user to connect it. After confirmation, run the appropriate test, flash, or monitoring commands yourself. Treat hardware-dependent behavior as unverified until tested on the relevant device.

## esp-hal

The source of truth is `documentation/DEVELOPER-GUIDELINES.md`. It is a living document: read the version in the current checkout fully when working on APIs or drivers, and follow it over this summary. Also consult the [technical documentation](https://github.com/esp-rs/esp-hal/tree/main/documentation) and [published crate documentation](https://docs.espressif.com/projects/rust/).

- Do not edit changelog files; changelog entries are tracked in the pull request description.
- Follow the Rust API Guidelines where applicable and prefer consistency with existing driver patterns.
- Keep APIs easy to use. Avoid unnecessary type states and generics, prefer `&self` when safe, and preserve naming and ordering conventions.
- Prefer compile-time checks. When runtime validation is necessary, return an error instead of panicking.

### Public APIs and drivers

- Document every new public API and driver. Keep implementation details private; use `#[doc(hidden)]` with an explanation when they must be public, and seal traits that downstream users must not implement.
- Mark new public APIs unstable according to the current repository guidelines. Gate unstable ecosystem traits and APIs behind the appropriate feature.
- For drivers supporting multiple peripheral instances, type-erase the instance using the repository's `any_peripheral` pattern instead of making the driver type generic over it.
- Put configurable driver options in a private-field `Config` type in the same module. Follow the repository's Builder Lite pattern, take configuration by value in the constructor, return a dedicated `ConfigError`, and provide `apply_config`.
- Include a `DriverMode` parameter when async support exists or may be added. Construct drivers in blocking mode and provide conversions that correctly apply and undo async configuration.
- Implement `Drop` to return peripherals to an idle state unless one of the documented exceptions applies.
- Follow the repository's expected traits for drivers, configurations, and errors. When `Debug` is expected, support `defmt::Format` behind the `defmt` feature.

### Maintainability and documentation

- Use the logging wrappers from `fmt.rs`, not `log::...` macros directly.
- Use metadata and generated symbols for conditional compilation. Follow the current developer guidelines for updating and committing generated metadata.
- Prefer the repository's recommended conditional-selection mechanisms over multiple mutually exclusive `#[cfg]` blocks. Keep per-instance capabilities in instance metadata rather than chip-wide configuration.
- Avoid excessive macros and simplify code where possible. When porting or citing code, use permanent links containing a commit hash or document revision.
- Prefer line comments over block comments.
- Annotate named `Future` types with `#[must_use = "futures do nothing unless you `.await` or poll them"]`.
- For peripheral module documentation, use the relevant Overview, Configuration, Usage, Examples, and Implementation State sections. Keep examples short and `no_run`, prefer `?` over `unwrap`, and use rustdoc item links where possible.
- Assume stable APIs are semver-checked. Do not introduce breaking changes unless explicitly requested and handled through the repository workflow.

### Before finishing

1. Format with the repository's `rustfmt.toml`.
2. Run relevant checks and tests for every affected crate, chip, feature set, and toolchain.
3. Confirm `defmt`, `unstable`, chip, and other feature gating is correct.
4. Confirm all new or changed public APIs are documented.
5. Keep the change minimal and consistent with existing `esp-hal` code.

## espflash

- Compare behavior with [esptool](https://github.com/espressif/esptool) and its [chip-specific documentation](https://docs.espressif.com/projects/esptool/en/latest/) when useful, especially for image formats, flashing, reset behavior, and target detection.
