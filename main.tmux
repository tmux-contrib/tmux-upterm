#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/core.sh
source "$CURRENT_DIR/core.sh"

# Set tmux environment option
tmux set-option -ga update-environment " UPTERM_ADMIN_SOCKET"

# Get user-defined key
upterm_key=$(tmux_get_option "@upterm-key")
# OR use default key bind
if [ -z "$upterm_key" ]; then
	upterm_key="T"
fi

# Bind the key to run the script
tmux bind-key "$upterm_key" run-shell -b "$CURRENT_DIR/scripts/tmux-upterm.sh"
