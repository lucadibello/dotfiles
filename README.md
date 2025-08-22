# Luca's dotfiles

Personal dotfiles and setup scripts for my environment. The installer links configs into your home directory and optionally installs a few tools and Fish plugins.

## Requirements

- macOS recommended (tested only on Apple Silicon :) ). However, a tmux config for Linux is included.
- Homebrew installed and on PATH: <https://brew.sh>
- Git for cloning.
- Targeted applications (_optional_): tmux, Kitty, Ghostty, Zathura, Starship, AeroSpace, Borders.

## Install

1. Clone the repo

```bash
git clone https://github.com/lucadibello/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run the installer

```bash
make install
```

What happens:

- Runs pre-scripts to ensure required tools are present via Homebrew (Fish shell, Fisher, Tmuxinator).
- Creates symlinks for configs below (prompts before replacing existing real files; replaces existing symlinks automatically).
- Runs post-scripts (Fish plugin installation/config, optional default shell change on macOS, reload tmux config).

## What gets linked

- Fish: `config.fish` → `~/.config/fish/config.fish`
- Tmux (auto-selects per OS):
  - macOS: `.tmux.conf` → `~/.tmux.conf`
  - Linux: `.tmux.linux.conf` → `~/.tmux.conf`
- Kitty: `kitty.conf` → `~/.config/kitty/kitty.conf`
- Zathura: `zathurarc` → `~/.config/zathura/zathurarc`
- Starship: `starship.toml` → `~/.config/starship.toml`
- AeroSpace: `.aerospace.toml` → `~/.aerospace.toml`
- Borders: `bordersrc` → `~/.config/borders/bordersrc`
- Ghostty: `ghostty.config` → `~/.config/ghostty/config`
- Ghostty helper: `scripts/tmux/tmux-attach.sh` → `~/.config/ghostty/tmux-attach.sh`

## Notes and behavior

- Homebrew is required for automated installs in pre/post scripts. If missing, scripts will print a helpful message and skip where possible.
- The installer is idempotent; re-running updates symlinks safely.
- On macOS, Fish can be set as your default login shell (`/opt/homebrew/bin/fish`) with sudo. If Fish isn’t in `/etc/shells`, it will be appended.
- Tmux reload is best-effort; if tmux isn’t running, the step is skipped.

## Troubleshooting

- “Homebrew not found”: install from <https://brew.sh> and re-run `make install`.
- Fish plugins didn’t install: ensure `fish` and `fisher` are available (`brew install fish fisher`) and re-run.
- Kitty/Ghostty/Zathura not picking up config: make sure the apps are installed and look in the linked paths above.

## Uninstall / revert

This repo uses symlinks. To revert, remove the symlinks listed above and restore/replace your own configs. Example:

```bash
rm -f ~/.tmux.conf ~/.config/fish/config.fish ~/.config/kitty/kitty.conf \
      ~/.config/zathura/zathurarc ~/.config/starship.toml ~/.aerospace.toml \
      ~/.config/borders/bordersrc ~/.config/ghostty/config ~/.config/ghostty/tmux-attach.sh
```

## License

MIT — see [LICENSE](LICENSE).
