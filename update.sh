#!/usr/bin/env bash
# Update everything this repo manages. Does not commit: review `git status`, then commit lazy-lock.json.
set -euo pipefail
cd "$(dirname "$0")"

echo "==> brew"
brew update
# only the formulae listed in the Brewfile, not everything on the machine;
# `brew install` installs missing ones and upgrades outdated ones
brew install $(awk -F'"' '/^brew /{print $2}' Brewfile)
brew cleanup

echo "==> zsh plugins"
for d in ~/.zsh/plugins/*/; do git -C "$d" pull --ff-only; done

echo "==> nvim plugins and treesitter parsers"
nvim --headless "+Lazy! sync" "+lua require('nvim-treesitter').update():wait(300000)" +qa
echo

# a running tmux server keeps the old version until restarted
if tmux info >/dev/null 2>&1 && [ "$(tmux display-message -p '#{version}')" != "$(tmux -V | cut -d' ' -f2)" ]; then
  echo "NOTE: tmux was upgraded; detach and run 'tmux kill-server' to pick it up."
fi

echo "==> done; changes in the repo:"
git status --short
