# Productivity Tools

A modern Zsh environment using Starship for the prompt, configured in an agnoster powerline style.

## Files

- `zsh_install.sh` — **Linux (Debian/Ubuntu, apt)** installer: installs all tools and configures your shell
- `macos_install.sh` — **macOS (Homebrew)** installer: installs all tools and copies the configs into place
- `.zshrc` — Zsh shell configuration with aliases, fzf, zoxide, etc. (cross-platform: Linux + macOS)
- `starship.toml` — Starship prompt config (agnoster powerline style with Ubuntu logo)

## What gets installed

| Tool | Description |
|------|-------------|
| [Starship](https://starship.rs) | Fast, customizable prompt |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast grep alternative (`rg`) |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [bat](https://github.com/sharkdp/bat) | Better `cat` with syntax highlighting |
| [fd](https://github.com/sharkdp/fd) | Fast `find` alternative |
| [eza](https://github.com/eza-community/eza) | Modern `ls` replacement |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` with frecency |
| [delta](https://github.com/dandavison/delta) | Beautiful git diffs |
| [lazygit](https://github.com/jesseduffield/lazygit) | Git UI in terminal |
| [tldr](https://tldr.sh) | Simplified man pages |
| [jq](https://jqlang.github.io/jq/) | JSON query tool |
| cowsay + fortune | Random cow quote on shell start |

## Usage

### Linux (Debian/Ubuntu)

```bash
bash zsh_install.sh
```

Then copy the configs into place:

```bash
cp .zshrc ~/.zshrc
cp starship.toml ~/.config/starship.toml
source ~/.zshrc
```

### macOS (Homebrew)

```bash
bash macos_install.sh
```

This installs [Homebrew](https://brew.sh) if it is missing, installs all the tools, and copies
`.zshrc` and `starship.toml` into place (backing up any existing `~/.zshrc` first). Afterwards run:

```bash
source ~/.zshrc
```

## Requirements

A [Nerd Font](https://www.nerdfonts.com/) must be set in your terminal for the powerline arrows and icons to render correctly. Recommended: **MesloLGS NF** or **FiraCode Nerd Font**.

On macOS you can install one with:

```bash
brew install --cask font-meslo-lg-nerd-font
```

then select **MesloLGS NF** in your terminal's preferences.
