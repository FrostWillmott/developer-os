# Templates (Developer OS)

Personal rules library and project skeleton for AI-assisted Python development.
A single source of truth for code conventions, agent rules, and project scaffolding.

---

## Structure

```
templates/
├── new-project.sh        ← roll the template + chosen rule modules into a repo
├── docs/
│   └── harness-guide.md  ← how to build the optimal harness
├── project-template/     ← copy this into a new repo
│   ├── .github/
│   │   └── workflows/ci.yml   ← lint + type + test on push
│   ├── .claude/
│   │   ├── rules/         ← drop rule modules here
│   │   ├── hooks/         ← lint-on-edit, non-Anthropic endpoint warning
│   │   ├── skills/        ← on-demand skill files (workflow-scaffolding, audit-diff)
│   │   └── settings.json
│   ├── CLAUDE.md
│   ├── DECISIONS.md
│   ├── Makefile
│   ├── .pre-commit-config.yaml
│   └── ruff.toml
└── rules-library/        ← canonical rule modules
    ├── _LEVELS.md
    └── *.md
```

---

## How to use

### Starting a new project

```bash
./new-project.sh <target-dir> [module ...]   # defaults: python-core testing documentation
./new-project.sh --list                      # see available modules
```

### One-time machine setup

Put `~/.claude/CLAUDE.md` with global agent behaviour (behavioural boundaries, comment
style). `.claude/rules/` files in each repo are picked up automatically alongside it — no
import line needed.

Verify auto-load once: drop a module with a distinctive rule into a test repo's
`.claude/rules/`, start a session, and ask the agent to state the rule.

See **[docs/harness-guide.md](docs/harness-guide.md)** for the full guide: enforcement
hierarchy, context layers, project setup detail, the dual-review
protocol, the provider switcher, and day-to-day workflow.

---

## Rule modules (`rules-library/`)

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
| `documentation.md` | Every project — keep `README.md` and `DECISIONS.md` current, unless the project says otherwise |
| `workflow-scaffolding.md` | Pointer only — canonical content is the `workflow-scaffolding` Skill in `project-template/.claude/skills/` |

Modules support `paths:` YAML frontmatter to load only when Claude works with matching
files. See [harness-guide.md](docs/harness-guide.md) for examples and the full context model.

---

## Stack (core)

- **Language:** Python 3.12+
- **Framework:** FastAPI
- **DB:** PostgreSQL + pgvector
- **Tooling:** uv, ruff, mypy, pytest, Docker
