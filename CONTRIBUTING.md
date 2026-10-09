# Contributing

This is a rule-level system for AI-assisted development — a library of conventions
and a project scaffolding script. Contributions that make the rules clearer, more
precise, or more broadly applicable are welcome.

## Scope

- **In scope:** rule modules in `rules-library/`, the project template
  (`project-template/`), the rollout script (`new-project.sh`), and documentation
  (`docs/`).
- **Out of scope:** anything specific to one person's workflow or machine setup.
  This is a general-purpose system.

## Rule-level discipline

Every rule is tagged `[MUST]`, `[MUST-UNLESS]`, or `[PREFER]` as defined in
[`rules-library/_LEVELS.md`](rules-library/_LEVELS.md). When proposing a new rule
or changing an existing one:

1. Pick the right level. Most new rules start as `[PREFER]` — promote to
   `[MUST-UNLESS]` or `[MUST]` only if the failure mode is concrete and frequent.
2. State the failure scenario — what breaks when this rule is not followed.
3. Keep modules self-contained. One concern per file.

## Process

1. Open an issue describing the problem the change solves. If it's a new rule,
   include a concrete example of code that violates it and the failure that results.
2. A PR with the change. For rule modules, the PR should show the diff to the
   relevant `.md` file in `rules-library/`.
3. If you're adding a new module, update the module table in [`README.md`](README.md).
4. Run `make check` (needs [uv](https://docs.astral.sh/uv/)) — CI runs the same command on the PR.

## Style

- Rule modules are Markdown, ~50–150 lines each.
- Every `[MUST]` rule justifies itself — "why" in one line.
- No AI-tool references in commit messages (the repo content references tools by
  design; commit history stays clean).
