#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: yamllint-install.sh [target] [--force]

Copy the central yamllint policy into a uv project and install the exact
dependency. Existing configuration is preserved unless --force is given.

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
source_config="$root/yamllint/.yamllint.yml"
target_config="$target/.yamllint.yml"
[[ -f "$root/versions.env" && -f "$source_config" ]] || {
  echo "error: central YAML configuration not found under $root" >&2
  exit 2
}
[[ -f "$manifest" ]] || { echo "error: $manifest is required; ask before creating it" >&2; exit 2; }
command -v uv >/dev/null || { echo "error: uv is required: https://docs.astral.sh/uv/" >&2; exit 127; }
. "$root/versions.env"

(cd "$target" && uv add --dev "yamllint==$YAMLLINT_VERSION")

if [[ -f "$target_config" && $force -eq 0 ]]; then
  echo "merge_required: $target_config"
  echo "source: $source_config"
else
  cp "$source_config" "$target_config"
  echo "config: $target_config"
fi

echo "command: uv run yamllint ."
