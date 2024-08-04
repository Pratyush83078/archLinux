#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '


#export PATH= /usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
export PATH=$PATH:$HOME/.local/bin
#CUSTOM-SCRIPT

alias bak-forLinux='cd ~/Documents && cp ~/.bashrc ~/.config/sway/config ~/.config/dunst/dunstrc -r ~/.local/bin/ ~/Documents/forLinux/ && git add ~/Documents/forLinux && git commit -m "automated: bashrc,sway_config,dunstrc" && git push origin main'

alias b-on='sudo systemctl start bluetooth && bluetoothctl connect "FC:58:FA:58:33:B5"'
alias b-off='sudo systemctl stop bluetooth'
alias w-on='nmcli r w on && nmcli d w c "iQOO Z7 5G" password "deadpool"'
alias w-on2='nmcli r w on && nmcli d w c "PRAMOD RAILWIRE" password "pmsrs1966"'
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
  sleep "$1" && dunstify -u critical "timer completed"
}
alert() {
  local time="$1"
  echo "dunstify -u critical 'Alert' 'Time to take a break or check your schedule'" | at "$time"
}
