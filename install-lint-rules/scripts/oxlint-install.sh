#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: oxlint-install.sh [target] [--force] [--effect|--no-effect]

Copy the central Oxlint policy into a project and install exact dependencies.
Existing configuration is preserved unless --force is given.

Environment:
  LINT_CONFIG_ROOT  Central lint checkout (default: ~/.config/lint)
EOF
}

target=.
target_set=0
force=0
effect=auto
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) force=1 ;;
    --effect) effect=1 ;;
    --no-effect) effect=0 ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "error: unexpected option: $1" >&2; exit 2 ;;
    *) (( target_set == 0 )) || { echo "error: unexpected argument: $1" >&2; exit 2; }; target=$1; target_set=1 ;;
  esac
  shift
done

target=$(cd -- "$target" && pwd)
root=${LINT_CONFIG_ROOT:-${XDG_CONFIG_HOME:-$HOME/.config}/lint}
manifest="$target/package.json"
[[ -f "$root/versions.env" && -f "$root/oxlint/oxlint.config.ts" ]] || {
  echo "error: central Oxlint configuration not found under $root" >&2
  exit 2
}
[[ -f "$manifest" ]] || { echo "error: $manifest is required; ask before creating it" >&2; exit 2; }
. "$root/versions.env"

configs=()
[[ -f "$target/.oxlintrc.json" ]] && configs+=("$target/.oxlintrc.json")
[[ -f "$target/oxlint.config.ts" ]] && configs+=("$target/oxlint.config.ts")
(( ${#configs[@]} <= 1 )) || { echo "error: both .oxlintrc.json and oxlint.config.ts exist; choose one" >&2; exit 2; }

if [[ "$effect" == auto ]]; then
  if node -e 'const p=require(process.argv[1]); process.exit([p.dependencies,p.devDependencies,p.optionalDependencies,p.peerDependencies].some(x=>x?.effect) ? 0 : 1)' "$manifest"; then
    effect=1
  else
    effect=0
  fi
fi

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
  bun) (cd "$target" && bun add --dev --exact "oxlint@$OXLINT_VERSION" "@oxlint/plugins@$OXLINT_VERSION") ;;
  npm) (cd "$target" && npm install --save-dev --save-exact "oxlint@$OXLINT_VERSION" "@oxlint/plugins@$OXLINT_VERSION") ;;
  pnpm) (cd "$target" && pnpm add --save-dev --save-exact "oxlint@$OXLINT_VERSION" "@oxlint/plugins@$OXLINT_VERSION") ;;
  yarn) (cd "$target" && yarn add --dev --exact "oxlint@$OXLINT_VERSION" "@oxlint/plugins@$OXLINT_VERSION") ;;
  *) echo "error: unsupported package manager: $package_manager" >&2; exit 2 ;;
esac

plugins="$target/plugins"
if [[ -e "$plugins" ]] && ! diff -qr "$root/oxlint/plugins" "$plugins" >/dev/null 2>&1; then
  if (( force )); then rm -rf "$plugins"; else echo "merge_required: $plugins"; fi
fi
[[ -e "$plugins" ]] || cp -R "$root/oxlint/plugins" "$plugins"

write_config() {
  if (( effect )); then
    cp "$root/oxlint/oxlint.config.ts" "$target/oxlint.base.config.ts"
    sed 's|"./oxlint.config.ts"|"./oxlint.base.config.ts"|' \
      "$root/oxlint/oxlint.effect.config.ts" > "$target/oxlint.config.ts"
  else
    cp "$root/oxlint/oxlint.config.ts" "$target/oxlint.config.ts"
    rm -f "$target/oxlint.base.config.ts"
  fi
}

if (( ${#configs[@]} == 1 && ! force )); then
  echo "merge_required: ${configs[0]}"
  echo "generic_source: $root/oxlint/oxlint.config.ts"
  (( effect )) && echo "effect_source: $root/oxlint/oxlint.effect.config.ts"
else
  (( force )) && rm -f "$target/.oxlintrc.json" "$target/oxlint.config.ts"
  write_config
  echo "config: $target/oxlint.config.ts"
fi

echo "package_manager: $package_manager"
echo "effect: $effect"
echo "command: oxlint ."
