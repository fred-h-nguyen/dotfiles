# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-04-16

### Added
- `setup.sh` — automated install script (Homebrew, packages, symlinks, TPM)
- `ssh/config` — SSH host aliases (personal GitHub + commented work template)

### Changed
- README rewritten around `setup.sh` with a manual steps table

## [0.1.0] - 2026-04-16

### Added
- Ghostty terminal config (JetBrains Mono, transparent titlebar, Unicode key passthrough)
- git config with delta diff, aliases, and `~/.gitconfig.local` include for identity
- Starship prompt config
- tmux config (Catppuccin Mocha, TPM plugins, Cmd-key bindings via Ghostty passthrough)
- tmux popup scripts: floating Claude Code session (`llm-popup-toggle.sh`) and shell (`shell-popup.sh`)
- zsh config: zinit, fzf-tab, autosuggestions, syntax highlighting, zoxide, starship
