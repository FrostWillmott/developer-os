#!/usr/bin/env bash
# Smoke-test new-project.sh against throwaway targets.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

# --list matches the modules on disk.
expected="$(find "$ROOT/rules-library" -maxdepth 1 -name '*.md' ! -name '_LEVELS.md' \
  -exec basename {} .md \; | sort)"
actual="$("$ROOT/new-project.sh" --list | sort)"
[[ "$expected" == "$actual" ]] || fail "--list differs from rules-library/"

# Every module is listed in the README module table.
while IFS= read -r module; do
  grep -q "^| \`$module.md\` |" "$ROOT/README.md" || fail "$module.md missing from README module table"
done <<<"$expected"

# Fresh target: template copied, _LEVELS plus requested modules, placeholder gone.
fresh="$WORK/fresh"
"$ROOT/new-project.sh" "$fresh" python-core testing >/dev/null
[[ -f "$fresh/ruff.toml" ]] || fail "fresh target has no ruff.toml"
[[ -f "$fresh/Makefile" ]] || fail "fresh target has no Makefile"
[[ -d "$fresh/.git" ]] || fail "fresh target is not a git repo"
rules="$(find "$fresh/.claude/rules" -type f -exec basename {} \; | sort | tr '\n' ' ')"
[[ "$rules" == "_LEVELS.md python-core.md testing.md " ]] || fail "unexpected rules: $rules"

# Target that already configures ruff in pyproject.toml gets no ruff.toml.
inherited="$WORK/inherited"
mkdir -p "$inherited"
printf '[tool.ruff]\nline-length = 100\n' >"$inherited/pyproject.toml"
"$ROOT/new-project.sh" "$inherited" >/dev/null 2>&1
[[ ! -e "$inherited/ruff.toml" ]] || fail "ruff.toml added next to [tool.ruff]"

# Re-running never overwrites an existing file.
echo "local edit" >"$fresh/CLAUDE.md"
"$ROOT/new-project.sh" "$fresh" python-core >/dev/null 2>&1
[[ "$(cat "$fresh/CLAUDE.md")" == "local edit" ]] || fail "re-run overwrote CLAUDE.md"

echo "smoke test passed"
