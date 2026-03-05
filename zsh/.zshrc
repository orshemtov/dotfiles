# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/or/.zsh/completions:"* ]]; then export FPATH="/Users/or/.zsh/completions:$FPATH"; fi
# Editor
export EDITOR="nvim"

# Ctrl-R = reverse history search
bindkey '^R' history-incremental-search-backward
bindkey -M viins '^R' history-incremental-search-backward  # safe even if not in vi mode

# Homebrew (inlined)
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Completion (cached daily)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zmodload zsh/complist

# Starship
eval "$(starship init zsh)"

# direnv
eval "$(direnv hook zsh)"

# pyenv (lazy-loaded)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
_pyenv_lazy_load() {
  unset -f pyenv python python3 pip pip3
  eval "$(pyenv init - zsh)"
}
pyenv() { _pyenv_lazy_load && pyenv "$@"; }
python() { _pyenv_lazy_load && python "$@"; }
python3() { _pyenv_lazy_load && python3 "$@"; }
pip() { _pyenv_lazy_load && pip "$@"; }
pip3() { _pyenv_lazy_load && pip3 "$@"; }

# nvm (lazy-loaded)
export NVM_DIR="$HOME/.nvm"
_nvm_lazy_load() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

nvm() { _nvm_lazy_load && nvm "$@"; }
node() { _nvm_lazy_load && node "$@"; }
npm() { _nvm_lazy_load && npm "$@"; }
npx() { _nvm_lazy_load && npx "$@"; }

. "$HOME/.local/bin/env"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# cargo
. "$HOME/.cargo/env"

# LS_COLORS (cached weekly)
_vivid_cache="$HOME/.cache/vivid-ls-colors"
if [[ ! -f "$_vivid_cache" ]] || [[ -n "$_vivid_cache"(#qN.mh+168) ]]; then
  mkdir -p "$HOME/.cache"
  vivid generate catppuccin-mocha > "$_vivid_cache"
fi
export LS_COLORS="$(<$_vivid_cache)"

# fzf
source <(fzf --zsh)

# Carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace zsh)

# Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Zoxide
eval "$(zoxide init zsh)"

# eza
ls() {
  local flags=(
    -lb 
    --icons 
    --header
    --no-user 
    --no-permissions 
    --group-directories-first 
    --show-symlinks
    --git-ignore 
    -s=type 
  )
  eza "${flags[@]}" "$@"
}

alias l="ls"
alias ll="ls -l"
alias lh="ls -a"
alias lt="ls --tree --no-time --no-filesize -a"
alias lts="ls --total-size"

# clear
alias clear='clear && printf "\033[3J\033[H\033[2J"'
alias c="clear"

# LazyGit
alias lg="lazygit"

# UUID
alias uuid='command uuidgen | tr "[:upper:]" "[:lower:]"'

alias copy="pbcopy"

# Android SDK
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
. "/Users/or/.deno/env"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# ocx (opencode)
alias oc="ocx oc"
