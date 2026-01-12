#!/usr/bin/env bash
set -euo pipefail
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

# Camera heuristic
CAM_ON=0
if /usr/sbin/lsof -nP 2>/dev/null | /usr/bin/grep -qiE "AppleCamera|VDCAssistant|AppleCameraAssistant|USBVDC"; then
  CAM_ON=1
fi

# Mic heuristic (best-effort)
MIC_ON=0
# Many apps that record will have CoreAudio input open; this is imperfect but useful.
if /usr/sbin/lsof -nP 2>/dev/null | /usr/bin/grep -qiE "coreaudio|AudioCapture|AppleHDA.*Input|IOAudio"; then
  MIC_ON=1
fi

if [[ "$CAM_ON" -eq 1 && "$MIC_ON" -eq 1 ]]; then
  sketchybar --set "$NAME" drawing=on icon="󰍬" icon.color="$ALERT"
elif [[ "$CAM_ON" -eq 1 ]]; then
  sketchybar --set "$NAME" drawing=on icon="󰄀" icon.color="$ALERT"
elif [[ "$MIC_ON" -eq 1 ]]; then
  sketchybar --set "$NAME" drawing=on icon="󰍬" icon.color="$ALERT"
else
  sketchybar --set "$NAME" drawing=off
fi

