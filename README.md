# dotfiles

Personal macOS dotfiles for Ghostty + tmux + zsh.

## Install

```sh
git clone https://github.com/fred-h-nguyen/dotfiles.git ~/dotfiles
cd ~/dotfiles && bash setup.sh
```

Then handle the manual steps the script prints at the end.

## Structure

```
dotfiles/
├── ghostty/              → ~/.config/ghostty/
├── git/                  → ~/.gitconfig
├── scripts/
│   └── tmux-scripts/     → ~/tmux-scripts/
│       ├── llm-popup-toggle.sh   (Cmd+P — floating Claude session)
│       └── shell-popup.sh        (Cmd+O — floating shell)
├── ssh/                  → ~/.ssh/config
├── starship/             → ~/.config/starship.toml
├── tmux/                 → ~/.tmux.conf
└── zsh/
    ├── .zprofile         → ~/.zprofile
    ├── .zshenv           → ~/.zshenv
    └── .zshrc            → ~/.zshrc
```

## Manual steps (not automated)

| What | Why not tracked |
|------|----------------|
| 1Password + `op signin` | Secrets source for all API keys |
| `~/.gitconfig.local` | Contains work name/email — not committed |
| `~/.npmrc` | Contains work Artifactory token |
| SSH keys | Private keys never tracked; `ssh/config` has the aliases |

### SSH keys

Generate two keys — one for work, one for personal GitHub:

```sh
ssh-keygen -t ed25519 -C "work" -f ~/.ssh/id_ed25519
ssh-keygen -t ed25519 -C "fred-h-nguyen@github" -f ~/.ssh/id_ed25519_personal
```

Add each public key to the respective GitHub account. The `ssh/config` in this repo already has the `github-personal` alias wired up; uncomment the work block for your work account.

### ~/.gitconfig.local

```ini
[user]
  name = Fred Nguyen
  email = your@work-email.com
[init]
  templatedir = ~/.git-templates
```

## Notable config

- **tmux prefix** — `Ctrl+A`
- **Cmd+P** — floating Claude Code popup (via Ghostty Unicode passthrough)
- **Cmd+O** — floating shell popup
- **Cmd+N / Shift+[ / Shift+]** — new window / prev / next (no prefix needed)
- **Window names** — show the tmux window name (`#W`), not the shell-reported pane title
- **git identity** — name/email live in `~/.gitconfig.local` (not tracked) via `[include]`
