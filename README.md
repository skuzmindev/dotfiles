# dotfiles

Managed with [GNU stow](https://www.gnu.org/software/stow/). Each top-level folder is a package that mirrors `$HOME`.

## Setup

```sh
brew install stow git
git clone https://github.com/sersergious/dotfiles ~/dotfiles
cd ~/dotfiles && brew bundle
stow zsh starship ghostty nvim lazygit tmux
```

`brew bundle` installs everything in `Brewfile` (CLI tools plus Ghostty; if Ghostty was installed manually, bundle errors on that one line, which is harmless). First `nvim` launch installs plugins, parsers and Mason tools. Machine-specific config (PATH etc.) goes in `~/.zshrc.local`, which is not tracked.

Update everything (brew, zsh plugins, nvim plugins) with `dotup`, which runs `update.sh`. It does not commit; see `GUIDE.md`.

## Layout

| Package | Links to |
|---|---|
| `zsh` | `~/.zshrc` (sets `EDITOR=nvim`, `LG_CONFIG_FILE`, aliases `vi`, `vim`, `lg`) |
| `nvim` | `~/.config/nvim` (LazyVim starter) |
| `lazygit` | `~/.config/lazygit` (zsh points `LG_CONFIG_FILE` here; macOS default is elsewhere) |
| `tmux` | `~/.config/tmux/tmux.conf` |
| `ghostty`, `starship` | `~/.config/ghostty`, `~/.config/starship.toml` |

## Cheat sheet

**Neovim / LazyVim** (`<leader>` = `Space`; press it and wait for the which-key menu)

| Key | Action |
|---|---|
| `Space Space` | find files |
| `Space /` | grep project |
| `Space e` | file tree |
| `Space g g` | lazygit |
| `Space l` | plugin manager |
| `:Tutor` | built-in tutorial |
| `:LazyVim` | docs / extras |

**Lazygit** (`lg`; press `?` in any panel)

| Key | Action |
|---|---|
| `space` | stage / unstage |
| `c` | commit |
| `P` / `p` | push / pull |
| `Enter` | open file or commit |
| `e` | edit in nvim |

**tmux** (prefix `Ctrl-b`)

| Key | Action |
|---|---|
| `c` | new window |
| `%` / `"` | split vertical / horizontal |
| `d` | detach (`tmux a` to reattach) |
| `[` | copy mode (`q` to leave) |
