# dotfiles

Personal macOS dotfiles for Ghostty + tmux + zsh.

## Structure

```
dotfiles/
├── ghostty/              → ~/.config/ghostty/config
├── git/                  → ~/.gitconfig
├── scripts/
│   └── tmux-scripts/     → ~/tmux-scripts/
│       ├── llm-popup-toggle.sh   (Cmd+P — floating Claude session)
│       └── shell-popup.sh        (Cmd+O — floating shell)
├── starship/             → ~/.config/starship.toml
├── tmux/                 → ~/.tmux.conf
└── zsh/
    ├── .zprofile         → ~/.zprofile
    ├── .zshenv           → ~/.zshenv
    └── .zshrc            → ~/.zshrc
```

## Prerequisites

Install via Homebrew:

```sh
brew install \
  ghostty zinit starship fzf zoxide eza bat trash \
  delta lazygit lazydocker nodenv rbenv \
  tmux
```

Install tmux plugin manager:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Secrets (Bitbucket, Jira, Anthropic API key) are read from [1Password](https://1password.com) via `op` CLI — install and sign in before sourcing `.zprofile`.

## Install

Symlink each config to its expected location:

```sh
# zsh
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/.zshenv ~/.zshenv
ln -sf ~/dotfiles/zsh/.zprofile ~/.zprofile

# git (identity lives in ~/.gitconfig.local — not tracked)
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

# ghostty & starship
mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/ghostty/.config/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/starship/.config/starship.toml ~/.config/starship.toml

# tmux
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/scripts/tmux-scripts ~/tmux-scripts
```

Then install tmux plugins: open tmux and press `prefix + I`.

## Notable config

- **tmux prefix** — `Ctrl+A`
- **Cmd+P** — floating Claude Code popup (via Ghostty Unicode passthrough)
- **Cmd+O** — floating shell popup
- **Cmd+N / Shift+[ / Shift+]** — new window / prev / next (no prefix needed)
- **git identity** — name/email live in `~/.gitconfig.local` (not tracked) via `[include]`
