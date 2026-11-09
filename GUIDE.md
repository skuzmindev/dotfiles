# Guide: learning this setup

The README says how to install. This says how to **use** it and how to **learn** it without drowning.

The tools stack like this:

```
Ghostty (terminal window)
  └─ zsh + starship (shell, prompt)
       └─ tmux (sessions, windows, panes that survive closing the window)
            ├─ nvim / LazyVim (edit code)
            └─ lazygit (git, also opens inside nvim with <Space>gg)
```

You can learn them in any order, but this one is least painful: **shell → nvim → lazygit → tmux**.

## The rules for learning

1. **Use it for real work from day one.** Tutorials fade; muscle memory comes from needing the thing.
2. **Learn a few keys at a time.** Five new keys per day is plenty. A cheat sheet of 100 keys teaches nothing.
3. **Don't customise yet.** Run the defaults for two weeks. Change only what repeatedly annoys you.
4. **When you do something clumsy, look up the better way once.** Holding `j` to go down 20 lines? Look up `20j`, `}` and `Ctrl-d`. Then use it.
5. **Let the tools teach you.** which-key (nvim), `?` (lazygit) and `prefix ?` (tmux) all list their own keys.

## Week plan

| When | Focus | Done when you can... |
|---|---|---|
| Day 1 | `:Tutor` in nvim (30 min) | move, delete, change, undo, save and quit without thinking |
| Days 2-5 | Edit only in nvim | open a project, find a file, grep, jump around, edit, save |
| Week 2 | Lazygit | commit, push, switch branch, and undo a mistake without leaving it |
| Week 3 | tmux | keep a session running, detach, come back, split panes |
| Week 4 | Customise | add one option, one keymap and one plugin extra, and commit them |

---

## 1. Shell (zsh, starship, eza, fzf)

Already set up in `zsh/.zshrc`. Things you get for free:

| You type | What happens |
|---|---|
| `ll`, `ls`, `la`, `lt` | `eza` listings with icons and git status (`lt` shows a tree) |
| `Ctrl-R` | fuzzy search your command history |
| `Ctrl-T` | fuzzy find a file and paste its path |
| `Alt-C` | fuzzy find a directory and `cd` into it |
| `vi`, `vim` | open nvim |
| `lg` | open lazygit |
| (typing) | grey autosuggestion from history, press `→` to accept |

`Alt-C` does nothing right now: on macOS, Ghostty types `ç` for Option+C unless `macos-option-as-alt = true` is set in `ghostty/.config/ghostty/config`. Add that line if you want it (it also affects Option in nvim and tmux), or ignore it and use `Ctrl-T` / `cd` instead.

## 2. Neovim with LazyVim

### The mental model (read this once)

Vim is **modal**. The same key does different things depending on the mode:

| Mode | Enter with | You are... |
|---|---|---|
| Normal | `Esc` | navigating and issuing commands (the default; live here) |
| Insert | `i`, `a`, `o` | typing text |
| Visual | `v`, `V`, `Ctrl-v` | selecting text |
| Command | `:` | typing an ex command, e.g. `:w` |

Commands are a **grammar**: `verb + object`. Learn the verbs and the objects separately, then combine them.

- Verbs: `d` delete, `c` change, `y` yank (copy), `v` select
- Objects: `w` word, `s` sentence, `p` paragraph, `t"` until a quote, `i"` inside quotes, `i(` inside parens, `ip` inside paragraph
- So: `diw` deletes a word, `ci"` changes the text inside quotes, `yap` copies a paragraph, `dt)` deletes up to the next `)`.
- `.` repeats your last change. This is the most powerful key in Vim. Make a change in a way that `.` can repeat it.

### Survival keys (day 1)

| Key | Action |
|---|---|
| `i` / `a` / `o` | insert before / after / on a new line below |
| `Esc` | back to normal mode |
| `:w` / `:q` / `:wq` / `:q!` | save / quit / both / quit without saving |
| `u` / `Ctrl-r` | undo / redo |
| `h j k l` | left, down, up, right (arrows work too) |
| `x` | delete a character |
| `dd` / `yy` / `p` | delete (cut) line / copy line / paste |

### Moving fast (days 2-5)

| Key | Action |
|---|---|
| `w` / `b` / `e` | next word / previous word / end of word |
| `0` / `^` / `$` | line start / first non-blank / line end |
| `gg` / `G` | file top / bottom |
| `{` / `}` | previous / next blank line |
| `Ctrl-d` / `Ctrl-u` | half page down / up |
| `f<char>` / `;` | jump to a character on the line / repeat |
| `*` | search for the word under the cursor |
| `/text`, `n`, `N` | search, next, previous |
| `%` | jump to the matching bracket |
| `s` + 2 chars | **flash**: jump to any visible spot (LazyVim) |

### LazyVim: the leader key

`<Space>` is the leader. Press it and **wait**; which-key shows a menu of everything. Groups are mnemonic: `f` file, `s` search, `g` git, `c` code, `b` buffer, `x` diagnostics, `u` UI toggles.

| Key | Action |
|---|---|
| `<Space><Space>` | find files |
| `<Space>/` | grep the project |
| `<Space>,` | switch between open buffers |
| `<Space>fr` | recent files |
| `<Space>e` | file explorer |
| `<Space>gg` | lazygit |
| `<Space>sk` | search all keymaps (use this to discover things) |
| `<Space>l` | plugin manager (Lazy) |
| `<Space>cm` | Mason (language servers, formatters) |
| `<Space>qq` | quit everything |

### Code navigation (the IDE part)

Works once a language server is installed (see `:LazyExtras` and Mason).

| Key | Action |
|---|---|
| `gd` | go to definition (`Ctrl-o` goes back) |
| `gr` | find references |
| `K` | hover docs |
| `<Space>ca` | code actions (fixes, imports) |
| `<Space>cr` | rename symbol |
| `<Space>cf` | format file |
| `<Space>xx` | diagnostics list |
| `]d` / `[d` | next / previous diagnostic |
| `gcc` / `gc` + motion | toggle comment |
| `gsa`, `gsd`, `gsr` | add / delete / replace surrounding quotes, brackets |

### Windows and buffers

A **buffer** is an open file. A **window** is a view onto a buffer. Tabs are rarely needed.

| Key | Action |
|---|---|
| `Shift-h` / `Shift-l` | previous / next buffer |
| `<Space>bd` | close buffer |
| `<Space>-` / `<Space>\|` | split below / right |
| `Ctrl-h/j/k/l` | move between windows |
| `<Space>wd` | close window |

### Customising (week 4, not before)

Everything lives in `nvim/.config/nvim/`:

| File | Put here |
|---|---|
| `lua/config/options.lua` | settings (`vim.opt.relativenumber = false`) |
| `lua/config/keymaps.lua` | your own keymaps |
| `lua/plugins/*.lua` | new plugins or overrides of LazyVim's. Delete `example.lua` or edit it. |
| `:LazyExtras` | one-key toggles for language support (TypeScript, Python, Rust...) and tools. Start here before writing plugin config. |
| `lazy-lock.json` | pinned plugin versions. Commit it. Update with `<Space>l` then `U`. |

Because `~/.config/nvim` is a symlink into this repo, edit the files normally, then `git commit` in `~/dotfiles`.

If something breaks: `:checkhealth`, then `:Lazy` and look for red errors. The `lazy-lock.json` in git is your rollback.

## 3. Lazygit

Open with `lg` in any repo, or `<Space>gg` inside nvim. Press `?` in any panel for that panel's keys. Quit with `q`.

Screen: five panels on the left (`1` status, `2` files, `3` branches, `4` commits, `5` stash), diff on the right. Move between them with `Tab`, `[`, `]` or the number keys.

### The daily loop

| Key (files panel) | Action |
|---|---|
| `space` | stage / unstage a file |
| `a` | stage / unstage everything |
| `Enter` | open a file's hunks to stage individual lines (`space` per line) |
| `c` | commit (opens a message box; `Enter` to confirm) |
| `A` | amend the last commit with staged changes |
| `P` | push |
| `p` | pull |
| `d` | discard changes to a file (asks first) |
| `e` | edit the file in nvim |
| `s` | stash |

### Branches

| Key (branches panel) | Action |
|---|---|
| `space` | checkout |
| `n` | new branch |
| `M` | merge the selected branch into the current one |
| `r` | rebase onto the selected branch |
| `d` | delete |

### History tricks (the real reason to use lazygit)

In the commits panel:

| Key | Action |
|---|---|
| `Enter` | see the files in a commit |
| `r` | reword the message |
| `e` | edit (stop at) a commit |
| `s` / `f` | squash / fixup into the commit below |
| `d` | drop a commit |
| `Ctrl-j` / `Ctrl-k` | move a commit down / up |
| `C` then `V` | cherry-pick: copy, then paste on another branch |
| `t` | revert |

Safety net: **`z` undoes your last git action** (and `Ctrl-z` redoes), including bad rebases. Learn this before you try anything fancy.

## 4. tmux

tmux keeps your terminals alive when you close the window or lose SSH. Concepts: a **session** holds **windows** (like tabs), each split into **panes**.

Every command is `Ctrl-b`, release, then the key. Mouse is on, so you can click panes and scroll while you learn.

### From the shell

| Command | Action |
|---|---|
| `tmux new -s work` | new named session |
| `tmux ls` | list sessions |
| `tmux a -t work` | attach (`tmux a` for the latest) |
| `tmux kill-session -t work` | delete it |

### Inside tmux (after `Ctrl-b`)

| Key | Action |
|---|---|
| `d` | **detach** (everything keeps running) |
| `c` | new window |
| `1`-`9` | go to window N (numbering starts at 1) |
| `n` / `p` | next / previous window |
| `,` | rename window |
| `%` / `"` | split side by side / stacked |
| arrow keys | move between panes |
| `z` | zoom a pane full-screen (again to restore) |
| `x` / `&` | close pane / window |
| `s` / `w` | pick a session / window from a tree |
| `[` | copy mode: `/` searches, `Space` starts selecting, `Enter` copies, `q` quits |
| `?` | list every key binding |
| `:` | command prompt |

Simple habit to start: one session per project, nvim in one pane, a shell in another, lazygit in a third window.

## 5. Dotfiles workflow

Every config is a symlink into `~/dotfiles` via stow, so **editing the file in `~/.config/...` edits the repo**.

```sh
cd ~/dotfiles
git status                 # see what you changed
git add -A && git commit   # or open lazygit here: lg
git push
```

Add a new tool's config:

```sh
mkdir -p ~/dotfiles/foo/.config/foo      # package/path-from-$HOME
mv ~/.config/foo/* ~/dotfiles/foo/.config/foo/   # if one already exists
cd ~/dotfiles && stow foo
```

Add the tool to `Brewfile` and the package name to the `stow` line in the README.

## 6. Updating

One command updates everything this repo manages:

```sh
dotup        # alias for ~/dotfiles/update.sh
```

It runs, in order:

1. `brew update`, then installs or upgrades only the formulae in the `Brewfile` (not everything on your machine) and cleans up old versions.
2. `git pull --ff-only` in each zsh plugin under `~/.zsh/plugins/`.
3. Neovim plugins (`:Lazy sync`, which includes LazyVim itself) and treesitter parsers, headless.
4. A reminder to restart tmux if the running server is older than the installed version.

It **never commits**. When it finishes, it prints `git status`. If `nvim/.config/nvim/lazy-lock.json` changed, open nvim and check that things still work. Then commit it (`lg` in `~/dotfiles`). The "already installed" warnings from brew are harmless.

Not covered by the script, so do these by hand now and then:

| What | How |
|---|---|
| Mason tools (language servers, formatters) | `:Mason`, then `U` |
| Ghostty | Ghostty menu, Check for Updates (it was installed manually, not via brew) |
| LazyVim starter files (`init.lua`, `lua/config/*`) | never auto-update; skim lazyvim.org/news for breaking changes |

If an nvim update breaks something:

```sh
cd ~/dotfiles && git checkout nvim/.config/nvim/lazy-lock.json   # back to the committed versions
# then in nvim: :Lazy restore
```

After upgrading tmux, detach and run `tmux kill-server`. Otherwise the old server keeps running and a newer client can refuse to attach ("protocol version mismatch").

Rhythm: run `dotup` about once a month, use nvim for a day, then commit the lockfile.

## Where to learn more

| Resource | Use it for |
|---|---|
| `:Tutor` or `vimtutor` | the first 30 minutes, always |
| `:help user-manual` | the official, surprisingly readable manual (`:help <topic>`, `Ctrl-]` follows links) |
| lazyvim.org | LazyVim keymaps, extras and configuration |
| `<Space>sk` | search every keymap actually loaded on your machine. It beats any list, including this one. |
| `?` in lazygit, `Ctrl-b ?` in tmux | each tool's own live cheat sheet |
| github.com/jesseduffield/lazygit (docs/) | full lazygit keybinding reference |
| *Practical Vim* (Drew Neil) | the book to read once the basics feel natural |
| vim-be-good (nvim plugin), vim-adventures.com | drills and games for motions |

Keys in LazyVim can change between versions. If a key here doesn't work, trust which-key and `<Space>sk` over this file, then fix the file.
