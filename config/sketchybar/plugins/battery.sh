#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

INFO="$(pmset -g batt | tail -n 1)"
PCT="$(echo "$INFO" | grep -o '[0-9]\+%' | head -n1)"
NUM="${PCT%\%}"
CHARGING="$(echo "$INFO" | grep -qi 'charging' && echo yes || echo no)"

if [[ "$NUM" -le 15 ]]; then ICON=""
elif [[ "$NUM" -le 35 ]]; then ICON=""
elif [[ "$NUM" -le 60 ]]; then ICON=""
elif [[ "$NUM" -le 85 ]]; then ICON=""
else ICON=""
fi

if [[ "$CHARGING" == "yes" ]]; then
  sketchybar --set "$NAME" icon="$ICON" label="$PCT" icon.color="$ACCENT_2"
else
  sketchybar --set "$NAME" icon="$ICON" label="$PCT" icon.color="$FG"
fi

