#!/usr/bin/env bash
set -euo pipefail
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

VOL="$(osascript -e 'output volume of (get volume settings)')"
sketchybar --set "$NAME" label="${VOL}%"

