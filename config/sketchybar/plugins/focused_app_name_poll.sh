#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
[[ -x "$AEROSPACE_BIN" ]] || AEROSPACE_BIN="/usr/local/bin/aerospace"

APP="$("$AEROSPACE_BIN" list-windows --focused --format "%{app-name}" 2>/dev/null || true)"

# Fallback if no focused window (desktop etc.)
if [[ -z "${APP:-}" ]]; then
  APP="Desktop"
fi

sketchybar --set "$NAME" label="$APP"

