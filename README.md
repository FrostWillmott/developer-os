# Templates (Developer OS)

Personal rules library and project skeleton for AI-assisted Python development.
A single source of truth for code conventions, agent rules, and project scaffolding.

---

## Structure

```
rules/
├── project-template/    ← copy this into a new repo
│   ├── .claude/rules/   ← drop rule modules here
│   ├── CLAUDE.md
│   ├── Makefile
│   ├── .pre-commit-config.yaml
│   └── ruff.toml
└── rules-library/       ← canonical rule modules
    ├── _LEVELS.md
    └── *.md
```

---

## How to use

### Starting a new project

1. Copy `rules/project-template/` into the new repo root.
2. Fill in `CLAUDE.md`: project description, active modules, architecture divergences, commands.
3. Copy the rule modules you need from `rules/rules-library/` into `.claude/rules/`.
4. Run `make install && make install-hooks`.

### One-time machine setup

Put `~/.claude/CLAUDE.md` with global agent behaviour (behavioural boundaries, comment
style). `.claude/rules/` files in each repo are picked up automatically alongside it — no
import line needed.

Verify auto-load once: drop a module with a distinctive rule into a test repo's
`.claude/rules/`, start a session, and ask the agent to state the rule.

---

## Rule modules (`rules/rules-library/`)

Rule levels — `[MUST]` / `[MUST-UNLESS]` / `[PREFER]` — are defined in `_LEVELS.md`.
Copy only the modules the project needs; absent file = rule not applied.

| Module | When to apply |
|---|---|
| `python-core.md` | Every Python project |
| `backend-fastapi.md` | FastAPI + async SQLAlchemy services |
| `testing.md` | Any project with pytest |
| `ai-engineering.md` | Projects integrating LLMs |
| `postgresql-pgvector.md` | Projects using pgvector |
| `data-engineering.md` | Pipeline / ETL projects |
| `clean-architecture.md` | Full layered architecture (opt-in only) |
| `workflow-scaffolding.md` | Apply at project start to set up tooling |

---

## Stack (core)

- **Language:** Python 3.12+
- **Framework:** FastAPI
- **DB:** PostgreSQL + pgvector
- **Tooling:** uv, ruff, mypy, pytest, Docker
