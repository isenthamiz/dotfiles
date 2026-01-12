#!/usr/bin/env bash
set -euo pipefail
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
[[ -x "$AEROSPACE_BIN" ]] || AEROSPACE_BIN="/usr/local/bin/aerospace"

LAYOUT="$("$AEROSPACE_BIN" list-windows --focused --format "%{window-parent-container-layout}" 2>/dev/null || true)"

case "$LAYOUT" in
  floating)   OUT="󰉋 Float" ;;
  *accordion*) OUT="󰘖 Acc" ;;
  *tiles*)    OUT="󰆍 Tile" ;;
  "")         OUT="—" ;;
  *)          OUT="$LAYOUT" ;;
esac

sketchybar --set "$NAME" label="$OUT"

