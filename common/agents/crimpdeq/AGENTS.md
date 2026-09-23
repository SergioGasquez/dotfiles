# Crimpdeq workspace

These instructions apply to projects under `$HOME/Documents/Crimpdeq`.

## Product overview

Crimpdeq is an open-source portable force sensor for climbing and rehabilitation. This workspace
contains its software, electronics, mechanical design, and documentation.

## Projects

- `crimpdeq-firmware`: Rust firmware for sensing, calibration, power management, and BLE.
- `crimpdeq-app`: Flutter client for BLE connection, calibration, measurements, and charts.
- `crimpdeq-pcb`: canonical KiCad source and manufacturing outputs. Its nested `AGENTS.md`
  contains mandatory PCB instructions.
- `crimpdeq-case`: parametric OpenSCAD enclosure. Its nested `AGENTS.md` defines geometry
  invariants and validation.
- `crimpdeq-book`: mdBook source for user, assembly, calibration, firmware, and PCB documentation.
- `crimpdeq-board`: legacy board repository. Confirm that it is the intended target before editing;
  prefer `crimpdeq-pcb` unless directed otherwise.

## Branch workflow

- For implementation work, follow the branching workflow in the `git` skill at
  `$HOME/.pi/agent/skills/git/SKILL.md`. Audits, reviews, discussion, and naming-only requests
  do not require branch creation, commits, or pushes.
- Use a task branch in each affected repository, never `main`. New task branches start from the
  fetched canonical remote's `main`; existing branches for the same task can continue.
- Implementation requests grant standing permission to verify, commit the scoped changes, and
  push the task branches with `git push -u origin HEAD`, unless the user requests local-only work.
  Verify that `origin` is the intended personal repository before publishing. This does not
  authorize force-pushing, merging, releases, or PR creation.
- Completion includes the affected project's checks below and fixes to regressions introduced by
  the change. Report local implementation, validation, commit, and push status separately;
  unavailable hardware or publication does not block independent local work.

## Working across the workspace

- The parent contains independent repositories and local design work; run project commands from
  the affected child repository, not the workspace root.
- Do not move work between repositories or update dependencies, lockfiles, fabrication files, or
  release assets unless required by the task.
- For revision-specific component choices, dimensions, or pin assignments, use the affected
  project's current source and documentation; keep those details out of this workspace-level file.
- Interface sources of truth:
  - PCB electrical and physical design: `crimpdeq-pcb/pcb/crimpdeq/`
  - Enclosure dimensions and placement: `crimpdeq-case/case/`
  - Platform fit reference: `crimpdeq-platform/crimpdeq_reference.scad`; platform parameters and
    structural assertions: `crimpdeq-platform/dynamometer_dimensions.scad`
  - User-facing behavior and setup: implementation repositories, reflected in `crimpdeq-book`
- Keep firmware, app, PCB, case, platform, and book assumptions synchronized when BLE behavior,
  pin assignments, dimensions, controls, calibration, or assembly changes.
- Derive mechanical interfaces from shared source geometry; do not copy unexplained dimensions
  between the PCB, enclosure, and platform.
- Digital checks do not validate electrical, RF, fit, strength, calibration, or BLE behavior on
  hardware or printed parts. Identify the physical setup and obtain operation confirmation before
  hardware testing; report physical validation still pending.

## Verification

- Firmware changes: use the repository's pinned Rust/ESP toolchain for formatting and builds.
- App code changes: use Dart formatting plus focused `flutter analyze` and `flutter test` checks.
- KiCad source changes: use `crimpdeq-pcb/AGENTS.md` for Konnect, direct-edit safeguards, ERC,
  DRC, and the repository verifier.
- Case: follow `crimpdeq-case/AGENTS.md` and run its collision checks after geometry changes.
- Platform geometry changes: run the relevant OpenSCAD assertions/exports; these do not replace
  physical fit or proof-load validation.
- Book documentation changes: run `mdbook build`.
