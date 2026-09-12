#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
for script in "$root"/*-install.sh; do
  bash -n "$script"
  "$script" --help >/dev/null
done

echo "Verified lint installer syntax and help."
