#!/usr/bin/env bash
# tmux_core.sh — shared library; meant to be sourced, not executed directly.

# Check if required dependencies (upterm) are installed
#
# Displays an error via tmux and exits if any dependency is missing.
_check_dependencies() {
	if ! command -v upterm &>/dev/null; then
		tmux display-message "Error: upterm is not installed. Please install it to use this plugin."
		exit 1
	fi
}

# Get a tmux option with default fallback
#
# Arguments:
#   $1 - option name
#   $2 - (optional) default value
# Outputs:
#   Option value or default
_tmux_get_option() {
	local option="$1"
	local default="${2:-}"
	local value

	value="$(tmux show-option -gqv "$option" 2>/dev/null)"
	echo "${value:-$default}"
}

# Set a tmux session option
#
# Arguments:
#   $1 - session name
#   $2 - option name
#   $3 - option value
_tmux_set_session_option() {
	local session="$1"
	local option="$2"
	local value="$3"

	tmux set-option -t "$session" "$option" "$value"
}

# Append a variable to tmux's update-environment list
#
# Arguments:
#   $1 - variable name
_tmux_update_environment() {
	tmux set-option -ga update-environment " $1"
}

# Get the name of the current tmux session
#
# Outputs:
#   Current session name
_tmux_current_session() {
	tmux display-message -p '#S'
}

# Check if a tmux session exists
#
# Arguments:
#   $1 - session name
_tmux_has_session() {
	tmux has-session -t "$1" 2>/dev/null
}

# Create a new detached tmux session
#
# Arguments:
#   $1 - session name
#   $2 - working directory path
#   $3 - (optional) command to run
_tmux_new_session() {
	tmux new-session -ds "$1" -c "$2" "${3:-}"
}

# Derive a session name from a directory path
#
# Combines the parent directory (workspace) and basename (project) with a
# forward slash, replacing dots with underscores for tmux compatibility.
#
# Arguments:
#   $1 - directory path
# Outputs:
#   Session name in "workspace/project" format
_tmux_session_name() {
	local project workspace

	project=$(basename "$1")
	workspace=$(basename "$(dirname "$1")")

	echo "$workspace/$project" | tr . _
}

# Switch to a given tmux session
#
# Arguments:
#   $1 - session name
_tmux_switch_to() {
	tmux switch-client -t "$1"
}

# Display a message in tmux
#
# Arguments:
#   $1 - message text
_tmux_display_message() {
	tmux display-message "$1"
}
