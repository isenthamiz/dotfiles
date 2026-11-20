#!/bin/bash
# Prints the battery level ("24%") only when it matters: running on battery,
# or at 30% or below. Prints nothing otherwise, so the status bar hides it.
info=$(pmset -g batt 2>/dev/null)
pct=$(printf '%s' "$info" | grep -Eo '[0-9]+%' | head -1 | tr -d %)
[ -z "$pct" ] && exit 0
case $info in *"AC Power"*) [ "$pct" -gt 30 ] && exit 0 ;; esac
printf '%s%%' "$pct"
