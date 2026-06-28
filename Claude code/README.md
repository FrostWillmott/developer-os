# AI rules system — placement guide

A modular setup for Claude Code (and compatible agents). The principle behind
every file here: **always → global, sometimes → rules module, this-project →
project CLAUDE.md, mechanical → linter config.** Push every rule as high up the
enforcement chain as it goes (CI > pre-commit > tool config > prose).

Aligned with current Claude Code memory practices (`.claude/rules/` is loaded
automatically alongside `CLAUDE.md`; keep `CLAUDE.md` under ~200 lines).

---

## Where each file goes

| File in this bundle | Destination | Applies | Tracked in git? |
|---|---|---|---|
| `global/CLAUDE.md` | `~/.claude/CLAUDE.md` | every project, always | n/a (your machine) |
| `rules-library/*.md` | copy into a project's `.claude/rules/` **only when applicable** | per-project, by presence | yes — commit them |
| `project-template/` | a starting skeleton for a fresh repo | new projects | yes |

### The core idea

- **Global `CLAUDE.md`** holds only what is true in *every* project: behavioural
  boundaries and your comment style. It does NOT contain stack specifics,
  architecture choices, or formatting rules (those drift or don't always apply).
- **`rules-library/`** is your canonical source for the modules you sometimes
  apply. Edit a module here once; copy the current version into a project when
  that project needs it. You never maintain stale copies — the library is the
  single source.
- A project gets a module by having the file present in its `.claude/rules/`.
  Absent file = rule not applied. That is your per-project on/off switch.
- **Formatting/linting lives in `ruff.toml`, never in prose.** Agents are told
  (in global CLAUDE.md) that style is the linter's job, and to create/maintain
  the ruff config rather than hand-enforce style.

### One-time activation per machine

- Put `global/CLAUDE.md` at `~/.claude/CLAUDE.md`.
- That's it. `.claude/rules/` files in a repo are picked up automatically — no
  import line needed.

### Verifying it works (do this once on your version of Claude Code)

`.claude/rules/` auto-loading is relatively new. Before relying on it, drop a
module with a distinctive rule into a test repo's `.claude/rules/`, start a
session, and run `/memory` (or ask the agent to state the rule) to confirm it
was loaded. If it wasn't, fall back to importing modules from `CLAUDE.md` with
`@.claude/rules/<file>.md` lines.

---

## Rule levels

Every module tags its rules with one of three levels, defined in
`rules-library/_LEVELS.md`:
- **[MUST]** — hard imperative. All security rules, and the *existence* of
  control infrastructure (linter/formatter/types at pre-commit, critical tests).
- **[MUST-UNLESS]** — mandatory by default, but a genuine technical reason
  permits a *local, documented* exception (never a global disable). Strict
  typing lives here.
- **[PREFER]** — default that project context may override (specific tool rule
  sets, layer splits, DI patterns).

Read `_LEVELS.md` first; it tells the agent how much latitude each rule carries.

## Files in `rules-library/`

- `python-core.md` — Python conventions an agent gets wrong without being told
  (type-hint syntax, async, error handling). The non-mechanical half; the
  mechanical half is in `ruff.toml`.
- `backend-fastapi.md` — FastAPI + async SQLAlchemy patterns.
- `data-engineering.md` — pipeline / SQL / data-handling conventions.
- `ai-engineering.md` — LLM integration patterns (structured outputs, async
  calls, prompt/context handling).
- `clean-architecture.md` — full layered architecture. Apply ONLY to projects
  that want it; many projects are fine with the lighter 3-layer split in
  `backend-fastapi.md`.
- `postgresql-pgvector.md` — pgvector schema, indexing, distance metrics and
  query patterns.
- `testing.md` — pytest conventions: structure, assertions, fixtures, mocking,
  async tests, coverage.
- `workflow-scaffolding.md` — the "set up verification at project start"
  meta-instruction (pre-commit / task runner / CI). Action-on-start, not
  standing behaviour, which is why it's a module not global.

## Files in `project-template/`

- `CLAUDE.md` — skeleton project memory: fill in stack, commands, key decisions.
- `ruff.toml` — standalone ruff config (separate from `pyproject.toml` on purpose).
- `.claude/rules/` — empty; copy the modules this project needs into it.
