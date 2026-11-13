---
name: espflash-hil-tests
description: >
  Run espflash HIL tests (`xtask run-tests`) and espflash commands (flash,
  monitor, board-info, read-flash) on boards of the remote Espressif HIL rig
  over SSH. Use when running, reproducing or debugging espflash hardware tests,
  when testing an espflash change on a board while developing it, or when the
  user mentions the espflash HIL workflow, a `hil-<chip>` host or `/hil` in
  espflash. Not for esp-hal HIL tests (`hil-test/`); use the `hil-tests` skill
  for those.
---

# Running espflash HIL tests

Each shell command runs in a new shell, so set environment variables on the same command line as
the command that uses them. Run the commands from the root of the espflash checkout (or worktree).

## Select the board

Runs on the remote rig are authorized; do not ask for confirmation. A local board needs the user's
confirmation (see the Espressif `AGENTS.md`); this skill covers the rig only.

- Each chip has one board on a shared aarch64 Linux host. The SSH alias is `hil-<chip>`, for example
  `hil-esp32c6`; the aliases are in `~/.ssh/config`. If no alias exists for a chip, or SSH fails
  with `Host key verification failed`, ask the user. Do not accept an unknown host key yourself.
- The board has `/dev/serial_ports/usb` (native USB-Serial-JTAG) and/or `/dev/serial_ports/uart`
  (USB-UART bridge). `.github/hil-targets.json` lists the ports CI tests per chip.
- The host has no Rust toolchain. You build `espflash` and `xtask` locally and copy them with the
  checkout to `~/espflash-hil/` on the host. Do not change anything on the host outside that
  directory, and do not use `sudo` or `usbreset`.
- Secure download mode (SDM) tests run on a separate CI runner with no SSH alias. They are CI-only:
  suggest `/hil sdm`.

## Choose what to run

Run only the tests the change affects:

1. Map the changed code to the tests in `run_specific_test` of `xtask/src/test_runner.rs`, for
   example `board-info`, `flash`, `monitor`, `erase-region`, `read-flash`, `reset`. The default
   test `all` runs the whole suite (`run_all_tests`). `direct-boot` only has firmware for the chips
   in `DIRECT_BOOT_CHIPS`; `partition-table` (`offline`) runs only by name.
2. Map the change to chips and ports with `.github/hil-targets.json`. Pass the port as `--console`
   (`usb` or `uart`) and in `ESPFLASH_PORT=/dev/serial_ports/<port>`. Add the target's
   `extraArgs` (`--extended` on `esp32c6` `uart`) only with `all`; named tests ignore it (named
   `list-ports` always runs its extended checks).
3. Start with one test on one chip and one port. Widen to `all`, more ports or more chips only when
   the change is chip- or port-specific in a way the first run does not cover, or when the narrow
   run passes and the user asked for broader coverage.

For cross-cutting changes (connection, flasher stub, serial or reset handling), suggest `/hil full`
in CI (or `/hil quick` for `esp32c6` and `esp32s3`) instead of running every board yourself.

## Check that the rig is free

Other users and the CI of esp-hal and espflash share the boards: both repositories use one GitHub
Actions runner per board on the same host. Before each run, list the HIL jobs in progress:

```bash
gh run list -R esp-rs/espflash --workflow hil.yml --status in_progress --json databaseId,displayTitle
gh run list -R esp-rs/esp-hal --workflow hil.yml --status in_progress --json databaseId,displayTitle
gh run list -R esp-rs/esp-hal --workflow ci.yml --event merge_group --status in_progress --json databaseId,displayTitle
```

Then check the host:

```bash
ssh hil-esp32c6 'pgrep -af "[R]unner.Worker"; pgrep -ax "espflash|xtask"; fuser -v /dev/serial_ports/* 2>&1; echo checked'
```

- `Runner.Worker` means a CI job of either repository is running on this board. Wait until it ends
  (`gh run watch -R <repo> <id>`). `Runner.Listener` alone means the runner is idle.
- The `[R]` stops `pgrep -f` from matching the remote `bash -c` that runs the check.
- An `espflash` or `xtask` process means another espflash session is using the board. Wait.
  `pgrep` without `-f` matches process names, which it truncates to 15 characters; keep the
  pattern that short.
- `fuser` only shows your own processes; the runner and `probe-rs serve` run as another user.
- espflash does not take the probe-rs lock. `probe-rs serve` on the host manages the probe, and
  esp-hal CI and remote probe-rs users connect to it, so it serializes them, but espflash opens the
  serial port beside it. Their sessions run inside `probe-rs serve`, so they are not visible as
  processes; an esp-hal CI job only shows as `Runner.Worker` and in `gh run list`. An espflash
  reset or flash breaks such a session, and its resets drop your port. If an esp-hal HIL job for
  the chip is in progress, wait.

### Guard every command

The check only covers the moment you run it, and nothing makes a CI job wait for you: the runner
takes a job as soon as it is idle. Start every remote command that touches the board with this
guard, so it refuses to start once a CI job is on the board:

```bash
ssh hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; ...'
```

Exit code 75 means a CI job took the board. CI has priority:

- Stop. Do not retry in a loop and do not fight it for the port.
- Tell the user which run was on the board (`gh run list` above) and whether your last command
  overlapped it, so they can decide whether to re-run it. Do not re-run other people's runs or
  comment on their PRs.
- Continue when `gh run watch -R <repo> <id>` ends and the check passes again.

A job can still start in the middle of a command, so keep commands short.

## Build

CI builds with `cross build --release --target aarch64-unknown-linux-gnu -p espflash -p xtask`.
On Linux x86_64, use that command. On an Apple Silicon Mac, `cross` 0.2.5 needs an x86_64 Linux
toolchain; build in a native arm64 Rust container instead (Docker must be running):

```bash
docker run --rm --platform linux/arm64 -v "$PWD":/src -v espflash-hil-cargo:/usr/local/cargo/registry -w /src rust:1-bookworm cargo build --release --target aarch64-unknown-linux-gnu -p espflash -p xtask
```

The binaries are in `target/aarch64-unknown-linux-gnu/release/`. The image's glibc must not be newer
than the host's (`ssh hil-<chip> 'ldd --version'`); `bookworm` matches.

Use this command for every build, also when you only need `espflash`. Building `-p espflash` alone
resolves other dependency features, rebuilds them each time you switch, and failed once with
`can't find crate for nix`. With the same command, a build after a source edit takes about 7 s and
an unchanged build does nothing.

## Sync

`xtask` finds the workspace from the current directory and reads `espflash/tests/data` and
`espflash/resources/bootloaders`, so copy the checkout too. The binaries go to `bin/`, because
`espflash/` and `xtask/` are directories of the checkout:

```bash
ssh hil-esp32c6 'mkdir -p ~/espflash-hil/src ~/espflash-hil/bin'
rsync -az --delete --exclude /.git --exclude /target ./ hil-esp32c6:espflash-hil/src/
rsync -az target/aarch64-unknown-linux-gnu/release/espflash target/aarch64-unknown-linux-gnu/release/xtask hil-esp32c6:espflash-hil/bin/
```

Sync again after every change to the code or the test data. `--delete` also removes the files that
earlier runs wrote to `espflash/tests/`. Leave `~/espflash-hil/` on the host for the next run.
Commands you run by hand only need the binaries (see below).

## Reset and run

Reset the board like the CI "Prepare device" step, then run the test:

```bash
ssh hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; cd ~/espflash-hil/src && ESPFLASH_SKIP_UPDATE_CHECK=true timeout 20 ../bin/espflash reset --port /dev/serial_ports/usb && sleep 5 && ESPFLASH_SKIP_UPDATE_CHECK=true ESPFLASH_PORT=/dev/serial_ports/usb timeout 300 ../bin/xtask run-tests board-info --chip esp32c6 --timeout 90 --baud 921600 --console usb --espflash ../bin/espflash' > /tmp/espflash-hil-esp32c6-usb.log 2>&1
rg -a "test passed|failed: |All tests completed" /tmp/espflash-hil-esp32c6-usb.log
```

- `xtask` exits non-zero and logs `Test '<name>' failed: ...` or `Test suite failed: ...` on
  failure. Negative tests print `Error:` and `panicked at` lines while they pass, so do not search
  for those. UART logs can contain NUL bytes, so `rg` needs `-a`.
- A named test takes seconds (`board-info` about 5 s, `flash` 20 to 30 s). `all` takes minutes; CI
  gives a board job 30 minutes. Wrap `xtask` in `timeout` on the host, `timeout 300` for a named
  test and `timeout 1800` for `all`, and give the local shell command a longer timeout. Exit code
  124 means the remote `timeout` stopped the run.
- If the USB reset fails and the board has `/dev/serial_ports/uart`, reset through UART
  (`espflash reset --port /dev/serial_ports/uart`), wait 2 s for the USB port to appear, and reset
  the USB port again.
- On `esp32` (FT2232H board), a probe-rs session can leave the JTAG pins driving MTDI high, so the
  flash stops responding and reset or flash fails. CI fixes this with `usbreset`, which you must not
  run; report it as the likely cause.
- Add `RUST_LOG=debug` before `../bin/xtask` for espflash debug output, like CI.

## Run espflash commands by hand

Use a rig board to try an espflash change on a chip or port while you develop it. Keep each
session short and guard every command: a CI job can start on the board at any time.

Use a local board instead (with the user's confirmation) for macOS or Windows serial behavior,
other USB-UART bridges, other flash or PSRAM variants, BOOT/RESET buttons, replugging or power
cycles, and `cargo-espflash` (the host has no cargo). Never write eFuses or enable secure boot or
flash encryption on a rig board.

1. Check that the board is free, build, and copy only the binary. `rsync` does not create missing
   parent directories, so create them first:
   ```bash
   ssh hil-esp32c6 'mkdir -p ~/espflash-hil/bin ~/espflash-hil/work'
   rsync -az target/aarch64-unknown-linux-gnu/release/espflash hil-esp32c6:espflash-hil/bin/
   ```
2. Copy the firmware you build locally (an ELF or a binary image) to `work/`:
   ```bash
   rsync -az <local-elf> hil-esp32c6:espflash-hil/work/app.elf
   ```
3. Run commands with `timeout` on the host and the output in a log file:
   ```bash
   ssh hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; ESPFLASH_SKIP_UPDATE_CHECK=true timeout 30 ~/espflash-hil/bin/espflash board-info --port /dev/serial_ports/usb --non-interactive' > /tmp/espflash-rig.log 2>&1
   ssh hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; ESPFLASH_SKIP_UPDATE_CHECK=true timeout 120 ~/espflash-hil/bin/espflash flash --port /dev/serial_ports/usb --non-interactive ~/espflash-hil/work/app.elf' > /tmp/espflash-rig.log 2>&1
   ssh hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; ESPFLASH_SKIP_UPDATE_CHECK=true timeout 10 ~/espflash-hil/bin/espflash monitor --port /dev/serial_ports/usb --non-interactive --elf ~/espflash-hil/work/app.elf' > /tmp/espflash-rig.log 2>&1
   ```
   `flash` must exit 0. A monitor only ends at the timeout, so exit code 124 is expected for
   `monitor`. Flash and monitor in two commands: flashing time grows with the app size and is
   slow at the default 115200 baud on a `uart` port, so a short monitor timeout can stop the
   flash. When you test
   `flash --monitor` itself, give it the flash timeout plus the monitor time, and treat exit 124
   as a monitor end only if the log contains `Flashing has completed!`.
4. Write outputs to `work/` and copy them back:
   ```bash
   ssh hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; ESPFLASH_SKIP_UPDATE_CHECK=true timeout 60 ~/espflash-hil/bin/espflash read-flash --port /dev/serial_ports/usb --non-interactive 0x10000 0x1000 ~/espflash-hil/work/read.bin' > /tmp/espflash-rig.log 2>&1
   rsync -az hil-esp32c6:espflash-hil/work/read.bin /tmp/
   ```

- Always put `timeout` inside the remote command. Without a TTY, killing the local `ssh` does not
  stop the remote `espflash` or `xtask`: it keeps the board until it finishes, and `xtask` keeps
  starting the next test. After an aborted command, check with `pgrep -ax "espflash|xtask"` and
  stop only your own processes, `xtask` first:
  `ssh hil-esp32c6 'pkill -u "$(id -un)" -x xtask; pkill -u "$(id -un)" -x espflash'`.
- For an interactive monitor, the user runs this in their terminal; Ctrl+R resets the chip and
  Ctrl+C exits:
  ```bash
  ssh -t hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; ESPFLASH_SKIP_UPDATE_CHECK=true ~/espflash-hil/bin/espflash monitor --port /dev/serial_ports/usb'
  ```
  To test the monitor keys yourself, send them through a forced TTY:
  ```bash
  (sleep 5; printf '\x12'; sleep 5; printf '\x03') | ssh -tt hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; ESPFLASH_SKIP_UPDATE_CHECK=true timeout --foreground 30 ~/espflash-hil/bin/espflash monitor --port /dev/serial_ports/usb --elf ~/espflash-hil/work/app.elf' > /tmp/espflash-rig.log 2>&1
  ```
  `--foreground` keeps the monitor in the terminal's foreground process group. Without it,
  `timeout` moves the monitor to a background group whenever another command follows it, and the
  keys do not reach espflash. If the monitor prints nothing, reset the chip with Ctrl+R.
- Leave the board in a state CI can recover from. Do not leave firmware that disables native USB on
  a chip that has no `uart` port in `.github/hil-targets.json`.

## Run more than one board

- Run one job at a time on a board. The `usb` and `uart` ports of a chip are the same board, so run
  them one after the other.
- Run jobs for different boards in parallel, each with its own alias and log file:
  ```bash
  ssh hil-esp32c6 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; cd ~/espflash-hil/src && ESPFLASH_SKIP_UPDATE_CHECK=true ESPFLASH_PORT=/dev/serial_ports/usb timeout 300 ../bin/xtask run-tests flash --chip esp32c6 --timeout 90 --baud 921600 --console usb --espflash ../bin/espflash' > /tmp/espflash-hil-esp32c6-usb.log 2>&1 &
  ssh hil-esp32c5 'pgrep -f "[R]unner.Worker" >/dev/null && { echo "CI job on this board" >&2; exit 75; }; cd ~/espflash-hil/src && ESPFLASH_SKIP_UPDATE_CHECK=true ESPFLASH_PORT=/dev/serial_ports/uart timeout 300 ../bin/xtask run-tests flash --chip esp32c5 --timeout 90 --baud 921600 --console uart --espflash ../bin/espflash' > /tmp/espflash-hil-esp32c5-uart.log 2>&1 &
  wait
  ```
  Check, sync and reset each board first. One build serves every board.

## When the board does not run the code

Stop after two failed attempts to reset, flash or run on the same board. Report the board, the
commands, and the output you saw. Do not change the rig setup.
