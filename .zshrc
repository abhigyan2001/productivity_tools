
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/abhigyan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_cmd_history
HISTSIZE=1000
SAVEHIST=1000
setopt beep notify
unsetopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

# ============================================================================
# Starship Prompt
# ============================================================================
eval "$(starship init zsh)"

# ============================================================================
# Zoxide (smarter cd)
# ============================================================================
eval "$(zoxide init zsh)"
alias cd=z

# ============================================================================
# FZF Integration
# ============================================================================
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
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

# ============================================================================
# cowsay + fortune (random quote on shell start)
# ============================================================================
if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
    fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)
fi

# ============================================================================
# History Configuration
# ============================================================================
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

# ============================================================================
# FZF Default Options
# ============================================================================
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

