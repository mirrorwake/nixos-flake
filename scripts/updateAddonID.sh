#!/bin/bash
set -euo pipefail

mkdir -p .nix-cache/extensions
tmp_output=$(mktemp)

declare -A EXTENSIONS=(
  [yomitan]="https://addons.mozilla.org/firefox/downloads/latest/yomitan/latest.xpi"
  [ublock]="https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
  [clearurls]="https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi"
  [protonPass]="https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi"
  [protonVPN]="https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi"
  [RES]="https://addons.mozilla.org/en-US/firefox/downloads/latest/reddit-enhancement-suite/latest.xpi"
  # Add more here
)

echo "{" >"$tmp_output"
for name in "${!EXTENSIONS[@]}"; do
  url="${EXTENSIONS[$name]}"
  file=".nix-cache/extensions/${name}.xpi"

  echo "Fetching $name..."

  if ! curl -fsSL "$url" -o "$file"; then
    echo "❌ Failed to download $name from $url" >&2
    rm "$tmp_output"
    exit 1
  fi

  id=$(unzip -p "$file" manifest.json | jq -r '.browser_specific_settings.gecko.id' || true)

  if [[ -z "$id" || "$id" == "null" ]]; then
    echo "❌ Failed to extract extension ID for $name" >&2
    rm "$tmp_output"
    exit 1
  fi

  echo "  ${name} = \"${id}\";" >>"$tmp_output"
done
echo "}" >>"$tmp_output"

# Only overwrite if everything succeeded
mv "$tmp_output" modules/firefox/extension-ids.nix
echo "✅ extension-ids.nix updated successfully."
