#!/usr/bin/env bash
set -euo pipefail

SID="$1"

# PROOF this script is being invoked by sketchybar:
echo "$(date '+%F %T') RUN name=$NAME sid=$SID sender=$SENDER" >> /tmp/sketchybar_space_items.log

# Get focused workspaces (one per monitor possible)
FOCUSED="$(/opt/homebrew/bin/aerospace list-workspaces --focused 2>/dev/null || true)"

is_focused=false
while read -r ws; do
  [[ -z "$ws" ]] && continue
  if [[ "$ws" == "$SID" ]]; then
    is_focused=true
    break
  fi
done <<< "$FOCUSED"

if [[ "$is_focused" == true ]]; then
  sketchybar --set "$NAME" \
    icon="●" \
    icon.font="$FONT:Bold:18.0" \
    icon.color="$ACCENT" \
    background.drawing=on \
    background.color="$PILL_BG_ACTIVE" \
    background.corner_radius=10 \
    background.height=22
else
  sketchybar --set "$NAME" \
    icon="•" \
    icon.font="$FONT:Bold:14.0" \
    icon.color="$FAINT" \
    background.drawing=off
fi

