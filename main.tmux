#!/usr/bin/env bash

_tmux_upterm_root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/tmux_upterm_core.sh
source "$_tmux_upterm_root_dir/scripts/tmux_upterm_core.sh"

[ -z "$DEBUG" ] || set -x

# Set tmux environment option
tmux_update_environment "UPTERM_ADMIN_SOCKET"

# Get user-defined key
upterm_key=$(tmux_get_option "@upterm-key")
# OR use default key bind
if [ -z "$upterm_key" ]; then
	upterm_key="T"
fi

# Bind the key to run the script
tmux bind-key "$upterm_key" run-shell -b "$_tmux_upterm_root_dir/scripts/tmux_upterm.sh"
