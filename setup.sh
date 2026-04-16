#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

green() { printf '\033[1;32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[1;33m%s\033[0m\n' "$*"; }
blue() { printf '\033[1;34m%s\033[0m\n' "$*"; }

# ── Homebrew ──────────────────────────────────────────────────────────────────

blue "→ Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "  already installed"
fi

# ── Packages ──────────────────────────────────────────────────────────────────

blue "→ Packages"
brew install \
  bat delta eza fzf lazydocker lazygit nodenv rbenv \
  ripgrep starship tmux trash zinit zoxide \
  1password-cli

brew install --cask ghostty

# ── Symlinks ──────────────────────────────────────────────────────────────────

blue "→ Symlinks"

symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "  $dst"
}

symlink "$DOTFILES/zsh/.zshrc"                   ~/.zshrc
symlink "$DOTFILES/zsh/.zshenv"                  ~/.zshenv
symlink "$DOTFILES/zsh/.zprofile"                ~/.zprofile
symlink "$DOTFILES/git/.gitconfig"               ~/.gitconfig
symlink "$DOTFILES/ghostty/.config/ghostty"      ~/.config/ghostty
symlink "$DOTFILES/starship/.config/starship.toml" ~/.config/starship.toml
symlink "$DOTFILES/tmux/.tmux.conf"              ~/.tmux.conf
symlink "$DOTFILES/scripts/tmux-scripts"         ~/tmux-scripts
symlink "$DOTFILES/ssh/config"                   ~/.ssh/config

# ── tmux plugin manager ───────────────────────────────────────────────────────

blue "→ tmux plugin manager (TPM)"
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "  installed — open tmux and press prefix+I to install plugins"
else
  echo "  already installed"
fi

# ── Done ──────────────────────────────────────────────────────────────────────

green "\n✓ Done. Manual steps remaining:"
yellow "  1. Install & sign in to 1Password + 1Password CLI (op signin)"
yellow "  2. Create ~/.gitconfig.local with your name, email, and templatedir"
yellow "  3. Create ~/.npmrc with your Artifactory token"
yellow "  4. Generate SSH keys and add to GitHub (see README)"
