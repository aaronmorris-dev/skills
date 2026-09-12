#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ruff-install.sh [target] [--force]

Copy the central Ruff policy into a uv project and install the exact dependency.
Existing configuration is preserved unless --force is given. pyproject.toml is
never overwritten; its Ruff tables must be merged by the calling agent.

Environment:
  LINT_CONFIG_ROOT  Central lint checkout (default: ~/.config/lint)
EOF
}

target=.
target_set=0
force=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) force=1 ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "error: unexpected option: $1" >&2; exit 2 ;;
    *) (( target_set == 0 )) || { echo "error: unexpected argument: $1" >&2; exit 2; }; target=$1; target_set=1 ;;
  esac
  shift
done

target=$(cd -- "$target" && pwd)
root=${LINT_CONFIG_ROOT:-${XDG_CONFIG_HOME:-$HOME/.config}/lint}
manifest="$target/pyproject.toml"
source_config="$root/ruff/ruff.toml"
[[ -f "$root/versions.env" && -f "$source_config" ]] || {
  echo "error: central Ruff configuration not found under $root" >&2
  exit 2
}
[[ -f "$manifest" ]] || { echo "error: $manifest is required; ask before creating it" >&2; exit 2; }
command -v uv >/dev/null || { echo "error: uv is required: https://docs.astral.sh/uv/" >&2; exit 127; }
. "$root/versions.env"

configs=()
[[ -f "$target/ruff.toml" ]] && configs+=("$target/ruff.toml")
[[ -f "$target/.ruff.toml" ]] && configs+=("$target/.ruff.toml")
grep -Eq '^\[tool\.ruff(\.|\])' "$manifest" && configs+=("$manifest")
(( ${#configs[@]} <= 1 )) || { echo "error: multiple Ruff configurations exist; choose one" >&2; exit 2; }

(cd "$target" && uv add --dev "ruff==$RUFF_VERSION")

if (( ${#configs[@]} == 0 )); then
  echo "merge_required: $manifest"
  echo "source: $source_config"
elif [[ "${configs[0]}" == "$manifest" ]]; then
  echo "merge_required: $manifest"
  echo "source: $source_config"
elif (( force )); then
  cp "$source_config" "${configs[0]}"
  echo "config: ${configs[0]}"
else
  echo "merge_required: ${configs[0]}"
  echo "source: $source_config"
fi

echo "command: uv run ruff check ."
echo "format_command: uv run ruff format --check ."
