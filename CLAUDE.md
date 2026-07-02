# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repo is a "Developer OS" — a single source of truth for AI agent rules and project scaffolding for Ivan's Python projects. It is not a runnable application; there are no tests or services here.

Two deliverables:
- **`rules-library/`** — canonical rule modules for Claude Code. Each `.md` file is a self-contained convention set for a specific concern (Python, FastAPI, testing, etc.). Rule levels (`[MUST]`, `[MUST-UNLESS]`, `[PREFER]`) are defined in `_LEVELS.md`.
- **`project-template/`** — a starter kit to copy into a new repo. Contains a ready-to-use `Makefile`, `ruff.toml`, `.pre-commit-config.yaml`, and `.claude/rules/` scaffold with a `CLAUDE.md` template.

## How to use this repo

**Starting a new project:**
1. Copy `project-template/` into the new repo root.
2. Fill in `project-template/CLAUDE.md`: project description, active modules, architecture divergences, commands.
3. Copy only the rule modules you need from `rules-library/` into `.claude/rules/` of the new repo.
4. Delete `project-template/.claude/rules/_PUT_MODULES_HERE.txt`.
5. In the new repo: `make install && make install-hooks`.

**Adding or editing a rule module:**
- Edit or add a file under `rules-library/`. Keep each file focused on one concern.
- Tag every rule with `[MUST]`, `[MUST-UNLESS]`, or `[PREFER]` as defined in `_LEVELS.md`.
- The `workflow-scaffolding.md` module is meta — it governs how to set up tooling on project start, not ongoing conventions.

## Rule module index

Canonical list lives in [`README.md`](README.md), "Rule modules" section — don't duplicate it here.

## Git

- Do not add AI-tool references, co-author lines, or "generated with" notes to commit messages.
- Personal tool files go in `.git/info/exclude`, not `.gitignore`.
