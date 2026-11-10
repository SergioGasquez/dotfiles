---
name: loop
description: Implement and review code changes with workers on different frontier models.
disable-model-invocation: true
---

# Loop

Make code changes by delegating to workers on different frontier models. Delegate using [subagents](../subagents/SKILL.md).

## Work

- Delegate work (implementations, fixes, docs) to one or several coding workers (`--provider anthropic --model claude-opus-5-5 --thinking medium`)
- Give each worker an atomic task with a concise prompt. Add relevant context, constraints, expected output, and verification criteria
  - Ask them for irrefutable proof that it works

## Review

- Focus on getting concrete evidence that it works over reviewing code
- Quickly review the code, but don't nitpick
- Watch for scope creep and push back on it
- Review changes with two read-only workers in parallel, both on medium thinking:
  - `--provider anthropic --model claude-opus-5-5`
  - `--provider openai-codex --model gpt-6.1-sol`
- Reviewers don't start agents
- Reviewers should surface cleanup and simplification opportunities
- Maximum 2 rounds; stop early when possible
