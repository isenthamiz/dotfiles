#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

STATE="/tmp/sketchybar_nowplaying_fade.state"

FADE_STEPS=0     # seconds to fade out/in
HOLD_STEPS=2     # seconds to hold each page

# phase step page hold last_key
phase="hold"; step=0; page=0; hold=0; last_key=""
if [[ -f "$STATE" ]]; then
  read -r phase step page hold last_key < "$STATE" || true
fi

RAW="$(osascript 2>/dev/null <<'APPLESCRIPT'
try
  if application "Music" is running then
    tell application "Music"
      if player state is playing then
        set tName to name of current track
        set tArtist to artist of current track
        set tAlbum to album of current track
        if tArtist is "" then set tArtist to "Unknown Artist"
        if tAlbum is "" then set tAlbum to "Unknown Album"
        -- IMPORTANT: correct delimiter concatenation
        return tArtist & "|||" & tName & "|||" & tAlbum
      else
        return ""
      end if
    end tell
  else
    return ""
  end if
on error
  return ""
end try
APPLESCRIPT
)"

RAW="$(echo "$RAW" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

if [[ -z "${RAW:-}" ]]; then
  sketchybar --set "$NAME" label="—" icon.color="$FAINT" label.color="$FAINT"
  echo "hold 0 0 0 -" > "$STATE"
  exit 0
fi

ARTIST="$(echo "$RAW" | awk -F'\\|\\|\\|' '{print $1}')"
TITLE="$(echo "$RAW"  | awk -F'\\|\\|\\|' '{print $2}')"
ALBUM="$(echo "$RAW"  | awk -F'\\|\\|\\|' '{print $3}')"

# Track key so we can reset cycle when song changes
key="${ARTIST}__${TITLE}__${ALBUM}"
if [[ "$key" != "$last_key" ]]; then
  phase="hold"; step=0; page=0; hold=0
  last_key="$key"
fi

PAGE0="${ARTIST} – ${TITLE}"
PAGE1="Album: ${ALBUM}"

TEXT="$PAGE0"
if [[ "$page" == "1" ]]; then
  TEXT="$PAGE1"
fi

# Fade alpha (255 -> 0 -> 255)
alpha=255
if [[ "$phase" == "fadeout" ]]; then
  alpha=$(( 255 - (255 * step / FADE_STEPS) ))
elif [[ "$phase" == "fadein" ]]; then
  alpha=$(( 255 * step / FADE_STEPS ))
fi

# Apply alpha to FG color (0xAARRGGBB)
fg_hex="${FG#0x}"
rrggbb="${fg_hex:2:6}"
printf -v aa "%02x" "$alpha"
LABEL_COLOR="0x${aa}${rrggbb}"

sketchybar --set "$NAME" icon.color="$FG" label="$TEXT" label.color="$LABEL_COLOR"

# Advance state machine
case "$phase" in
  hold)
    hold=$((hold + 1))
    if (( hold >= HOLD_STEPS )); then
      phase="fadeout"; step=0; hold=0
    fi
    ;;
  fadeout)
    step=$((step + 1))
    if (( step >= FADE_STEPS )); then
      page=$((1 - page))
      phase="fadein"; step=0
    fi
    ;;
  fadein)
    step=$((step + 1))
    if (( step >= FADE_STEPS )); then
      phase="hold"; step=0; hold=0
    fi
    ;;
esac

echo "$phase $step $page $hold $last_key" > "$STATE"

