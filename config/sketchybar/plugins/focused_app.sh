#!/usr/bin/env bash
set -euo pipefail

APP="${APP_NAME:-}"

# Map app name -> nerd font icon
# (Add your own apps here)
case "$APP" in
  "Code"|"Visual Studio Code") ICON="" ;;          # nf-dev-visualstudio
  "Ghostty")                   ICON="" ;;          # terminal-ish
  "Terminal"|"iTerm2"|"kitty") ICON="" ;;          # nf-fa-terminal
  "Safari")                    ICON="" ;;          # nf-fa-safari (sometimes)
  "Google Chrome")             ICON="" ;;          # nf-fa-chrome
  "Firefox")                   ICON="" ;;          # nf-fa-firefox
  "Finder")                    ICON="" ;;          # nf-fa-folder_open
  "Slack")                     ICON="" ;;          # nf-fa-slack
  "Spotify")                   ICON="" ;;          # nf-fa-spotify
  "")                          ICON="" ;;          # unknown / no focused window
  *)                           ICON="󰘔" ;;          # generic app glyph (varies by font)
esac

sketchybar --set "$NAME" icon="$ICON"

