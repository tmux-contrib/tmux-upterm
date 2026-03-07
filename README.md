# tmux-upterm

Share your tmux sessions securely over the internet with [Upterm](https://upterm.dev) — perfect for pair programming and remote collaboration.

## Dependencies

### Required

- [upterm](https://upterm.dev)

## Installation

Add this plugin to your `~/.tmux.conf`:

```tmux
set -g @plugin 'tmux-contrib/tmux-upterm'
```

And install it by running `<prefix> + I`.

## Usage

| Key Binding                              | Description                          |
| ---------------------------------------- | ------------------------------------ |
| <kbd>Prefix</kbd> + <kbd>T</kbd>         | Create or switch to an upterm session |

This plugin sets `@upterm-session` to the session name for any session created
by this plugin. Use it as a boolean check or display the name directly:

```tmux
# Boolean check
set -g status-right '#{?@upterm-session,[upterm],}'

# Show the actual session name
set -g status-right '#{?@upterm-session,[upterm: #{@upterm-session}],}'
```

## Configuration

Add these options to your `~/.tmux.conf`:

```tmux
# Change the upterm key (default: T)
set -g @upterm-key 'T'
```

## Development

### Prerequisites

Install dependencies using [Nix](https://nixos.org/):

```sh
nix develop
```

Or install manually: `bash`, `tmux`, `upterm`, `bats`

### Running Tests

```sh
bats tests/
```

### Debugging

Enable trace output with the `DEBUG` environment variable:

```sh
DEBUG=1 /path/to/tmux-upterm/scripts/tmux_upterm.sh
```

## License

MIT
