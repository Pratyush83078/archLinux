#!/bin/bash

HISTORY_FILE="$HOME/syncthing/clipboard_history.txt"
content=$(wl-paste -n)
if [ -n "$content" ]; then
    single_line=$(echo "$content" | tr '\n' ' ')
    removed_last_spaces="${single_line%"${single_line##*[![:space:]]}"}"
	#~ echo "$single_line_content";
    # Read the last two entries from the history file
    entries=$(tail -n 2 "$HISTORY_FILE" 2>/dev/null)

    # Check if the current content is found within the last two entries
    if ! echo "$entries" | grep -qF "$removed_last_spaces"; then
        echo "$removed_last_spaces" >> "$HISTORY_FILE"
        dunstify "COPIED SUCCESSFULLY :- " "$SELECTED_COMMAND" -i "$HOME/Downloads/setting.png" -t 500
        #~ echo "$single_li";
    fi
fi
#~ echo "$(date | awk '{print $4}')";
