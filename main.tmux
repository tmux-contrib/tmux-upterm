#!/usr/bin/env bash
set -euo pipefail

[[ -z "${DEBUG:-}" ]] || set -x

_tmux_upterm_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ -f "$_tmux_upterm_root/scripts/tmux_core.sh" ]] || {
	echo "tmux-upterm: missing tmux_core.sh" >&2
	exit 1
}

# shellcheck source=scripts/tmux_core.sh
source "$_tmux_upterm_root/scripts/tmux_core.sh"

main() {
	_check_dependencies

	# Set tmux environment option
	_tmux_update_environment "UPTERM_ADMIN_SOCKET"

	# Get user-defined key (default: T)
	local upterm_key
	upterm_key=$(_tmux_get_option "@upterm-key")
	upterm_key=${upterm_key:-'T'}

	# Bind the key to run the script
	tmux bind-key "$upterm_key" run-shell -b "$_tmux_upterm_root/scripts/tmux_upterm.sh"
}

main
