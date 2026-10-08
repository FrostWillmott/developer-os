# Developer OS

**A modular rule library and project template for agentic development.**

A single source of truth for AI agent rules and project scaffolding: canonical
rule modules tagged by enforcement level, plus a starter kit that wires them
into a new repo's `.claude/` config, CI, and pre-commit.

---

## The rule-level model

Every convention in this system is tagged with one of three levels. The level tells
the AI agent how much latitude it has — no guessing from tone:

| Level | Meaning | Example |
|---|---|---|
| `[MUST]` | Non-negotiable. Never relaxed for convenience. | "No blocking call inside `async def` without offloading." |
| `[MUST-UNLESS]` | The default is mandatory, but a documented technical reason permits a local deviation. | Strict typing — default on, `# type: ignore[arg-type] # reason` allowed. |
| `[PREFER]` | The agent follows by default; project context may override. | "Prefer `pathlib` over `os.path`." |

**When project `CLAUDE.md` conflicts with a `[PREFER]` rule, the project wins.**
When it conflicts with a `[MUST]`, the agent surfaces the conflict rather than
quietly following either.

See [`rules-library/_LEVELS.md`](rules-library/_LEVELS.md) for the full definition.

---

## Quick start

```bash
./new-project.sh <target-dir> [module ...]
```

Copies the project skeleton (`project-template/`) and the rule modules you pick
from `rules-library/` into a new or existing repo. Never overwrites files already
there — safe to re-run.

```bash
./new-project.sh my-project python-core testing documentation
./new-project.sh --list   # see available modules
```

Then fill in the TODOs in the generated `CLAUDE.md` and run `make install`.

---

## Structure

```
developer-os/
├── new-project.sh           ← roll the template + chosen rule modules into a repo
├── docs/
│   └── harness-guide.md     ← how to build an effective AI harness
├── project-template/        ← starter kit copied into new repos
│   ├── .claude/             ← rules/, hooks/, skills/, settings.json
│   ├── .github/workflows/   ← CI: lint + type + test on push
│   ├── Makefile             ← make install / check / fix / test
│   ├── ruff.toml            ← standalone linter config
│   ├── .pre-commit-config.yaml
│   ├── CLAUDE.md            ← project-level agent guidance (TODOs to fill)
│   └── DECISIONS.md         ← append-only decision log
└── rules-library/           ← canonical rule modules
    ├── _LEVELS.md           ← the rule-level model
    └── *.md                 ← one module per concern
```

---

## Rule modules

Copy only the modules the project needs. Absent file = rule not applied.

| Module | When to apply |
|---|---|
| `python-core.md` | Every Python project |
| `backend-fastapi.md` | FastAPI + async SQLAlchemy services |
| `testing.md` | Any project with pytest |
| `ai-engineering.md` | Projects integrating LLMs |
| `postgresql-pgvector.md` | Projects using pgvector |
| `data-engineering.md` | Pipeline / ETL projects |
| `clean-architecture.md` | Full layered architecture (opt-in only) |
| `documentation.md` | Every project — keep `README.md` and `DECISIONS.md` current |
| `config-hygiene.md` | Services that read configuration from the environment |
| `ci-pipeline.md` | Any repo with a CI workflow — a pushed commit is confirmed green by command |
| `transactional-web.md` | Multi-user apps on shared state: concurrency, idempotency, outbox, live updates |
| `frontend-vue.md` | A Vue 3 + TypeScript frontend |
| `workflow-scaffolding.md` | Pointer to the `workflow-scaffolding` Skill in the template |

Modules support `paths:` YAML frontmatter to load only when the agent works with
matching files. See [`docs/harness-guide.md`](docs/harness-guide.md) for details.

---

## Philosophy and deeper dive

The [`docs/harness-guide.md`](docs/harness-guide.md) covers:

- **Enforcement hierarchy** — CI > pre-commit > Claude Code hooks > rules > prose
- **Context layers** — static context, path-scoped rules, on-demand Skills
- **Dual-review protocol** — why a second, independent pass catches what a single pass misses
- **Provider-agnostic design** — rules work regardless of which model generates the code
- **Token economics** — where to put each kind of content so you don't pay for it every session

---

## Stack (what the rules assume)

- **Language:** Python 3.12+
- **Framework:** FastAPI; Vue 3 + TypeScript for a frontend (`frontend-vue.md`)
- **DB:** PostgreSQL + pgvector
- **Tooling:** uv, ruff, mypy, pytest, Docker

---

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

MIT — see [`LICENSE`](LICENSE).
