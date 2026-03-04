#!/bin/bash

set -e

echo "🚀 Starting Bash Environment Setup with Starship"
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

# Create starship config directory and copy config
mkdir -p ~/.config
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/starship.toml" ]; then
    echo ""
    echo "⚙️  Copying Starship configuration..."
    cp "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml
    echo "✅ Starship configuration copied"
else
    echo ""
    echo "⚙️  Creating Starship configuration..."
    cat > ~/.config/starship.toml << 'EOF'
# Starship Configuration

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
fi

# Backup original .bashrc
if [ -f ~/.bashrc ]; then
    echo ""
    echo "💾 Backing up original .bashrc to .bashrc.backup"
    cp ~/.bashrc ~/.bashrc.backup
fi

# Copy .bashrc from repo
echo ""
echo "⚙️  Installing .bashrc configuration..."
cp "$SCRIPT_DIR/.bashrc" ~/.bashrc
echo "✅ .bashrc installed"

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
echo "   • eza - modern ls replacement"
echo "   • zoxide - smarter cd with frecency"
echo "   • delta - beautiful git diffs"
echo "   • lazygit - git UI in terminal"
echo "   • tldr - simplified man pages"
echo "   • jq - JSON query tool"
echo "   • tree - directory tree viewer"
echo ""
echo "🚀 Next steps:"
echo "   1. Restart your shell or run: source ~/.bashrc"
echo "   2. Test the tools: rg --version, fzf --version, bat --version, etc."
echo "   3. Try cd with zoxide: z <directory>"
echo "   4. Use lazygit: gl"
echo ""
echo "📚 Configuration file: ~/.config/starship.toml"
echo "📚 Shell config: ~/.bashrc"
echo "💾 Backup of original .bashrc: ~/.bashrc.backup"
echo ""
