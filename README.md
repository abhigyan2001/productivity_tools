# Productivity Tools

A modern Zsh environment using Starship for the prompt, configured in an agnoster powerline style.

## Files

- `zsh_install.sh` — Run this to install all tools and configure your shell from scratch
- `.zshrc` — Zsh shell configuration with aliases, fzf, zoxide, etc.
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

```bash
bash zsh_install.sh
```

Then copy the configs into place:

```bash
cp .zshrc ~/.zshrc
cp starship.toml ~/.config/starship.toml
source ~/.zshrc
```

## Requirements

A [Nerd Font](https://www.nerdfonts.com/) must be set in your terminal for the powerline arrows and icons to render correctly. Recommended: **MesloLGS NF** or **FiraCode Nerd Font**.
