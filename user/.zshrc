# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

# Don't record commands beginning with whitespace in history
setopt HIST_IGNORE_SPACE
# Trim whitespace before recording history
setopt HIST_REDUCE_BLANKS
# Prevent history manipulation commands from being recorded
setopt HIST_NO_STORE
# Don't record both of two consecutive identical commands
setopt HIST_IGNORE_DUPS

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Work like the normal completion menu
zstyle ':completion:*' menu select=0
zmodload zsh/complist

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#bindkey '^[[A' up-line-or-beginning-search
#bindkey '^[[B' down-line-or-beginning-search
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

# Colours for ls
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PROMPT='%B%F{green}%n@%m%f%b:%F{blue}%~%f [%(?.%F{green}.%F{red})%?%f]$ '

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# Greeting
if [[ -o interactive ]]; then
    local time_fmt_login
    # Force AM/PM because I prefer it that way
    if [ -n "$(locale t_fmt_ampm)" ]; then
        time_fmt_login="%a %e %b %Y, $(locale t_fmt_ampm)"
    else
        time_fmt_login="$(locale d_t_fmt)"
    fi
    local login_times=$(last -n 2 $USER --time-format=iso)

    # Parse the data of the full name to get the username
    local raw_last_login=$(awk 'NR==2 {print $3}' <<< "$login_times")
    local raw_curr_login=$(awk 'NR==1 {print $3}' <<< "$login_times")

    local full_name=$(getent passwd $USER | cut -d : -f 5 | cut -d , -f 1)
    local time_last_login=$(date -d "$raw_last_login" +"$time_fmt_login")
    local time_curr_login=$(date -d "$raw_curr_login" +"$time_fmt_login")
    local time_now=$(date +"$time_fmt_login")

    echo "Welcome back, $full_name!"
    echo "Last login at $time_last_login"
    echo "Session start $time_curr_login"
    echo "Local time is $time_now"
fi
