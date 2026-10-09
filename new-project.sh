#!/usr/bin/env bash
# Roll out project-template/ + selected rules-library/ modules into a new (or
# existing) repo. Safe to re-run: never overwrites files already in the target.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/project-template"
RULES_LIBRARY="$SCRIPT_DIR/rules-library"
DEFAULT_MODULES=(python-core testing documentation)

usage() {
  cat <<'EOF'
Usage: ./new-project.sh <target-dir> [module ...]
       ./new-project.sh --list

  <target-dir>   Directory to roll the template into (created if missing).
  [module ...]   Rule modules (basenames, without .md) to copy from
                 rules-library/ into <target-dir>/.claude/rules/.
                 Default: python-core testing documentation

  --list         Print available modules from rules-library/ and exit.
EOF
}

list_modules() {
  for f in "$RULES_LIBRARY"/*.md; do
    base="$(basename "$f" .md)"
    [[ "$base" == "_LEVELS" ]] && continue
    echo "$base"
  done
}

if [[ $# -eq 0 ]]; then
  usage
  exit 1
fi

if [[ "$1" == "--list" ]]; then
  list_modules
  exit 0
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

TARGET_DIR="$1"
shift
MODULES=("$@")
if [[ ${#MODULES[@]} -eq 0 ]]; then
  MODULES=("${DEFAULT_MODULES[@]}")
fi

mkdir -p "$TARGET_DIR"

# Copy project-template/. into TARGET_DIR without clobbering existing files.
# Skip editor/tool junk that isn't part of the template proper.
while IFS= read -r -d '' src; do
  rel="${src#"$TEMPLATE_DIR"/}"
  dest="$TARGET_DIR/$rel"
  if [[ -e "$dest" ]]; then
    echo "warning: $rel already exists in target — skipping" >&2
    continue
  fi
  # A new ruff.toml would silently override an existing ruff config rather
  # than add to it — see rules-library/inherited-codebases.md.
  if [[ "$rel" == "ruff.toml" ]] && { [[ -e "$TARGET_DIR/.ruff.toml" ]] ||
      grep -qs '^\[tool\.ruff' "$TARGET_DIR/pyproject.toml"; }; then
    echo "warning: target already configures ruff — skipping ruff.toml" >&2
    continue
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
done < <(find "$TEMPLATE_DIR" -type f \
  -not -name ".DS_Store" \
  -not -path "*/.ruff_cache/*" \
  -not -path "*/.mypy_cache/*" \
  -not -path "*/__pycache__/*" \
  -print0)

mkdir -p "$TARGET_DIR/.claude/rules"

# Always ship _LEVELS.md, then the requested modules.
for module in "_LEVELS" "${MODULES[@]}"; do
  src="$RULES_LIBRARY/$module.md"
  if [[ ! -f "$src" ]]; then
    echo "warning: module '$module' not found in rules-library/ — skipping" >&2
    continue
  fi
  dest="$TARGET_DIR/.claude/rules/$module.md"
  if [[ -e "$dest" ]]; then
    echo "warning: .claude/rules/$module.md already exists in target — skipping" >&2
    continue
  fi
  cp "$src" "$dest"
done

rm -f "$TARGET_DIR/.claude/rules/_PUT_MODULES_HERE.txt"

if [[ ! -d "$TARGET_DIR/.git" ]]; then
  git -C "$TARGET_DIR" init -q
fi

cat <<EOF

Done. Next steps in $TARGET_DIR:
  1. Fill in the TODOs in CLAUDE.md (project description, active modules, commands).
  2. Review .github/workflows/ci.yml — add service containers if the project needs them.
  3. Review .claude/settings.json — permissions.allow/deny for this project.
  4. cd $TARGET_DIR && make install && make install-hooks
EOF
