---
name: conventional-commit
description: Create git commits using Conventional Commits format. Use when the user asks to commit changes, prepare a commit message, or clean up commit history.
---

# Conventional Commit

Use this skill whenever the task involves creating a git commit.

## Goals

1. Produce clear and consistent Conventional Commit messages.
2. Avoid committing unrelated changes or secrets.
3. Keep commits focused and easy to review.

## Commit format

```text
type: short imperative summary
```

### Allowed types

- `feat`: new user-facing feature
- `fix`: bug fix
- `docs`: documentation-only changes
- `style`: formatting/style only (no logic change)
- `refactor`: code restructuring without behavior change
- `perf`: performance improvements
- `test`: tests added/updated
- `build`: build/dependency/tooling changes
- `ci`: CI configuration changes
- `chore`: maintenance tasks
- `revert`: revert a previous commit

## Workflow

1. Inspect changes:
   - `git status --short`
   - `git diff --` (and `git diff --staged` if needed)
2. Group changes by intent.
   - If unrelated changes exist, ask whether to split commits.
3. Sanity checks before commit:
   - Run relevant tests/lint if available and cheap.
   - Look for accidental secrets or private data.
4. Stage only the intended files.
5. Create a Conventional Commit message.
6. Commit.
7. Show result with `git log -1 --oneline`.

## Rules

- Do not push unless explicitly asked.
- No scopes.
- Prefer one logical change per commit.
- Keep summary concise (~50-72 chars), imperative mood.
- If scope is unclear, omit it rather than guessing.
- If commit type is ambiguous, ask the user.

## Examples

- `feat: add esp-idf helper alias`
- `fix: correct powershell completion generation`
- `docs: update macOS package install command`
- `chore: ignore local private fish overrides`
