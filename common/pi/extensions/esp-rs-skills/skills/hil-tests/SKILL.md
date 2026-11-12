---
name: hil-tests
description: >
  Run esp-hal HIL tests (`hil-test/`) on hardware, on a board that is connected
  to this computer or on the remote Espressif HIL rig through probe-rs presets.
  Use when running, reproducing or debugging HIL tests on hardware, or when the
  user mentions a connected board, the remote rig, the HIL runner or a
  `<chip>-hil` preset. Not for examples or QA tests (`examples/`), which run with
  espflash over a local serial port. Not for espflash HIL tests (`xtask
  run-tests`); use the `espflash-hil-tests` skill for those.
---

# Running HIL tests

The rules in this file apply to local and remote boards. Only the board selection is different.
Each shell command runs in a new shell, so set the board variable on the same command line as the
command that uses it.

## Select the board

### Remote board (default)

Runs on the remote rig are authorized; do not ask for confirmation.

Each chip has a board on the rig. The probe-rs preset for a chip is `<chip>-hil`, for example
`esp32-hil`, `esp32s3-hil`, `esp32c6-hil`. The presets are in `~/.probe-rs.toml`; read that file
for the list. Each preset connects to an SSH alias from `~/.ssh/config`. Never print
`PROBE_RS_REMOTE_TOKEN` or copy it anywhere.

```bash
PROBE_RS_CONFIG_PRESET=esp32-hil cargo xtask test esp32 spi_stable
```

### Local board

Using a local board needs the user's confirmation (see the Espressif `AGENTS.md`).

1. Run `probe-rs list` and `espflash list-ports`.
2. Identify the chip on each serial port with `espflash board-info --port <port>`. The serial number
   of a probe in `probe-rs list` is the MAC address of its chip, for example
   `303a:1001:AA:BB:CC:DD:EE:FF` is the chip with MAC `aa:bb:cc:dd:ee:ff`.
3. Set `PROBE_RS_PROBE=<VID>:<PID>:<serial>` from `probe-rs list` on the command line.

### Both

Use the board of the chip you need. If no board or preset exists for that chip, ask the user.

## Choose what to run

Run only the tests the change affects:

1. Map the changed code to the `hil-test/src/bin/*` binaries that use it, and to the chips where
   that code is compiled (its `cfg`s and the binaries' `CHIP_FILTER`).
2. Start with the narrowest run: one test (`Run one test`) when you are debugging one failure,
   otherwise the affected configurations on one affected chip.
3. Widen to more chips or configurations only when the change is chip-specific in a way the first
   chip does not cover, or when the narrow run passes and the user asked for broader coverage.

Do not run every test binary, every configuration, or every chip unless the user asks. For
cross-cutting changes (interrupts, DMA, clocks, linker scripts, `esp-metadata`), suggest
`/hil full` in CI instead of running it on the rig yourself.

## Check that the rig is free

Other users and CI share the rig boards. Before a run, list the HIL jobs in progress:

```bash
gh run list -R esp-rs/esp-hal --workflow hil.yml --status in_progress --json databaseId,displayTitle
gh run list -R esp-rs/esp-hal --workflow ci.yml --event merge_group --status in_progress --json databaseId,displayTitle
gh run list -R esp-rs/espflash --workflow hil.yml --status in_progress --json databaseId,displayTitle
```

The run titles list the chips. For a merge queue run, all chips are in use.

esp-hal and espflash CI share one GitHub Actions runner per board, on the host of the preset's SSH
alias (`hil-<chip>`). Check that runner before a run:

```bash
ssh hil-esp32 'pgrep -af "[R]unner.Worker"; echo checked'
```

`Runner.Worker` means a CI job of either repository is running on this board; `Runner.Listener`
alone means the runner is idle. The `[R]` stops `pgrep -f` from matching the remote `bash -c` that
runs the check.

- probe-rs locks the probe. If esp-hal CI or another user holds it, `probe-rs` waits up to the
  preset `attach-timeout` (600 s) and then fails. Start your run anyway; expect it to be slow.
- espflash HIL jobs use the serial port and do not take the probe lock. If one is in progress for
  your chip, wait until it ends (`gh run watch -R esp-rs/espflash <id>`). For some minutes after
  such a job, the `usb_serial_jtag_*` tests of `misc_non_drivers` can fail. Run those again before
  you blame the code.
- If the attach times out, report that the probe is busy. Do not retry in a loop.

## Run a whole test binary

```bash
PROBE_RS_CONFIG_PRESET=esp32-hil cargo xtask test esp32 spi_stable
```

The last argument is a test configuration: the binary name, or `<binary>_<label>` with the label
from a `//% CHIP_FILTER(<label>)`, `//% FEATURES(<label>)` or `//% ENV(<label>)` line, for example
`spi_stable` or `alloc_psram_llff`. See `xtask/README.md` for the annotations.

## Run one test (faster)

1. Build the configuration:
   ```bash
   cargo xtask build tests esp32 spi_stable
   ```
2. Run the ELF with a test name filter:
   ```bash
   PROBE_RS_CONFIG_PRESET=esp32-hil probe-rs run --preverify target/xtensa-esp32-none-elf/release/spi read::cpu_transfer
   ```

- The ELF is in `target/` of the repository root (or worktree root), not in `hil-test/target/`.
  The file name is the binary name without the label (`spi`, `alloc_psram`). The Rust target per
  chip is in `.github/chips.json`.
- The filter is a positional argument. Do not put it after `--`. Then probe-rs ignores the probe
  selection and reports "No connected probes were found".

## Run more than one job

- Run one job at a time on a board.
- Run jobs for different boards in parallel, each with its own board variable and log file:
  ```bash
  PROBE_RS_CONFIG_PRESET=esp32-hil cargo xtask test esp32 spi_stable > /tmp/hil-esp32.log 2>&1 &
  PROBE_RS_CONFIG_PRESET=esp32s3-hil cargo xtask test esp32s3 spi_stable > /tmp/hil-esp32s3.log 2>&1 &
  wait
  ```
  Cargo locks `target/`, so the builds run one after the other, but the board runs overlap.
- Chips with the same Rust target (`.github/chips.json`) share one binary path. The build of one
  chip overwrites the binary that the other chip flashes. Run the jobs of those chips one after the
  other.

## Read the results

- Runs take minutes. Write the output to a log file and search it:
  ```bash
  PROBE_RS_CONFIG_PRESET=esp32-hil cargo xtask test esp32 spi_stable > /tmp/hil-esp32.log 2>&1
  rg "test result|FAILED|panicked at|^error" /tmp/hil-esp32.log
  ```
- Give the shell command a long timeout (10 minutes or more, plus the attach timeout when the rig
  is busy).

## Test output

- Tests print through semihosting, not RTT. Semihosting is slow.
- A long panic message (for example a large `assert_eq!` on arrays) does not finish before the
  default 3 s test timeout, and the log is cut off. Use short panic messages, or add
  `#[timeout(30)]` to the test.
- `defmt` output needs `//% FEATURES: defmt` in the test file. It changes timing, so use it only
  when needed.

## When the board does not run the code

Stop after two failed attempts to flash or run on the same board. Report the board, the commands,
and the output you saw. Do not change the rig setup.
