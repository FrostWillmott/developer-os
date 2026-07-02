#!/bin/bash
# PostToolUse hook: lint the just-edited file. Advisory only — never blocks
# the session, even if jq/uv are missing or the project has no uv env yet.
command -v jq >/dev/null || exit 0
command -v uv >/dev/null || exit 0

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [[ -n "$FILE" && "$FILE" == *.py ]]; then
  uv run ruff check --fix "$FILE" 2>&1 | head -10
fi

exit 0
