#!/bin/bash

run_tofi() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | tofi --prompt "$prompt" --fuzzy-match false --require-match false
}
ALL_COMMANDS="$(tac $HOME/clipboard_history.txt)"

SELECTED_COMMAND=$(run_tofi "Enter to save: " "$ALL_COMMANDS")

if [ -n "$SELECTED_COMMAND" ]; then
   #dunstify "copied :- " "$SELECTED_COMMAND" -i "$HOME/Downloads/setting.png" -t 800
   wl-copy "$SELECTED_COMMAND"
fi
