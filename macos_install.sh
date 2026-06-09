#!/bin/bash

set -e

echo "🚀 Starting Zsh Environment Setup with Starship (macOS)"
echo ""

# ----------------------------------------------------------------------------
# Ensure Homebrew is installed
# ----------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
    echo "📦 Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Make brew available in the current session (Apple Silicon vs Intel paths)
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

# ----------------------------------------------------------------------------
# Install core CLI tools
# ----------------------------------------------------------------------------
echo ""
echo "📦 Installing CLI tools with Homebrew..."
# Note (vs the Linux/apt script):
#   - fd-find  -> fd   (binary is already named `fd` on Homebrew)
#   - git-delta provides the `delta` command (same as apt)
#   - lazygit is a normal formula on Homebrew (no manual GitHub download needed)
brew install \
    starship \
    ripgrep \
    fzf \
    bat \
    fd \
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
    fortune \
    lazygit

echo "✅ CLI tools installed"

# ----------------------------------------------------------------------------
# Locate this repo (so we can copy the bundled config files)
# ----------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ----------------------------------------------------------------------------
# Install Starship configuration
# ----------------------------------------------------------------------------
echo ""
echo "⚙️  Installing Starship configuration..."
mkdir -p ~/.config
cp "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml
echo "✅ ~/.config/starship.toml installed"

# ----------------------------------------------------------------------------
# Install .zshrc (backing up any existing one first)
# ----------------------------------------------------------------------------
if [ -f ~/.zshrc ]; then
    BACKUP=~/.zshrc.backup.$(date +%Y%m%d%H%M%S)
    echo ""
    echo "💾 Backing up existing ~/.zshrc to $BACKUP"
    cp ~/.zshrc "$BACKUP"
fi

echo ""
echo "⚙️  Installing ~/.zshrc..."
cp "$SCRIPT_DIR/.zshrc" ~/.zshrc
echo "✅ ~/.zshrc installed"

echo ""
echo "============================================================================"
echo "✨ Installation Complete!"
echo "============================================================================"
echo ""
echo "📝 What was installed:"
echo "   • Starship (fast prompt framework)"
echo "   • ripgrep (rg), fzf, bat, fd, eza, zoxide, delta, lazygit, tldr, jq, tree"
echo "   • cowsay + fortune (random quote on shell start)"
echo ""
echo "🚀 Next steps:"
echo "   1. Restart your terminal or run: source ~/.zshrc"
echo "   2. Install a Nerd Font for the prompt icons, e.g.:"
echo "        brew install --cask font-meslo-lg-nerd-font"
echo "      then select 'MesloLGS NF' in your terminal preferences."
echo ""
echo "📚 Configuration files: ~/.config/starship.toml and ~/.zshrc"
echo "💾 Backup of original .zshrc (if any): ~/.zshrc.backup.*"
echo ""
