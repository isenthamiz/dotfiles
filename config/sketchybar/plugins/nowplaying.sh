#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

LOG="/tmp/sketchybar_nowplaying.log"

# Get current track from Apple Music (returns empty if not playing / not running)
RAW="$(osascript 2>>"$LOG" <<'APPLESCRIPT'
try
  if application "Music" is running then
    tell application "Music"
      if player state is playing then
        set tName to name of current track
        set tArtist to artist of current track
        if tArtist is "" then
          return tName
        else
          return tArtist & " – " & tName
        end if
      else
        return ""
      end if
    end tell
  else
    return ""
  end if
on error errMsg number errNum
  return "ERR:" & errNum
end try
APPLESCRIPT
)"

RAW="$(echo "$RAW" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
echo "$(date '+%F %T') RAW=[$RAW]" >> "$LOG"

# If blocked by permissions or error
if [[ "$RAW" == ERR:* ]]; then
  sketchybar --set "$NAME" label="Music perms" icon.color="$ALERT"
  exit 0
fi

# If nothing playing
if [[ -z "$RAW" ]]; then
  sketchybar --set "$NAME" label="—" icon.color="$FAINT"
  exit 0
fi

# Marquee
WIN=26
TEXT="${RAW}     "

STATE="/tmp/sketchybar_nowplaying.offset"
OFF=0
[[ -f "$STATE" ]] && OFF="$(cat "$STATE" 2>/dev/null || echo 0)"

LEN=${#TEXT}
if (( LEN <= WIN )); then
  OUT="$RAW"
else
  (( OFF >= LEN )) && OFF=0
  OUT="${TEXT:OFF:WIN}"
  if (( ${#OUT} < WIN )); then
    OUT="${OUT}${TEXT:0:WIN-${#OUT}}"
  fi
  OFF=$((OFF + 1))
  echo "$OFF" > "$STATE"
fi

sketchybar --set "$NAME" label="$OUT" icon.color="$FG"

