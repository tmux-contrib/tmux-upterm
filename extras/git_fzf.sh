# tmux-upterm git-fzf bindings — source this file in your shell config to register
# upterm keybinds with git-fzf via GIT_FZF_*_OPTS.
#
# Usage: add to ~/.bashrc or ~/.zshrc
#   source /path/to/extras/git_fzf.sh
#
# Keybinds added:
#
#   git fzf repo  (GIT_FZF_REPO_OPTS)
#     alt-u     Open an upterm session for the selected repository
#
#   git fzf worktree
#     alt-U     Open an upterm session for the selected worktree

_git_fzf_upterm_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
[[ "$_git_fzf_upterm_dir" = /* ]] || _git_fzf_upterm_dir="$(cd "$_git_fzf_upterm_dir/.." && pwd)"

_git_fzf_upterm_cmd="$_git_fzf_upterm_dir/scripts/tmux_upterm.sh"

_git_fzf_upterm_use=0
if [[ -n "${TMUX:-}" ]]; then
	_git_fzf_upterm_use=1
fi

if [[ "$_git_fzf_upterm_use" -eq 1 ]]; then
	_git_fzf_repo_opts=(
		"--bind=alt-u:execute-silent(${_git_fzf_upterm_cmd} {1})+abort"
	)
	GIT_FZF_REPO_OPTS+="${GIT_FZF_REPO_OPTS:+ }$(printf '%q ' "${_git_fzf_repo_opts[@]}")"
	GIT_FZF_REPO_OPTS="${GIT_FZF_REPO_OPTS% }"
	export GIT_FZF_REPO_OPTS
	unset _git_fzf_repo_opts
fi

if [[ "$_git_fzf_upterm_use" -eq 1 ]]; then
	_git_fzf_worktree_opts=(
		"--bind=alt-u:execute-silent(${_git_fzf_upterm_cmd} {1})+abort"
	)
	GIT_FZF_WORKTREE_OPTS+="${GIT_FZF_WORKTREE_OPTS:+ }$(printf '%q ' "${_git_fzf_worktree_opts[@]}")"
	GIT_FZF_WORKTREE_OPTS="${GIT_FZF_WORKTREE_OPTS% }"
	export GIT_FZF_WORKTREE_OPTS
	unset _git_fzf_worktree_opts
fi

unset _git_fzf_upterm_use _git_fzf_upterm_cmd _git_fzf_upterm_dir
