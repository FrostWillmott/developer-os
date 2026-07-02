# CLAUDE.md
Guidance for Claude Code when working in this repository.

<!--
  Keep this file under ~200 lines. It holds what THIS repo needs every session:
  stack, commands, key decisions. Universal style lives in ~/.claude/CLAUDE.md;
  reusable conventions live in .claude/rules/*.md (loaded automatically).
-->

## Project
<!-- One paragraph: what this is, the stack, and its purpose/status. -->
TODO: e.g. REST API for X. Stack: FastAPI, async SQLAlchemy 2.0 + asyncpg,
PostgreSQL, Alembic, Docker. Package manager: uv.

## Active rule modules
<!-- List which .claude/rules/ modules apply, so it's visible at a glance. -->
<!-- documentation.md is on by default (README.md + DECISIONS.md upkeep) unless removed here. -->
TODO: e.g. python-core, backend-fastapi, ai-engineering, documentation.

## Architecture divergences
<!--
  If this project deliberately differs from an applied module, say so here in
  one line so the agent doesn't "correct" you. Project CLAUDE.md overrides modules.
-->
TODO: e.g. This project uses a 3-layer split (routers/services/db), NOT full
Clean Architecture, and has no repository layer — services call SQLAlchemy directly.

## Commands
<!-- The exact verify-all command and the common ones. Prefer a single entry point. -->
```bash
make install   # uv sync --extra dev + pre-commit install
make check     # lint + type + test — run before finishing any task
make fix       # ruff --fix + format
make test      # TODO
```

## Key design decisions
<!-- Full log lives in DECISIONS.md (see documentation.md); keep this as a short pointer, not a duplicate. -->
See [`DECISIONS.md`](DECISIONS.md) for the full, dated log.

## Git
- Do not add AI-tool references, co-author lines, or "generated with" notes to
  commit messages.
