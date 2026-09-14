# Rules

- Be direct, technical, and tactful.
- Lead with the conclusion and include evidence, material caveats, and the next action.

## Scope

- Do not expand a task into speculative abstractions or compatibility work.
- If a breaking change is necessary but not already authorized, explain the impact and ask before implementing it.

## Execution and completion

- For implementation requests, continue through scoped edits, relevant safe checks, and repairs to regressions introduced by the change. Finish when the requested behavior works and relevant checks pass, or report a blocker requiring user input; no automatic first-pass review stop.
- Production access, hardware operations, publication, and host setup changes require authorization; a command named test or run does not imply safety or permission.
- Continue independent safe work when another part is blocked. Report completed work, validation evidence, and remaining limits.
- Audit and review requests are read-only unless changes are requested. Return review findings in chat unless publication is authorized.

## Git

- Commit or publish only when requested or explicitly authorized by the applicable workspace workflow. Drafting a message or reviewing a PR does not authorize committing or posting.
- Pull requests: use a short title and a concise body describing the changes (no summary header, no validation section).
- Use `gh` for PRs, reviews, issues, and other GitHub operations.
