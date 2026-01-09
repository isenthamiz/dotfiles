#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
[[ -x "$AEROSPACE_BIN" ]] || AEROSPACE_BIN="/usr/local/bin/aerospace"

WORKSPACES="$("$AEROSPACE_BIN" list-workspaces --all)"
FOCUSED_WS="$("$AEROSPACE_BIN" list-workspaces --focused 2>/dev/null || true)"

is_focused() {
  local sid="$1"
  while read -r ws; do
    [[ -z "${ws:-}" ]] && continue
    [[ "$ws" == "$sid" ]] && return 0
  done <<< "$FOCUSED_WS"
  return 1
}

for sid in $WORKSPACES; do
  count="$("$AEROSPACE_BIN" list-windows --workspace "$sid" 2>/dev/null | wc -l | tr -d ' ')"

  if is_focused "$sid"; then
    sketchybar --set "space.$sid" \
      label.color="$FG" \
      label.font="$FONT:Bold:18.0" \
      background.drawing=on \
      background.color="$PILL_BG_ACTIVE" \
      background.corner_radius=12 \
      background.height=26 \
      label.padding_left=26 \
      label.padding_right=26 
  else
    sketchybar --set "space.$sid" \
      label.color="$FG" \
      label.font="$FONT:Bold:14.0" \
      background.drawing=off \
      label.padding_left=12 \
      label.padding_right=12

  fi


#  if is_focused "$sid"; then
#    # Focused: accent label + brighter background
#    sketchybar --set "space.$sid" \
#      label.color="$ACCENT" \
#      background.color="$PILL_BG_ACTIVE" \
#      background.drawing=on \
#      background.corner_radius=9 \
#      background.height=24 \
#      background.width=24
#      padding_left=12 \
#      padding_right=12
#  else
#    if [[ "${count:-0}" -gt 0 ]]; then
#      # Occupied: dim label + normal pill bg
#      sketchybar --set "space.$sid" \
#        label.color="$DIM" \
#        background.color="$PILL_BG" \
#        background.drawing=on \
#        background.corner_radius=9 \
#        background.height=22 \
#        padding_left=10 \
#        padding_right=10
#    else
#      # Empty: faint label + slightly darker/transparent bg
#      sketchybar --set "space.$sid" \
#        label.color="$FAINT" \
#        background.color="$PILL_BG" \
#        background.drawing=on \
#        background.corner_radius=9 \
#        background.height=22 \
#        padding_left=10 \
#        padding_right=10
#    fi
#  fi
done

