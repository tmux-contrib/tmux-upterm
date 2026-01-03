#!/usr/bin/env bash

[ -z "$DEBUG" ] || set -x

_tmux_upterm_source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=tmux_upterm_core.sh
source "$_tmux_upterm_source_dir/tmux_upterm_core.sh"

_check_dependencies

# Creates or switches to a shared upterm session.
#
# This function implements the core logic of the plugin.
# It checks if the current session is already a shared session.
# If not, it creates a new shared session named `ssh://<current_session_name>`.
# If a shared session already exists for the current session, it switches to it.
tmux_session_share() {
	local session_name
	local session_dir_path

	if [ -n "$1" ]; then
		session_name="$(_tmux_session_name "$1")"
		session_dir_path="$1"
	else
		session_name="$(_tmux_current_session)/ssh"
		session_dir_path="$PWD"
	fi

	if ssh-add -l >/dev/null; then
		# If session already exists, switch to it. Otherwise, create it.
		if ! _tmux_has_session "$session_name"; then
			# Create the new session
			_tmux_new_session "$session_name" "$session_dir_path" "upterm host --accept --force-command 'tmux attach -t $session_name'"

			# Set the indicator flag
			_tmux_set_option_for_session "$session_name" "@is_upterm_session" "true"
		fi

		# Switch to the new session
		_tmux_switch_to "$session_name"
	else
		_tmux_display_message "No SSH keys found. Please add an SSH key to your agent."
	fi

}

tmux_session_share "$@"
