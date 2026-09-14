---
name: conventional-commit
description: Draft commit messages or create requested commits using your Conventional Commits conventions.
---

# Conventional Commit

## Format

Use `type: short imperative summary`, without scopes. Aim for a concise summary
of roughly 50–72 characters, not a mandatory minimum.

Allowed types:

- `feat`: new user-facing feature
- `fix`: bug fix
- `docs`: documentation-only changes
- `style`: formatting only, without logic changes
- `refactor`: restructuring without behavior changes
- `perf`: performance improvement
- `test`: tests added or updated
- `build`: build, dependency, or tooling changes
- `ci`: CI configuration changes
- `chore`: maintenance
- `revert`: revert a previous commit

Choose the best-fitting type without asking about minor classification ambiguity.

## Authority and contents

- A message-drafting request returns a message; it does not stage or commit.
- Create commits only when requested or authorized by the applicable workspace workflow. This skill does not grant history-rewriting authority; confirm the intended commits and operation before an otherwise unauthorized rewrite. Do not rewrite published history without explicit approval.
- Inspect the working and staged diffs. Commit only authorized changes, staging hunks when a file contains mixed-intent changes. Leave unrelated work and its staging state untouched.
- Prefer one logical change per commit. Ask only when ownership or intended commit contents cannot be determined safely.
- Check for secrets or private data and use relevant validation evidence. Run additional safe checks when evidence is missing, not merely because a commit is being created.
- Report the resulting commit and any validation limits.
- Push only when requested or explicitly authorized by the applicable workspace workflow, and only to its authorized destination.

Examples:

- `feat: add esp-idf helper alias`
- `fix: correct powershell completion generation`
- `docs: update macOS package install command`
