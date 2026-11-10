---
name: subagents
description: Orchestrate and delegate work to other agents with hc. Use only when the operator authorizes delegation.
disable-model-invocation: true
---

# Subagents

Run `hc --skill` and `herdr-app --skill` once for their manuals, then:

- Give each worker one concise, atomic task with context, constraints, expected output, and how to verify their work
- Don't add `herdr.*` labels to workers of a chat shown in Herdr, they appear under it in the Agents list
  - Only when the user wants a worker as its own tab, or this chat has no Herdr pane, reuse or create a Herdr space on the worker's machine named after the basename of the chat's working folder (not the worker's temporary checkout), and pass its machine-local ID to `hc run --label "herdr.space=<id>"`
- Launch with an explicit provider, model, and thinking level: `pi --provider <provider> --model <model> --thinking <level>`
- If your `$HC_TERMINAL_ID` is set, tell workers to report with `hc send <your $HC_TERMINAL_ID>` when done or stuck, substituting your actual terminal address
- Workers don't start agents unless explicitly assigned
- Accept work from its actual results (diff, output, files), not its status
- Ask for proofs (runs, screenshots, etc) that things work as expected
- Manage, steer and clean up only the terminals you started
- If you're orchestrating, get back to the user once you've delegated the tasks to continue the conversation while the subagents work (they'll report when done)

## Models

- Coding: `--provider anthropic --model claude-opus-5-5 --thinking medium`
- Oracle: `--provider openai-codex --model gpt-6-astra --thinking xhigh`
- Research and exploration: run both in parallel on high thinking
  - `--provider anthropic --model claude-opus-5-5`
  - `--provider openai-codex --model gpt-6.1-sol`
- By default use `pi`; use the `codex` or `claude` CLIs only when specified
