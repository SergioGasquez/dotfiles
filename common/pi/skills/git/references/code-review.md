# Code Review

Review the requested scope without editing files or publishing comments unless
authorized. Read the PR description or linked issue when available and relevant;
do not require a PR for a local review.

Trace affected behavior and contracts, using callers, tests, and documentation as
needed. Prioritize concrete correctness, regression, security, and performance
risks over stylistic preferences. Separate verified defects from assumptions or
questions, and do not invent findings to fill a category.

## Findings

For each actionable finding, include:

- severity: **Blocking** (must fix) or **Recommendation** (non-blocking)
- file and line, or the smallest relevant location
- the triggering condition and consequence
- supporting evidence and a practical correction when clear

Keep optional nits separate. Ask questions only when missing intent materially
changes the assessment. Praise is optional.

Finish with the overall assessment, key risks, and validation limits. If no
findings are supported, say so. Return findings in chat; post PR/MR comments or
submit an approval/request-changes review only when publication is authorized.

## esp-rs reviews

- For API or driver changes in `esp-hal`, consult the current checkout's `documentation/DEVELOPER-GUIDELINES.md` and relevant technical documentation. Use https://docs.espressif.com/projects/rust/ for `esp-hal` crate docs; use official `docs.rs` documentation for other crates.
- For chip or peripheral behavior, consult the relevant TRM at https://www.espressif.com/en/support/documents/technical-documents. Use ESP-IDF documentation or implementation as supporting evidence, accounting for differences from Rust.
- For `espflash` image formats, reset, flashing, or target detection, compare with https://github.com/espressif/esptool and the relevant chip documentation at https://docs.espressif.com/projects/esptool/en/latest/ when useful.
- Complete static review and safe local checks even when hardware is unavailable. Identify the exact board and setup needed for remaining verification; request connection and operation confirmation before running hardware tests. Report hardware-dependent conclusions as unverified until tested.
