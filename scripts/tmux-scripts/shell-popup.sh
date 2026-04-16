#!/usr/bin/env bash
pane_path=$1
session_name=$2
window_name=$3
popup_w=${4:-95%}
popup_h=${5:-90%}

POPUP_WINDOW_NAME="${POPUP_WINDOW_NAME:-shell}"
POPUP_NAME="popup-$(basename "$pane_path" | tr -cd 'a-zA-Z0-9-')"

if command -v zsh >/dev/null 2>&1 && [[ -f "$HOME/.zshrc" ]]; then
  SHELL_CMD="zsh -i"
else
  SHELL_CMD="bash -l"
fi

if [[ "$session_name" == popup-* ]]; then
  if [[ "$window_name" == "$POPUP_WINDOW_NAME" ]]; then
    tmux detach-client
  else
    tmux select-window -t "$session_name:$POPUP_WINDOW_NAME" 2>/dev/null ||
      tmux new-window -t "$session_name" -n "$POPUP_WINDOW_NAME" -c "$pane_path" $SHELL_CMD
  fi
else
  tmux has-session -t "$POPUP_NAME" 2>/dev/null ||
    tmux new-session -d -s "$POPUP_NAME" -c "$pane_path" -n "$POPUP_WINDOW_NAME" $SHELL_CMD
  tmux select-window -t "$POPUP_NAME:$POPUP_WINDOW_NAME" 2>/dev/null ||
    tmux new-window -t "$POPUP_NAME" -n "$POPUP_WINDOW_NAME" -c "$pane_path" $SHELL_CMD
  tmux display-popup -d "$pane_path" -xC -yC -w "$popup_w" -h "$popup_h" \
    -E "env -u TMUX tmux attach-session -t $POPUP_NAME"
fi
