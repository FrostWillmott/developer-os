# Agent Knowledge Base: Ivan's Templates (Developer OS)

This document tracks the current state, architectural decisions, and user preferences for the `templates` repository.

## 🌟 Project Vision
The repository is a **"Developer OS"** or **"Knowledge as Code"** hub. It contains:
- **Claude code/rules-library**: Rules for LLMs to ensure code consistency.
- **Claude code/project-template**: A starter kit for new microservices.
- **FrostWillmott**: GitHub profile templates.
- **Startpages**: Personal browser landing pages.

## 👤 User Profile & Stack
- **Developer**: Ivan Tkachenko (Transitioned from SAP/1C management to Python Backend).
- **Core Stack**:
  - **Language**: Python 3.12+
  - **Framework**: FastAPI
  - **Database**: PostgreSQL with `pgvector` (HNSW indexing preferred).
  - **Patterns**: Clean Architecture (Domain, Use Cases, Interface Adapters, Infrastructure).
  - **IDE**: PyCharm (VS Code has been retired to reduce overhead).

## 🏗️ Architectural Decisions (June 2026)
- **VS Code Retirement**: All VS Code specific configurations (`VSC IDE`, `user_settings.json`) moved to `archive/`.
- **Root README**: Established as the entry point explaining the "Developer OS" concept.
- **Rules Centralization**: AI rules are stored in `Claude code/rules-library/`. Use these for any code generation.
- **Clean Architecture**: Dependencies must always point inward (Infrastructure -> Adapters -> Use Cases -> Domain).

## 📜 Interaction Rules & Workflow
- **Explain WHY before HOW**: Always provide architectural context before implementation details.
- **Git Workflow**:
  - Personal tool files should be added to `.git/info/exclude`, NOT `.gitignore`.
  - **NO** `Co-authored-by` trailers in commit messages.
- **Clean Code**: Use `ruff` for linting and formatting.
- **pgvector**: Use SQLAlchemy 2.0+ mapped models. HNSW is the default for production search.

## 🔄 Recent Discoveries (Session: June 28, 2026)
- The project was successfully reorganized to remove "noise" from the root.
- A new dedicated rule file for `pgvector` was added to the library.
- The repository is intended to be a public portfolio piece for OSS contributions.
