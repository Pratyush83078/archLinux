#!/bin/bash

run_tofi() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | tofi --prompt "$prompt" --fuzzy-match true --require-match false
}

HISTORY=$(tac ~/.bash_history)
BINARY_FILES=$(find /usr/bin /bin -type f -executable -print)
ALL_COMMANDS="$HISTORY\n$BINARY_FILES"

SELECTED_COMMAND=$(run_tofi "What Ya need? " "$ALL_COMMANDS")

if [ -n "$SELECTED_COMMAND" ]; then
    dunstify "Executing :- " "$SELECTED_COMMAND" -i "$HOME/Downloads/setting.png" -t 800
    eval "$SELECTED_COMMAND"
else
    dunstify "No command entered. Exiting:-" -u low -t 600
fi
