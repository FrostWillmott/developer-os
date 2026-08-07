# Security

This repository is not a runtime application — rule modules are Markdown files
read by AI coding assistants, and `new-project.sh` is a Bash script that copies
files. Nothing here executes in production or handles user data.

## Reporting a vulnerability

If you find a security issue — for example, a rule that would lead to insecure
code if followed blindly, or a bug in the rollout script — please open a GitHub
issue rather than filing a private report. The risk surface is documentation and
developer tooling, not a deployed service.

## What this system protects against

The rule modules encode security practices that apply to the projects built with
them — not to this repo itself. Key security rules include:

- Untrusted input handling and prompt injection defence (`ai-engineering.md`)
- Secret isolation and never-hardcoding credentials (`ai-engineering.md`, `python-core.md`)
- SQL injection and query construction (`backend-fastapi.md`, `postgresql-pgvector.md`)
- Dependency and supply-chain hygiene (`python-core.md`)

These rules are a starting point, not a guarantee. Each project must verify its
own security posture independently.
