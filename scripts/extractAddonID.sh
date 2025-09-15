#!/bin/bash

# usage: ./extractAddonID.sh extension.xpi

set -euo pipefail

file="${1:?Usage: $0 extension.xpi}"

tmpdir=$(mktemp -d)
unzip -qq "$file" manifest.json -d "$tmpdir"

if command -v jq >/dev/null; then
  jq -r '.browser_specific_settings.gecko.id' "$tmpdir/manifest.json"
else
  grep -o '"id": *"[^"]*"' "$tmpdir/manifest.json"
fi

rm -r "$tmpdir"
