#!/usr/bin/env bash
pane_path=$1
session_name=$2
window_name=$3
popup_w=${4:-95%}
popup_h=${5:-90%}

LLM_ASSISTANT="${LLM_ASSISTANT:-claude}"
POPUP_NAME="popup-$(basename "$pane_path" | tr -cd "a-zA-Z0-9-")"

if [[ "$session_name" == popup-* ]]; then
  if [[ "$window_name" == "$LLM_ASSISTANT" ]]; then
    tmux detach-client
  else
    tmux select-window -t "$session_name:$LLM_ASSISTANT" 2>/dev/null ||
      tmux new-window -t "$session_name" -n "$LLM_ASSISTANT" -c "$pane_path" "$LLM_ASSISTANT"
  fi
else
  tmux has-session -t "$POPUP_NAME" 2>/dev/null ||
    tmux new-session -d -s "$POPUP_NAME" -c "$pane_path" -n "$LLM_ASSISTANT" "$LLM_ASSISTANT"
  tmux select-window -t "$POPUP_NAME:$LLM_ASSISTANT" 2>/dev/null ||
    tmux new-window -t "$POPUP_NAME" -n "$LLM_ASSISTANT" -c "$pane_path" "$LLM_ASSISTANT"
  tmux display-popup -d "$pane_path" -xC -yC -w "$popup_w" -h "$popup_h" \
    -E "env -u TMUX tmux attach-session -t $POPUP_NAME"
fi
