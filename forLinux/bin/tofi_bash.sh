#!/bin/bash

run_tofi() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | tofi --prompt "$prompt" --fuzzy-match true --require-match false
}

# Fetch the history and binary files
#HISTORY=$(tac ~/.bash_history)
BINARY_FILES=$(find /usr/bin /bin -type f -executable -print | sed 's|/usr/bin/||; s|/bin/||')
#BINARY_FILES=$(find /bin -type f -executable -print | sed 's|/bin/||')
#BINARY_FILES=$(find /bin -type f -executable -print | sed 's|/bin/||')
# Combine the commands and remove duplicates using awk
ALL_COMMANDS=$(echo -e "$BINARY_FILES" )
#ALL_COMMANDS=$(echo -e "$BINARY_FILES" | awk '!seen[$0]++')
# Run tofi to select a command
SELECTED_COMMAND=$(run_tofi "What Ya need? " "$ALL_COMMANDS")

if [ -n "$SELECTED_COMMAND" ]; then
    dunstify "Executing :- " "$SELECTED_COMMAND" -i "$HOME/Downloads/setting.png" -t 800
    echo "$SELECTED_COMMAND" >> $HOME/.bash_history
    
    # Execute the selected command in an interactive subshell
    bash -ic "$SELECTED_COMMAND"
fi
