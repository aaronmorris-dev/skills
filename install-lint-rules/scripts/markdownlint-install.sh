#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: markdownlint-install.sh [target] [--force]

Copy the central markdownlint-cli2 policy into a project and install its exact
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
manifest="$target/package.json"
source_config="$root/markdownlint/.markdownlint-cli2.cjs"
target_config="$target/.markdownlint-cli2.cjs"
[[ -f "$root/versions.env" && -f "$source_config" ]] || {
  echo "error: central Markdown configuration not found under $root" >&2
  exit 2
}
[[ -f "$manifest" ]] || { echo "error: $manifest is required; ask before creating it" >&2; exit 2; }
. "$root/versions.env"

package_manager=$(node -e 'const p=require(process.argv[1]); process.stdout.write((p.packageManager||"").split("@")[0])' "$manifest")
if [[ -z "$package_manager" ]]; then
  managers=()
  [[ -f "$target/bun.lock" || -f "$target/bun.lockb" ]] && managers+=(bun)
  [[ -f "$target/package-lock.json" ]] && managers+=(npm)
  [[ -f "$target/pnpm-lock.yaml" ]] && managers+=(pnpm)
  [[ -f "$target/yarn.lock" ]] && managers+=(yarn)
  (( ${#managers[@]} == 1 )) || { echo "error: cannot uniquely detect Bun, npm, pnpm, or Yarn" >&2; exit 2; }
  package_manager=${managers[0]}
fi

case "$package_manager" in
  bun) (cd "$target" && bun add --dev --exact "markdownlint-cli2@$MARKDOWNLINT_CLI2_VERSION") ;;
  npm) (cd "$target" && npm install --save-dev --save-exact "markdownlint-cli2@$MARKDOWNLINT_CLI2_VERSION") ;;
  pnpm) (cd "$target" && pnpm add --save-dev --save-exact "markdownlint-cli2@$MARKDOWNLINT_CLI2_VERSION") ;;
  yarn) (cd "$target" && yarn add --dev --exact "markdownlint-cli2@$MARKDOWNLINT_CLI2_VERSION") ;;
  *) echo "error: unsupported package manager: $package_manager" >&2; exit 2 ;;
esac

if [[ -f "$target_config" && $force -eq 0 ]]; then
  echo "merge_required: $target_config"
  echo "source: $source_config"
else
  cp "$source_config" "$target_config"
  echo "config: $target_config"
fi

echo "package_manager: $package_manager"
echo "command: markdownlint-cli2"
