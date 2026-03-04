# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ============================================================================
# Starship Prompt
# ============================================================================
eval "$(starship init bash)"

# ============================================================================
# Zoxide (smarter cd)
# ============================================================================
eval "$(zoxide init bash)"
alias cd=z

# ============================================================================
# FZF Integration
# ============================================================================
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi

# ============================================================================
# PATH
# ============================================================================
export PATH="$HOME/.local/bin:$PATH"

# ============================================================================
# Useful Aliases
# ============================================================================
# Better tools (replaces base ls/grep/etc)
alias cat='bat --style=plain'
alias ls='eza --group-directories-first'
alias ll='eza -la --group-directories-first'
alias la='eza -a --group-directories-first'
alias l='eza -F --group-directories-first'
alias find='fd'
alias grep='rg'
alias fgrep='rg -F'
alias egrep='rg -e'
alias diff='delta'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gst='git status'
alias gd='git diff'
alias gl='lazygit'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Utility aliases
alias tree='tree -L 2'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ============================================================================
# cowsay + fortune (random quote on shell start)
# ============================================================================
if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
    fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)
fi

# ============================================================================
# History Configuration
# ============================================================================
HISTCONTROL=ignoreboth:erasedups

# ============================================================================
# FZF Default Options
# ============================================================================
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
