#!/bin/bash
#--require-match false:
run_tofi() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | tofi --prompt "$prompt" --fuzzy-match false --require-match false --hide-input false --hidden-character=""
}

# Fetch the history and binary files
HISTORY=$(tac ~/.bash_history)
#BINARY_FILES=$(find /usr/bin /bin -type f -executable -print | sed 's|/usr/bin/||; s|/bin/||')
#BINARY_FILES=$(find /bin -type f -executable -print | sed 's|/bin/||')
#BINARY_FILES=$(find /bin -type f -executable -print | sed 's|/bin/||')
# Combine the commands and remove duplicates using awk
ALL_COMMANDS=$(echo -e "$HISTORY" )
#ALL_COMMANDS=$(echo -e "$BINARY_FILES" | awk '!seen[$0]++')
# Run tofi to select a command
SELECTED_COMMAND=$(run_tofi "What Ya need? " "$ALL_COMMANDS")

if [ -n "$SELECTED_COMMAND" ]; then
 	command="tgpt \"$selection\""

        # Execute tgpt command, clean the output, and remove everything before "Loading" and "Loading" itself
        output=$(eval "$command" 2>&1 | sed '1,/Loading/d')

        # Notify using dunstify with the cleaned-up output
        dunstify "$selection" "$output" -t 16000 -i "/home/prem/.config/dunst/"

fi
