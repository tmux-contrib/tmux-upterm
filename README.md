# tmux-upterm

A `tmux` plugin for sharing sessions via [upterm](https://upterm.dev).

## Installation

```tmux
# configure the tmux plugins manager
set -g @plugin "tmux-plugins/tpm"

# official plugins
set -g @plugin 'tmux-contrib/tmux-upterm'
```

## Usage

You can use `prefix + T` binding to create a new `upterm` session or you can
change it the binding by adding this to your `.tmux.conf`:

```
set -g @upterm-key 'T'
```

This plugin provides a flag, `is_upterm_session`, that is set to `true` for any
session created by this plugin.

You can use this flag in your `tmux` status line to show an indicator for
`upterm` sessions. For example, to display `upterm` in your `status-right`, add
this to your `.tmux.conf`:

```tmux
# This example shows how to display " UPT " for upterm sessions.
# You can change the text " UPT " to anything you like.
set -g status-right '#{?@is_upterm_session,[upterm],}'
```
