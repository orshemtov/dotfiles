# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Completion
autoload -Uz compinit
compinit

# Carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
export LS_COLORS=$(vivid generate catppuccin-mocha)

source <(carapace _carapace)

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# Editor
export EDITOR="nvim"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"

# pnpm
export PNPM_HOME="/Users/or/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Zoxide
alias cd="z"
eval "$(zoxide init zsh)"

# eza
ls() {
  local flags=(
    -lSb 
    --icons 
    --no-time 
    --no-filesize 
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
alias lh="ls -a"
alias lt="ls --tree"
alias lth="ls --tree -a"

# clear
alias clear='clear && printf "\033c"'
alias c="clear"

# bat
alias cat="bat"

# Git
alias g="lazygit"

# cargo
. "$HOME/.cargo/env"

# UUID
alias uuid='command uuidgen | tr "[:upper:]" "[:lower:]"'

# Starship
eval "$(starship init zsh)"

