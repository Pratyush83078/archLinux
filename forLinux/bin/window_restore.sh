#!/bin/bash

# Directory to store window history
HISTORY_DIR="$HOME/.config/i3-resurrect/window-history"
#CURRENT_LAYOUT="$HOME/.config/i3-resurrect/layouts/current"
STACK_FILE="$HISTORY_DIR/window_stack"

# Ensure the history directory exists
#mkdir -p "$HISTORY_DIR"


# Function to save current layout and add to stack
save_current_layout() {
    TIMESTAMP=$(date +%s)
    swaymsg -t get_tree > "$HISTORY_DIR/$TIMESTAMP.json"
    echo "$TIMESTAMP" >> "$STACK_FILE"
    dunstify "Saved current layout"
}

# Function to restore the most recent layout
restore_recent_layout() {
    if [ ! -s "$STACK_FILE" ]; then
        dunstify "No windows to restore."
        return
    fi

    LATEST=$(tail -n 1 "$STACK_FILE")
    sed -i '$d' "$STACK_FILE"  # Remove the last line
    
    # Read the saved layout
    layout_file="$HISTORY_DIR/$LATEST.json"
    
    # Extract workspace information and recreate windows
    jq -r '.nodes[] | select(.type == "workspace") | .nodes[] | select(.type == "con") | 
    "swaymsg \"workspace \(.name); exec \(.window_properties.class)\""' "$layout_file" | 
    while read -r command; do
        eval "$command"
    done
    
    dunstify "Restored windows from $(date -d @$LATEST)"
}

# Main logic
case "$1" in
    save)
        save_current_layout
        ;;
    restore)
        restore_recent_layout
        ;;
    *)
        echo "Usage: $0 {save|restore}"
        exit 1
        ;;
esac

