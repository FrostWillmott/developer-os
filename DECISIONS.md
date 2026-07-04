# Decisions

Append-only log of non-obvious choices for this repo — not a changelog of
every commit. Newest entry at the top; see `rules-library/documentation.md`
for the convention. Don't edit past entries; if a decision is reversed, add a
new one that supersedes it.

## 2026-07-04 — Manual rollout instructions removed, `new-project.sh` is the sole carrier

Removed the remaining manual rollout duplicates from `CLAUDE.md` ("Starting a new project"
5-step list) and `docs/harness-guide.md` (the "Manual fallback" paragraph) — `new-project.sh`
is now the single source of truth for the rollout procedure. This supersedes the 2026-07-02
restore of the manual fallback (commit `55f3aa1`), which was a precautionary interrupt of an
in-progress dedup, not a considered decision to keep the manual path documented.

## 2026-07-02 — Implemented HARNESS_AUDIT.md §7 top-3 recommendations

Following the ROI ranking in `HARNESS_AUDIT.md` §7 (audit contract, enforcement before
expansion, dedupe + automate rollout), in that order:
- `new-project.sh` — scripted rollout of `project-template/` + chosen rule modules,
  replacing the manual "Starting a new project" steps that had already drifted out of
  sync across `README.md`/`CLAUDE.md`/`AGENTS.md`.
- `project-template/.github/workflows/ci.yml`, `.claude/hooks/lint-on-edit.sh`,
  `.claude/hooks/warn-non-anthropic.sh`, wired into `.claude/settings.json` — the template
  had `hooks: {}` and no CI; enforcement was documented in `docs/harness-guide.md` but not
  actually implemented anywhere it would run.
- `audit-diff` skill (`project-template/.claude/skills/audit-diff/`, mirrored at
  `~/.claude/skills/audit-diff/`) — dual review had no fixed checklist or threshold and
  `/code-review` had been invoked once in months of use; the skill turns "Junie → Claude"
  from an ad-hoc prompt into a procedure with a mechanical `make check` gate and an
  Anthropic-only endpoint gate (a non-Anthropic session can't audit its own generator).
- Deduplicated the module index (now canonical in `README.md` only), `AGENTS.md` (now a
  one-line pointer to `CLAUDE.md`), and `workflow-scaffolding.md` (now a pointer to the
  Skill); trimmed `.junie/AGENTS.md` to remove phantom content the audit flagged
  (FrostWillmott, Startpages, `archive/`, a stale "Recent Discoveries" section, and Clean
  Architecture described as the default pattern rather than the opt-in module it is).
- Translated `docs/harness-guide.md` to English and extended it to cover project setup via
  the new script, the dual-review protocol, and the provider switcher — the machine-config
  half of this rollout (`~/.zshrc` switcher, `~/.claude/settings.json`,
  `~/.junie/AGENTS.md`) applied directly, outside this repo's git history.

## 2026-07-01 — Agents keep README.md and DECISIONS.md current by default

Added `rules-library/documentation.md`: unless a project's own CLAUDE.md (or
the current task) says otherwise, the agent creates and maintains both files
as part of the change that makes them stale, not as separate cleanup work.
Wired into the rule module index in `CLAUDE.md`/`AGENTS.md`/`README.md`, and
into `project-template/CLAUDE.md` + a `project-template/DECISIONS.md` stub so
new projects start with the convention in place.

## 2026-06-28 — Rules centralized in `rules-library/`

All AI agent conventions live as one canonical module per concern under
`rules-library/`, tagged `[MUST]` / `[MUST-UNLESS]` / `[PREFER]` per
`_LEVELS.md`. Projects copy only the modules they need into `.claude/rules/` —
absent file means the rule doesn't apply, so the library can grow without
forcing every project to carry every rule.

## 2026-06-28 — Root `README.md` is the entry point

Established the root README as the explanation of the "Developer OS" concept
(structure, how to use, stack) rather than duplicating that content in
`CLAUDE.md`. `CLAUDE.md`/`AGENTS.md` stay focused on agent-operational
guidance for working in this specific repo.

## 2026-06-28 — VS Code configuration retired

VS Code-specific config (`VSC IDE`, `user_settings.json`) moved to `archive/`.
PyCharm is the IDE in active use; keeping unused editor config in the working
tree added noise without value.
