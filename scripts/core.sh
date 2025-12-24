#!/usr/bin/env bash

# Check if required dependencies are installed.
#
# Verifies that upterm is installed and available in the system PATH.
# If any dependency is not found, displays an error message and exits with status 1.
#
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   0 if all dependencies are installed
#   1 if any dependency is missing
check_dependencies() {
    if ! command -v upterm &>/dev/null; then
        tmux display-message "Error: upterm is not installed. Please install it to use this plugin."
        exit 1
    fi
}

# Get a tmux option value.
#
# Retrieves the value of a global tmux option. If the option is not set,
# returns the provided default value.
#
# Globals:
#   None
# Arguments:
#   $1 - The name of the tmux option to retrieve
#   $2 - The default value to return if the option is not set
# Outputs:
#   The option value or default value to stdout
# Returns:
#   0 on success
tmux_get_option() {
    local option="$1"
    local default_value="$2"
    local option_value

    option_value="$(tmux show-option -gqv "$option")"
    [[ -n "$option_value" ]] && echo "$option_value" || echo "$default_value"
}

# Set a tmux session option.
#
# Arguments:
#   $1 - The name of the session
#   $2 - The name of the option
#   $3 - The value of the option
tmux_set_option_for_session() {
    local name="$1"
    local option="$2"
    local value="$3"

    tmux set -t "$name" "$option" "$value"
}

# Get a tmux session option value.
#
# Arguments:
#   $1 - The name of the session option to retrieve
# Outputs:
#   The option value to stdout
tmux_get_option_for_session() {
    local option_name="$1"
    tmux display-message -p "#{${option_name}}"
}

# Get the name of the current tmux session.
#
# Outputs:
#   The name of the current session to stdout
tmux_current_session() {
    tmux display-message -p '#S'
}

# Check if a tmux session exists.
#
# Determines whether a tmux session with the given name is currently running.
#
# Globals:
#   None
# Arguments:
#   $1 - The name of the tmux session to check
# Returns:
#   0 if the session exists
#   1 if the session does not exist
tmux_has_session() {
    tmux list-sessions 2>/dev/null | grep -q "^$1:"
}

# Create a new tmux session.
#
# Creates a new detached tmux session with the specified name and working directory.
#
# Globals:
#   None
# Arguments:
#   $1 - The name for the new tmux session
#   $2 - The working directory path for the session
#   $3 - The command for the session
# Returns:
#   0 on success, non-zero on failure
tmux_new_session() {
    tmux new-session -ds "$1" -c "$2" "$3"
}

# Switch to a given tmux session.
#
# Switches the current tmux client to the specified session.
#
# Globals:
#   None
# Arguments:
#   $1 - The name of the tmux session to switch to
# Returns:
#   0 on success, non-zero on failure
tmux_switch_to() {
    tmux switch-client -t "$1"
}
