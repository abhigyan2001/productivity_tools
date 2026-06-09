
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
# FZF Integration (cross-platform: Linux apt + macOS Homebrew)
# ============================================================================
if command -v fzf &>/dev/null && fzf --zsh &>/dev/null; then
    # fzf >= 0.48 ships built-in shell integration
    source <(fzf --zsh)
else
    # Fallback: source the shipped scripts from common install locations
    for _fzf_dir in \
        /usr/share/doc/fzf/examples \
        /usr/local/opt/fzf/shell \
        /opt/homebrew/opt/fzf/shell; do
        [ -f "$_fzf_dir/key-bindings.zsh" ] && source "$_fzf_dir/key-bindings.zsh"
        [ -f "$_fzf_dir/completion.zsh" ] && source "$_fzf_dir/completion.zsh"
    done
    unset _fzf_dir
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
# Desktop notification when a long command finishes (Linux: notify-send, macOS: osascript)
if command -v notify-send &>/dev/null; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
elif command -v osascript &>/dev/null; then
    alias alert='osascript -e "display notification \"$(history|tail -n1|sed -e '\''s/^[ ]*[0-9]\+[ ]*//;s/[;&|][ ]*alert$//'\'')\" with title \"Terminal\""'
fi

# ============================================================================
# cowsay + fortune (random quote on shell start)
# ============================================================================
if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
    for _cowdir in \
        /usr/share/cowsay/cows \
        /usr/local/share/cowsay/cows \
        /opt/homebrew/share/cowsay/cows; do
        [ -d "$_cowdir" ] && break
    done
    # sort -R is portable across GNU (Linux) and BSD (macOS) coreutils
    _cowfile=$(ls "$_cowdir" 2>/dev/null | sort -R | head -n1)
    [ -n "$_cowfile" ] && fortune | cowsay -f "$_cowfile"
    unset _cowdir _cowfile
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

