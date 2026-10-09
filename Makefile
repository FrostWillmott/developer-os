SHELLCHECK := uvx --from shellcheck-py==0.11.0.1 shellcheck
ACTIONLINT := uvx --from actionlint-py==1.7.12.25 actionlint

.PHONY: check lint-sh lint-ci smoke

check: lint-sh lint-ci smoke

lint-sh:
	$(SHELLCHECK) new-project.sh scripts/*.sh project-template/.claude/hooks/*.sh

# actionlint only discovers .github/workflows at the repo root, so the
# template's workflow is passed explicitly.
lint-ci:
	$(ACTIONLINT) .github/workflows/*.yml project-template/.github/workflows/*.yml

smoke:
	scripts/smoke-test.sh
