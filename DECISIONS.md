# Decisions

Append-only log of non-obvious choices for this repo — not a changelog of
every commit. Newest entry at the top; see `rules-library/documentation.md`
for the convention. Don't edit past entries; if a decision is reversed, add a
new one that supersedes it.

## 2026-10-08 — Downstream rule changes flow back here; projects carry exact copies

A downstream project had grown its copies of the modules well past the
library: four new modules (`ci-pipeline`, `config-hygiene`, `frontend-vue`,
`transactional-web`) and additions to `_LEVELS`, `documentation`, `python-core`
and `testing`. Those additions now live here, so the rule changes made in that
project reach every other project too. Projects keep byte-identical copies in
`.claude/rules/`, because Claude Code auto-loads only files that are actually
there. A copy is changed by editing the library and re-copying, never in place.
`testing.md` coverage moves from `[PREFER]` to `[MUST-UNLESS]` with an enforced
threshold, and tests are split into `unit/`, `integration/` and `e2e/`.

## 2026-08-07 — Repurposed from personal repo to public open-source project

The repo was a personal rules library; it is being published as a general-purpose
system so that "how do you work with AI?" has a concrete answer. Consequences:
`README.md` now leads with the rule-level model rather than the directory tree,
personal references are scrubbed from prose (`DECISIONS.md` keeps its historical
entries — it is append-only), `CONTRIBUTING.md` and `SECURITY.md` define the scope
for outside contributors, and `LICENSE` carries a real copyright holder.

Two files were purged from git history rather than merely deleted, because deletion
leaves them permanently clonable once the repo is public:
`docs/Google_harness_article.pdf` (a third-party article — 9.97 MB of a 10 MB repo,
redistributing it under our MIT licence is not ours to do) and `HARNESS_AUDIT.md`
(personal workflow telemetry: prompt counts, private project names, home paths).
Done while the repo was still private with zero forks, when a history rewrite costs
nothing; the audit's *conclusions* already live in the entries below, so only the
raw personal data is lost.

`.idea/` moved from `.gitignore` to `.git/info/exclude` per this repo's own rule that
personal tool files stay out of shared ignore files. Note the trade-off: that file is
local-only, so contributors do not inherit it.

Two further paths were purged in later passes, once a full audit of every blob ever in
the history was run rather than only the staged diff: `startpage/` (a bookmark page
whose weather link pinned a home city) and `archive/` (a VS Code config containing an
absolute `/Users/…` path). The history was rewritten three times in total.

The commit author email was deliberately **not** rewritten. It is already published on
the GitHub profile, so rewriting 26 commits to hide it would have achieved nothing;
should that profile field ever be cleared, the history would need the same treatment
to make it count.

A force-push does not remove the old objects from GitHub — they stay fetchable by SHA,
and Support only intervenes for sensitive data that credential rotation cannot fix.
The repo was therefore deleted and re-created from the rewritten history. That is what
actually removed them, verified anonymously from outside afterwards.

The GitHub repo was renamed `templates` → `developer-os` to match what the README now
describes. The delete-and-recreate also dropped the redirect from the old name, so any
external link predating this entry is dead rather than forwarded.

Consequence of the rewrite: every commit SHA below this entry is from the pre-rewrite
history and no longer resolves (`326bc37`, `55f3aa1`, `7cf5d46`, and the `git show`
invocation that depends on one). Those entries are left untouched — this log is
append-only — but read their SHAs as historical labels, not as fetchable objects.

The Google whitepaper that informed `docs/harness-guide.md` is now cited as a link
rather than vendored as a PDF. Attribution is not a licence: linking is what makes the
reference legitimate, and a disclaimer next to a redistributed copy would not have.

## 2026-07-04 — Junie → Claude Code migration complete, PLAN.md removed

The migration plan is fully executed: generate/audit split runs on two Claude Code
sessions (clean terminal + explicit `--model` for audits, same-session gate in the
`audit-diff` skill), context7 kept, Snyk left at IDE/CLI level, Junie-specific config
removed (`.junie/`, `~/.junie/AGENTS.md` — commit `326bc37`). PLAN.md is deleted in
this commit; the full plan with the reasoning behind the context7/Snyk/generate-audit
decisions is preserved at `git show 7cf5d46:PLAN.md`.

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
  (personal repos, Startpages, `archive/`, a stale "Recent Discoveries" section, and Clean
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
