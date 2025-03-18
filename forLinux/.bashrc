#mdcat ~/Sync/testing/Tasks.md && read -n 1 -s && clear
#
# ~/.bashrc
#
#set -o vi
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
#export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
#export DISPLAY=:0
#export WAYLAND_DISPLAY=wayland-0
#export PATH= /usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
export PATH=$PATH:$HOME/.local/bin
export EDITOR=nvim
export XDG_CONFIG_HOME=$HOME/.config/
#CUSTOM-SCRIPT
#if [ "$(tput cols)" -gt 50 ]; then date +"%a %d %b >> " | figlet -f smslant.flf; fi

alias piano='mpv --no-terminal --force-window=no ~/Audio/Billy\ Joel\ -\ Piano\ Man\ \(Official\ Audio\).mp3 &'
alias testing='nvim $HOME/test.c'
alias tested='clang test.c && ./a.out'
alias notes='nvim ~/syncthing/testing/Tasks.md'
alias movies='nvim ~/syncthing/testing/Movies.md'
alias font='nvim ~/archive/font.md'
alias rockerz='sudo systemctl start bluetooth && bluetoothctl connect "FC:58:FA:58:33:B5"'
alias nirvana='sudo systemctl start bluetooth && bluetoothctl connect "01:02:03:05:59:C8"'
alias dees='sudo systemctl start bluetooth && bluetoothctl connect "41:42:0B:1E:0D:7F"'
alias parmanu='sudo systemctl start bluetooth && bluetoothctl connect "41:42:D1:28:28:FD"'
alias b-off='sudo systemctl disable bluetooth && sudo systemctl stop bluetooth'
alias railwire='nmcli r w on && nmcli d w c "PRAMOD RAILWIRE" '
# password "pmsrs1966"
alias iqoo='nmcli r w on && nmcli d w c "iQOO Z7 5G"'
alias hostel='nmcli r w on && nmcli d w c "EduHostelMdu" password "Pratyush@123"'
alias w-off='nmcli r w off'

alias t-on='sudo modprobe psmouse'
alias t-off='sudo modprobe -r psmouse'

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
   . /usr/share/bash-completion/bash_completion

# Minimal prompt
#PS1='\w $ '
# Define color variables
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
YELLOW="\[\033[0;33m\]"
RESET="\[\033[0m\]"
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
	# Set the prompt with colors and git branch
PS1="${BLUE}\w${YELLOW}\$(parse_git_branch) ${GREEN}\$ ${RESET}"


# Enable color support
#if [ -x /usr/bin/dircolors ]; then
 #   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#fi

# BETTER  COMMAND-HISTORY & SUGGESTION 
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"

# Better cd command
shopt -s autocd 
shopt -s cdspell

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls:cd:pwd:neofetch:neofetch memory:neofetch --off:history:clear:exit"
	#appendInHistory without#overidingit 
shopt -s histappend 
	# Case-insensitive globbing
	#shopt -s nocaseglob

hg() {
    history | grep "$1"
}
#clean_history() {
 # cp ~/.bash_history ~/.bash_history.bak
  #tac ~/.bash_history.bak | awk '!seen[$0]++' | tac > ~/.bash_history
#}

export PROMPT_COMMAND='history -a; history -n'
#export PROMPT_COMMAND="history -a; clean_history; history -c; history -r"

#export GTK_THEME=Adwaita:dark

timer() {
  sleep "$1" && dunstify -u critical "timer completed $1"
}
alert() {
   local time="$1"
   echo "dunstify -u critical 'Alert' 'Time to take a break or check your schedule'" | at "$time"
}

function bak-forLinux() {
	
    cp ~/.bashrc ~/Documents/forLinux/
    cp -r ~/.config/sway ~/Documents/forLinux/
    cp ~/.config/dunst/dunstrc ~/Documents/forLinux/
#    cp ~/.config/gtk-3.0/gtk.css ~/Documents/forLinux/
    cp -r ~/.config/tofi ~/Documents/forLinux/
    cp -r ~/.local/bin ~/Documents/forLinux/
    cp -r ~/.mozilla/firefox/4qatbcuy.default-release/chrome/ ~/Documents/forLinux/
    cp ~/.mozilla/firefox/4qatbcuy.default-release/user.js ~/Documents/forLinux/
   
    git -C ~/Documents/forLinux add .
    read -p "Commit message (default: automated: bashrc, sway, dunstrc, tofi, chrome/, user.js, local/bin): " commit_message
    commit_message=${commit_message:-"automated: bashrc, sway, dunstrc, tofi, userChrome, user.js, local/bin"}
    git -C ~/Documents/forLinux commit -m "$commit_message"
    git -C ~/Documents/forLinux push origin main
}

#dv() { q=${2:-$(read -p "Enter quality: " q && echo $q)}; yt-dlp -f "bestvideo[height<=$q]+bestaudio/best[height<=$q]" --write-auto-sub --embed-subs "$1"; }
#dp() { q=${2:-$(read -p "Enter quality: " q && echo $q)}; yt-dlp -f "bestvideo[height<=$q]+bestaudio/best[height<=$q]" --write-auto-sub --embed-subs -o "%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s" "$1"; }
#da() { yt-dlp -f "bestaudio/best" -x --audio-format mp3 "$1"; }

#dv() { yt-dlp -f "bv*+ba/b" --write-auto-sub --embed-subs ${2:+-S "height:$2"} "$1"; }
#dp() { yt-dlp -f "bv*+ba/b" --write-auto-sub --embed-subs -o "%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s" ${2:+-S "height:$2"} "$1"; }
#da() { yt-dlp -x --audio-format mp3 "$1"; }
dv() { 
    q=${2:-$(read -p "Enter video quality (or press Enter for best): " q && echo $q)} 
    yt-dlp -f "bv*[height<=${q:-10000}]+ba/b" --write-auto-sub --embed-subs --embed-thumbnail --convert-thumbnails jpg \
           -o "$HOME/Videos/%(title)s.%(ext)s" "$1"
}

dp() { 
    q=${2:-$(read -p "Enter video quality (or press Enter for best): " q && echo $q)}
    yt-dlp -f "bv*[height<=${q:-10000}]+ba/b" --write-auto-sub --embed-subs --embed-thumbnail --convert-thumbnails jpg \
           -o "$HOME/Videos/%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s" "$1"
}

da() { 
    q=${2:-$(read -p "Enter audio quality (6-0, lower is better, or press Enter for best): " q && echo $q)}
    yt-dlp -f "ba" -x --audio-format mp3 --embed-thumbnail --convert-thumbnails jpg --add-metadata ${q:+--audio-quality $q} \
           -o "$HOME/Audio/%(title)s.%(ext)s" "$1"
}

torr() {  
    transmission-cli -u 0 -w "$HOME/Videos/Movies" "$1"
}

ai() {
	tgpt "$*";
}
