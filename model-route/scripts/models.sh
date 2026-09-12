#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: models.sh [catalog|models|providers] [options]

Fetch and cache a models.dev JSON endpoint, then print its contents.
The default endpoint is catalog (canonical models plus provider offerings).

Examples:
  models.sh
  models.sh models | jq '.[] | select(.reasoning)'
  models.sh providers --force-update
  models.sh catalog --path-only

Options:
  --path-only                 Print only the cached JSON path.
  --force-update              Download even when the cache is fresh.
  --update-interval <secs>    Minimum seconds between downloads (default: 3600).
  -h, --help                  Show this help.

Environment:
  MODELS_DEV_CACHE_ROOT       Cache directory (default: ~/.cache/models.dev)
  MODELS_DEV_UPDATE_INTERVAL  Default update interval in seconds
EOF
}

endpoint="catalog"
endpoint_set=0
path_only=0
force_update=0
update_interval="${MODELS_DEV_UPDATE_INTERVAL:-3600}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    catalog|models|providers)
      if (( endpoint_set )); then
        echo "error: unexpected argument: $1" >&2
        exit 2
      fi
      endpoint="$1"
      endpoint_set=1
      shift
      ;;
    --path-only)
      path_only=1
      shift
      ;;
    --force-update)
      force_update=1
      shift
      ;;
    --update-interval)
      if [[ $# -lt 2 ]]; then
        echo "error: --update-interval expects a value" >&2
        exit 2
      fi
      update_interval="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unexpected argument: $1" >&2
      exit 2
      ;;
  esac
done

if ! [[ "$update_interval" =~ ^[0-9]+$ ]]; then
  echo "error: update interval must be a non-negative integer" >&2
  exit 2
fi

case "$endpoint" in
  providers) api_endpoint="api" ;;
  *) api_endpoint="$endpoint" ;;
esac

cache_root="${MODELS_DEV_CACHE_ROOT:-$HOME/.cache/models.dev}"
cache_file="$cache_root/$endpoint.json"
now_epoch="$(date +%s)"
needs_update=1

if [[ -f "$cache_file" && "$force_update" -eq 0 ]]; then
  modified_epoch="$(stat -f %m "$cache_file" 2>/dev/null || stat -c %Y "$cache_file" 2>/dev/null || echo 0)"
  if [[ "$modified_epoch" =~ ^[0-9]+$ ]] && (( now_epoch - modified_epoch < update_interval )); then
    needs_update=0
  fi
fi

if (( needs_update )); then
  mkdir -p "$cache_root"
  tmp_file="$cache_file.tmp.$$"
  trap 'rm -f "$tmp_file"' EXIT
  curl -fsSL --retry 2 "https://models.dev/$api_endpoint.json" -o "$tmp_file"
  mv "$tmp_file" "$cache_file"
  trap - EXIT
fi

if (( path_only )); then
  printf '%s\n' "$cache_file"
else
  cat "$cache_file"
fi
