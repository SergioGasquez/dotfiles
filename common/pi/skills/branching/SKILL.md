---
name: branching
description: Create and manage git branches safely. Use when the user asks to create a branch, prepare branch naming, or update branch workflow instructions.
---

# Branching

Use this skill whenever the task involves creating or naming a git branch.

## Goals

1. Start new work from the correct base branch.
2. Use clear, predictable branch names.
3. Avoid branching from stale local state.

## General workflow

1. Inspect remotes and current branch if needed:
   - `git remote -v`
   - `git branch --show-current`
   - `git status --short`
2. Identify the correct base branch.
3. Update refs before creating the branch when cheap and safe.
4. Create the new branch.
5. Confirm with `git branch --show-current`.

## Branch naming

Prefer Conventional Commit style branch names:

```text
type/short-description
```

Examples:

- `feat/add-zed-abbreviation`
- `fix/use-zeditor-on-linux`
- `docs/update-branching-skill`
- `chore/refresh-shell-config`

## esp-rs workflow

When working on an `esp-rs` repository and creating a new branch, always use Conventional Commit style branch names such as:

- `feat/...`
- `fix/...`
- `docs/...`
- `chore/...`

### If working on a fork

1. Fetch `upstream` first.
2. Create the branch from `upstream/main`, not from the local branch and not from `origin/main`.

Example:

```bash
git fetch upstream
git switch -c fix/short-description upstream/main
```

### If working on the origin repository directly

1. Fetch `origin` first.
2. Create the branch from `origin/main`, not from the local branch.
3. Use the same Conventional Commit branch naming system.

Example:

```bash
git fetch origin
git switch -c fix/short-description origin/main
```

## Rules

- Prefer branching from the canonical remote branch instead of local state.
- If an `upstream` remote exists for fork-based work, treat it as the source of truth.
- If working directly on the origin repository, treat `origin/main` as the source of truth.
- Keep branch names short, lowercase, and hyphenated.
- Avoid vague names like `test`, `stuff`, or `changes`.
