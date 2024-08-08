#!/bin/bash
run_tofi() {
    local prompt="$1"
    local options="$2"
    local result=$(echo -e "$options" | tofi --prompt "$prompt" --fuzzy-match true --require-match false)
    echo "$result"
}
while true; do
    EXPRESSION=$(run_tofi "Press q to exit: ")
    
    if [ "$EXPRESSION" = "q" ]; then
        break	
    elif [ -n "$EXPRESSION" ]; then
        RESULT=$(echo "scale=2; $EXPRESSION" | bc -l)
        dunstify "$EXPRESSION = $RESULT :-" -i "$HOME/Downloads/setting.png"
    fi
done;
