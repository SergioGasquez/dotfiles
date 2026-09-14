---
name: branching
description: Create or name a Git branch when requested or required by the workspace workflow.
---

# Branching

- Naming-only requests return a name without changing Git state.
- For branch creation, inspect status, current branch, and remotes. Honor an explicitly requested base or an existing branch for the same task; do not restart ongoing work from the default branch.
- For new work, use the applicable workspace's canonical remote and base. Otherwise determine the repository's default branch rather than assuming `main` or trusting remote names alone.
- When branching from a canonical remote ref, fetch that ref first. If fetching fails, report it rather than silently using stale state. An explicitly requested local base does not require a fetch.
- Preserve unrelated changes. Do not reset, discard, stash, or move them to another task branch without authorization. Ask when their ownership or the intended base is unclear.
- Confirm and report the resulting branch and base. Branch creation does not authorize committing or pushing.

## Naming

Use `type/short-description`: short, lowercase, and hyphenated.

Examples: `feat/add-zed-abbreviation`, `fix/use-zeditor-on-linux`,
`docs/update-branching-skill`, `chore/refresh-shell-config`.

## esp-rs

For new work on an esp-rs fork, verify the remotes and fetch the canonical
`upstream/main`, then create the branch from it. When working directly on the
canonical repository, use `origin/main`. Follow the workspace's publication
policy; never infer a push destination from the branch's tracking configuration.
