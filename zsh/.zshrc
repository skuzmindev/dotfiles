# ==============================================================================
# PRO-LEVEL DEVELOPER SELF-HEALING ZSH CONFIGURATION
# ==============================================================================

# --- 1. AUTOMATIC PLUGINS SYSTEM (Self-Healing Bootstrap) ---------------------
PLUGINS_DIR="$HOME/.zsh/plugins"

ensure_plugin() {
  local repo_url=$1
  local target_dir="$PLUGINS_DIR/$2"
  if [ ! -d "$target_dir" ]; then
    echo "📦 Dotfiles: Installing plugin $2..."
    git clone --depth 1 "$repo_url" "$target_dir" 2>/dev/null || true
  fi
}

# Auto-download core dependencies if missing
ensure_plugin "https://github.com" "fast-syntax-highlighting"
ensure_plugin "https://github.com" "zsh-autosuggestions"


# Source active plugins into terminal memory safely
[ -f "$PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && source "$PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[ -f "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ] && source "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"


# --- 2. KEYBINDINGS & AUTOCOMPLETE TWEAKS ------------------------------------
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8" # Custom dim grey helper text

# --- 3. MODERN EZA ALIASES (Native Out-of-the-Box Colors) ---------------------
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=auto --color=auto --group-directories-first'
  alias ll='eza -la --icons=auto --color=auto --group-directories-first --header --git'
  alias la='eza -a --icons=auto --color=auto --group-directories-first'
  alias lt='eza --tree --level=2 --icons=auto --group-directories-first'
fi

# --- 4. FLUID FZF OPTIMIZATIONS -----------------------------------------------
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="
    --height=45% 
    --layout=reverse 
    --border 
    --inline-info
    --preview 'cat {} | head -50 2>/dev/null || tree -C {} | head -50'
  "
  eval "$(fzf --zsh)"
fi

# --- 5. STARSHIP PROMPT CONFIGURATION -----------------------------------------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
