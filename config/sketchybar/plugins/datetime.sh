#!/usr/bin/env bash
set -euo pipefail
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

sketchybar --set "$NAME" label="$(date '+%a %d %b %H:%M')"

