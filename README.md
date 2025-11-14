# Luca's dotfiles

Personal dotfiles and setup scripts for my environment. The installer bootstraps
prerequisites and lets chezmoi apply the configs to your home directory
alongside optional tooling (oh-my-zsh, tmux helpers, etc.).

## Requirements

- macOS recommended (tested only on Apple Silicon :) ). However, a tmux config
  for Linux is included.
- Homebrew installed and on PATH: <https://brew.sh>
- Git for cloning.
- Targeted applications (_optional_): tmux, Kitty, Ghostty, Zathura, Starship,
  AeroSpace, Borders.

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

- Runs pre-scripts to ensure required tools are present via Homebrew (chezmoi,
  zsh, git, Tmuxinator).
- Uses chezmoi (with this repo as the source state) to write/update dotfiles in
  your home directory.
- Runs post-scripts (oh-my-zsh install, optional default shell change on macOS,
  reload tmux config, Neovim Python/Node clients).

Use standard chezmoi commands for day-to-day management, for example:

```bash
chezmoi --source="$(pwd)" --destination="$HOME" diff
chezmoi --source="$(pwd)" --destination="$HOME" apply
```

## What gets linked

- Zsh: `dot_zshrc` → `~/.zshrc`
- Fish (optional): `dot_config/fish/config.fish` → `~/.config/fish/config.fish`
- Tmux (auto-selects per OS):
  - macOS: `dot_tmux.conf` → `~/.tmux.conf`
  - Linux: `dot_tmux.linux.conf` → `~/.tmux.conf`
- Kitty: `dot_config/kitty/kitty.conf` → `~/.config/kitty/kitty.conf`
- Zathura: `dot_config/zathura/zathurarc` → `~/.config/zathura/zathurarc`
- Starship: `dot_config/starship.toml` → `~/.config/starship.toml`
- AeroSpace: `dot_aerospace.toml` → `~/.aerospace.toml`
- Borders: `dot_config/borders/bordersrc` → `~/.config/borders/bordersrc`
- Ghostty: `dot_config/ghostty/config` → `~/.config/ghostty/config`
- Ghostty helper: `dot_config/ghostty/tmux-attach.sh` →
  `~/.config/ghostty/tmux-attach.sh`

## Notes and behavior

- Homebrew is required for automated installs in pre/post scripts. If missing,
  scripts will print a helpful message and skip where possible.
- The installer is idempotent; rerunning `make install` just feeds the repo back
  through `chezmoi apply`.
- On macOS, zsh (`$(command -v zsh)`) can be set as your default login shell
  with sudo. If it isn’t in `/etc/shells`, the installer appends it
  automatically.
- Tmux reload is best-effort; if tmux isn’t running, the step is skipped.

## Troubleshooting

- “Homebrew not found”: install from <https://brew.sh> and re-run
  `make install`.
- “chezmoi not found”: install via Homebrew (`brew install chezmoi`) or re-run
  the installer to auto-install it.
- oh-my-zsh didn’t install: ensure `git` is available (`brew install git`) and
  re-run.
- Kitty/Ghostty/Zathura not picking up config: make sure the apps are installed
  and look in the linked paths above.

## Uninstall / revert

This repo is applied through chezmoi. To revert, use
`chezmoi apply --include=... --dry-run` to preview changes or `chezmoi destroy`
to remove managed files.

## License

MIT — see [LICENSE](LICENSE).
