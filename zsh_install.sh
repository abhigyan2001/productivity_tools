#!/bin/bash

set -e

echo "🚀 Starting Zsh Environment Setup with Starship"
echo ""

# Update package lists
echo "📦 Updating apt package lists..."
sudo apt update

# Install core CLI tools
echo ""
echo "📦 Installing CLI tools..."
sudo apt install -y \
    ripgrep \
    fzf \
    bat \
    fd-find \
    eza \
    zoxide \
    git-delta \
    tldr \
    jq \
    tree \
    git \
    curl \
    wget \
    cowsay \
    fortune

# Install lazygit from GitHub releases (not in standard apt)
echo ""
echo "📦 Installing lazygit from GitHub releases..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin
rm -f /tmp/lazygit /tmp/lazygit.tar.gz
echo "✅ Lazygit installed"

# Create symlink for fd-find (apt packages it as fd-find)
echo ""
echo "🔗 Creating symlink for fd-find..."
if [ ! -L ~/.local/bin/fd ]; then
    mkdir -p ~/.local/bin
    ln -sf /usr/bin/fd-find ~/.local/bin/fd
fi

# Install Starship
echo ""
echo "⭐ Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Create starship config directory
mkdir -p ~/.config

# Create starship.toml configuration
echo ""
echo "⚙️  Creating Starship configuration..."
cat > ~/.config/starship.toml << 'EOF'
# Starship Configuration
# Similar to agnost oh-my-zsh theme

format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$fill\
$cmd_duration\
$line_break\
$character"""

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[➜](bold red)"

[directory]
truncation_length = 3
truncate_to_repo = true
format = "[$path]($style)[$read_only]($read_only_style) "
style = "bold cyan"

[git_branch]
format = "on [$symbol$branch]($style) "
symbol = " "
style = "bold purple"

[git_status]
format = "([$all_status$ahead_behind]($style) )"
style = "bold red"
conflicted = "🏳"
ahead = "⇡${count}"
behind = "⇣${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
untracked = "🤷"
stashed = "📦"
modified = "📝"
staged = '[++\($count\)](green)'
renamed = "👅"
deleted = "🗑"

[username]
show_always = false
format = "[$user]($style) "
style_user = "white bold"

[hostname]
ssh_only = true
format = "on [$hostname]($style) "
style = "bold dimmed green"

[fill]
symbol = " "

[cmd_duration]
min_time = 500
format = "took [$duration]($style) "
style = "bold yellow"

[nodejs]
format = "via [⬢ $version]($style) "
style = "bold green"
disabled = true

[python]
format = "via [🐍 $version]($style) "
style = "bold yellow"
disabled = true

[rust]
format = "via [🦀 $version]($style) "
style = "bold red"
disabled = true
EOF

echo "✅ Starship configuration created"

# Backup original .zshrc
if [ -f ~/.zshrc ]; then
    echo ""
    echo "💾 Backing up original .zshrc to .zshrc.backup"
    cp ~/.zshrc ~/.zshrc.backup
fi

# Update .zshrc with starship and aliases
echo ""
echo "⚙️  Updating .zshrc configuration..."
cat >> ~/.zshrc << 'EOF'

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
# Useful Aliases
# ============================================================================
# Better tools
alias cat='bat --style=plain'
alias ls='eza -la --group-directories-first'
alias find='fd'
alias grep='rg'
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

EOF

echo "✅ .zshrc updated with starship, aliases, and configurations"

echo ""
echo "============================================================================"
echo "✨ Installation Complete!"
echo "============================================================================"
echo ""
echo "📝 What was installed:"
echo "   • Starship (fast prompt framework)"
echo "   • ripgrep (rg) - fast grep alternative"
echo "   • fzf - fuzzy finder"
echo "   • bat - better cat with syntax highlighting"
echo "   • fd - fast find alternative"
echo "   • eza - modern ls replacement (successor to exa)"
echo "   • zoxide - smarter cd with frecency"
echo "   • delta - beautiful git diffs"
echo "   • lazygit - git UI in terminal"
echo "   • tldr - simplified man pages"
echo "   • jq - JSON query tool"
echo "   • tree - directory tree viewer"
echo ""
echo "🚀 Next steps:"
echo "   1. Restart your shell or run: source ~/.zshrc"
echo "   2. Test the tools: rg --version, fzf --version, bat --version, etc."
echo "   3. Try cd with zoxide: z <directory>"
echo "   4. Use lazygit: lg"
echo ""
echo "📚 Configuration file: ~/.config/starship.toml"
echo "📚 Shell config: ~/.zshrc"
echo "💾 Backup of original .zshrc: ~/.zshrc.backup"
echo ""
