#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

# Try switchaudio-osx first (fast)
DEV=""
if [[ -x /opt/homebrew/bin/SwitchAudioSource ]]; then
  DEV="$(/opt/homebrew/bin/SwitchAudioSource -c 2>/dev/null || true)"
elif [[ -x /usr/local/bin/SwitchAudioSource ]]; then
  DEV="$(/usr/local/bin/SwitchAudioSource -c 2>/dev/null || true)"
fi

# Fallback: parse system_profiler where "Default Output Device: Yes" is a flag inside a device block
if [[ -z "${DEV:-}" ]]; then
  DEV="$(/usr/sbin/system_profiler SPAudioDataType 2>/dev/null | awk '
    # Device header lines look like: "    MacBook Pro Speakers:"
    /^[[:space:]]{4}[^:]+:$/ {hdr=$0; gsub(/^[[:space:]]+/, "", hdr); gsub(/:$/, "", hdr)}
    /Default Output Device: Yes/ {print hdr; exit}
  ')"
fi

DEV="$(echo "${DEV:-}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

if [[ -z "$DEV" ]]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

# Icon selection by device type
ICON="󰍹"   # default speaker
case "$DEV" in
  # --- Apple built-in ---
  *MacBook*|*Built-in*|*Speakers*)
    ICON="󰍹" ;;                 # Apple icon
  # --- AirPods ---
  *AirPods*)
    ICON="󰋋" ;;                # AirPods icon
  # --- Bluetooth headphones (non-AirPods) ---
  *Bluetooth*|*Headphones*)
    ICON="󰋋" ;;                # Headphones icon
  # --- HDMI / external display ---
  *HDMI*|*Display*)
    ICON="󰍹" ;;                # Display icon
esac

# Optional: shorten noisy names
DEV_SHORT="$DEV"
DEV_SHORT="${DEV_SHORT/MacBook Pro /MacBook }"
DEV_SHORT="${DEV_SHORT/Headphones/HP}"

sketchybar --set "$NAME" \
  drawing=on \
  icon="$ICON" \
  icon.color="$FG" \
  label="$DEV_SHORT" \
  label.drawing=on \
  label.color="$FG"

