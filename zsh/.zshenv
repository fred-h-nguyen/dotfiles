# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Editor
export EDITOR="code --wait"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$ANDROID_SDK_ROOT/emulator:$PATH"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"

# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export PATH="/opt/homebrew/opt/trash/bin:$PATH"

# Ensure unique PATH entries
typeset -U PATH
