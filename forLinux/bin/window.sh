#!/bin/bash
run_tofi() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | tofi --prompt "$prompt" --fuzzy-match false --require-match false --hide-input false --hidden-character=""
}

search_dir="$HOME"
apps=$(ls /usr/share/applications | sed 's/.desktop//')
files=$(fd --type f --type d --max-depth 5 . "$search_dir" 2>/dev/null)
combined=$(echo -e "$apps\n$files")
#selection=$(echo "$combined" | tofi --prompt "Open/Run: " --fuzzy-match false --require-match false)
selection=$(run_tofi "What Ya need? " "$combined")

if echo "$apps" | grep -q "^$selection$"; then
    gtk-launch "$selection"
elif [ -d "$selection" ]; then
    thunar "$selection"
elif [ -f "$selection" ]; then
    xdg-open "$selection"
else
    if [ -n "$selection" ]; then 
	command="tgpt \"$selection\""
        output=$(eval "$command" 2>&1 | awk -v RS="Loading" 'END{print}')
        dunstify "$selection" "$output" -t 16000 -i "/home/prem/.config/dunst/"
    fi 
fi

