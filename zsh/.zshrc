eval "$(/opt/homebrew/bin/brew shellenv)"

source /opt/homebrew/opt/zinit/zinit.zsh
source ~/dotfiles/zsh/npm-login.zsh

autoload -Uz compinit && compinit

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# ── History ───────────────────────────────────────────────────
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt AUTO_CD
setopt CORRECT

# ── Better defaults ───────────────────────────────────────────
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias cat="bat --style=plain"
alias rm="trash"
alias lg="lazygit"

alias d="docker"
alias dc="docker-compose"
alias dcd="dc down"
alias dcr="dc restart"
alias dcl="dc logs -f"
alias dcps="clear; dc ps;"
alias lzd="lazydocker"

eval "$(fzf --zsh)"
eval "$(nodenv init -)"
eval "$(rbenv init - zsh)"
eval "$(zoxide init zsh)"

eval "$(starship init zsh)"
