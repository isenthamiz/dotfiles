#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

# Your Wi-Fi interface is en0 (confirmed)
SSID="$(/usr/sbin/ipconfig getsummary en0 2>/dev/null | awk -F' : ' '/^[[:space:]]*SSID[[:space:]]*:/ {print $2; exit}')"

if [[ -z "${SSID:-}" ]]; then
  sketchybar --set "$NAME" label="" icon.color="$ALERT"
else
  sketchybar --set "$NAME" label="" icon.color="$FG"
fi

