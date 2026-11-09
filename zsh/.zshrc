PLUGINS_DIR="$HOME/.zsh/plugins"

ensure_plugin() {
  local repo_url=$1
  local target_dir="$PLUGINS_DIR/$2"
  if [ ! -d "$target_dir" ]; then
    echo "Installing zsh plugin $2..."
    git clone --depth 1 "$repo_url" "$target_dir" 2>/dev/null || true
  fi
}

ensure_plugin "https://github.com/zdharma-continuum/fast-syntax-highlighting" "fast-syntax-highlighting"
ensure_plugin "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions"

[ -f "$PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && source "$PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[ -f "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ] && source "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=auto --color=auto --group-directories-first'
  alias ll='eza -la --icons=auto --color=auto --group-directories-first --header --git'
  alias la='eza -a --icons=auto --color=auto --group-directories-first'
  alias lt='eza --tree --level=2 --icons=auto --group-directories-first'
fi

if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="
    --height=45%
    --layout=reverse
    --border
    --inline-info
    --preview '[ -d {} ] && tree -C {} | head -50 || head -50 {}'
  "
  eval "$(fzf --zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim VISUAL=nvim
  alias vi=nvim vim=nvim
fi

if command -v lazygit >/dev/null 2>&1; then
  export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"
  alias lg=lazygit
fi

# Machine-specific config (PATH etc.), not tracked in this repo
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
