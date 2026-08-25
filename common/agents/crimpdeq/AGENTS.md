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

- For every task, issue, or feature, follow the `branching` skill at
  `$HOME/.pi/agent/skills/branching/SKILL.md`.
- In each affected repository, fetch the canonical remote and create a branch from its `main`
  branch before editing. Use the branch naming convention defined by the skill; never implement
  the work directly on `main`.
- For multidisciplinary work, inspect every affected repository and make the necessary coordinated
  changes on a corresponding branch in each repository.
- After verifying and committing the changes, push each branch with `git push -u origin HEAD`.

## Working across the workspace

- The parent directory is a collection of independent repositories and local design work. Enter the
  affected child directory and inspect its status, branch, remotes, README, and applicable nested
  `AGENTS.md` before editing. Never assume a command run at the parent covers every project.
- Preserve unrelated local changes and generated artifacts. Do not move work between repositories
  or update dependencies, lockfiles, fabrication files, or release assets unless required.
- Read the affected project's current documentation and source before making revision-specific
  assumptions. Keep component choices, dimensions, pin assignments, and other revision details out
  of this workspace-level file.
- Identify the source of truth before changing an interface:
  - PCB electrical and physical design: `crimpdeq-pcb/pcb/crimpdeq/`
  - Enclosure dimensions and placement: `crimpdeq-case/case/`
  - Platform interface: `crimpdeq-platform/src/crimpdeq_interface.scad`
  - User-facing behavior and setup: implementation repositories, reflected in `crimpdeq-book`
- Keep firmware, app, PCB, case, platform, and book assumptions synchronized when BLE behavior,
  pin assignments, dimensions, controls, calibration, or assembly changes.
- Derive mechanical interfaces from shared source geometry; do not copy unexplained dimensions
  between the PCB, enclosure, and platform.
- Treat electrical, RF, fit, strength, calibration, and BLE behavior as unverified until checked on
  the relevant hardware or printed part. Ask for the required physical setup before claiming it
  works.

## Verification

- Firmware: format and build with the repository's pinned Rust/ESP toolchain; only flash or monitor
  hardware after confirming the connected board and requested operation.
- App: run Dart formatting plus focused `flutter analyze` and `flutter test` checks.
- PCB: follow `crimpdeq-pcb/AGENTS.md`; use Konnect for KiCad source changes and run ERC, DRC, and
  the repository verifier.
- Case: follow `crimpdeq-case/AGENTS.md` and run its collision checks after geometry changes.
- Platform: run the relevant OpenSCAD assertions/exports and distinguish digital checks from
  pending physical fit or proof-load validation.
- Book: run `mdbook build` after documentation changes.
- Report checks not run and hardware, fabrication, or physical validation still pending.
