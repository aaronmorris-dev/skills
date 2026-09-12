#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: catalog.sh

List cached librarian checkout paths, one per line.

Options:
  -h, --help                  Show this help.

Environment:
  LIBRARIAN_CACHE_ROOT        Override cache root (default: ~/.cache/checkouts)
EOF
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
  "") ;;
  *)
    echo "error: unexpected argument: $1" >&2
    exit 2
    ;;
esac

cache_root="${LIBRARIAN_CACHE_ROOT:-$HOME/.cache/checkouts}"
[[ -d "$cache_root" ]] || exit 0

find "$cache_root" -mindepth 3 -type d -name .git -prune -exec dirname {} \; | LC_ALL=C sort
