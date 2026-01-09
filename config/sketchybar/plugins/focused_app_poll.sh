#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

AEROSPACE_BIN="/opt/homebrew/bin/aerospace"
[[ -x "$AEROSPACE_BIN" ]] || AEROSPACE_BIN="/usr/local/bin/aerospace"

APP="$("$AEROSPACE_BIN" list-windows --focused --format "%{app-name}" 2>/dev/null || true)"

case "$APP" in
  # --- Code / Dev ---
  "Code"|"Visual Studio Code")           ICON="" ;;   # vscode
  "Xcode")                               ICON="" ;;
  "IntelliJ IDEA"|"IntelliJ IDEA CE")    ICON="" ;;
  "WebStorm")                            ICON="" ;;
  "PyCharm")                             ICON="" ;;
  "Android Studio")                     ICON="" ;;
  "Neovim"|"MacVim")                    ICON="" ;;
  "Sublime Text")                       ICON="" ;;

  # --- Terminals ---
  "Ghostty")        ICON="󰊠" ;;   # 👻 Ghostty (distinct)
  "iTerm2")         ICON="" ;;   # iTerm
  "Terminal")       ICON="" ;;   # macOS Terminal
  "kitty")          ICON="󰄛" ;;   # kitty
  "Alacritty")      ICON="󰹑" ;;   # alacritty

  # --- Browsers ---
  "Safari")                              ICON="" ;;
  "Google Chrome")                       ICON="" ;;
  "Chromium")                            ICON="" ;;
  "Firefox")                             ICON="" ;;
  "Brave Browser")                       ICON="󰖟" ;;
  "Microsoft Edge")                     ICON="󰇩" ;;
  "Arc")                                 ICON="󰞍" ;;

  # --- File / System ---
  "Finder")                              ICON="" ;;
  "System Settings")                    ICON="" ;;
  "System Preferences")                 ICON="" ;;
  "Activity Monitor")                   ICON="󰍛" ;;
  "Disk Utility")                       ICON="󰋊" ;;
  "Preview")                             ICON="" ;;
  "Spotlight")                          ICON="󰍉" ;;

  # --- Communication ---
  "Slack")                               ICON="" ;;
  "Discord")                             ICON="󰙯" ;;
  "Telegram")                            ICON="" ;;
  "Messages")                           ICON="󰍦" ;;
  "Mail")                               ICON="󰇮" ;;
  "Microsoft Teams")                    ICON="󰊻" ;;
  "Zoom")                               ICON="󰕧" ;;

  # --- Media / Audio / Video ---
  "Spotify")                            ICON="" ;;
  "Music")                              ICON="󰎆" ;;
  "TV")                                 ICON="󰎁" ;;
  "VLC")                                ICON="󰕼" ;;
  "QuickTime Player")                  ICON="󰕼" ;;

  # --- Productivity ---
  "Notion")                             ICON="󰎚" ;;
  "Obsidian")                           ICON="󱞁" ;;
  "Notes")                              ICON="󰎞" ;;
  "Reminders")                         ICON="󰄳" ;;
  "Calendar")                          ICON="󰃭" ;;
  "Things")                            ICON="󰄲" ;;
  "Todoist")                            ICON="󰄲" ;;

  # --- Design ---
  "Adobe Photoshop")                   ICON="" ;;
  "Adobe Illustrator")                 ICON="" ;;
  "Adobe After Effects")               ICON="" ;;

  # --- Virtualization / Containers ---
  "Docker Desktop")                    ICON="" ;;
  "VirtualBox")                        ICON="󰆧" ;;

  # --- Games ---
  "Steam")                              ICON="" ;;

  # --- Empty / Fallback ---
  "")                                   ICON="" ;;
  *)                                    ICON="󰘔" ;;   # generic app
esac



sketchybar --set "$NAME" icon="$ICON" icon.color="$FG"

