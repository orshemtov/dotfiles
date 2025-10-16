# Editor
export EDITOR="nvim"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Completion
autoload -U compinit && compinit
zmodload zsh/complist

# Starship
eval "$(starship init zsh)"

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
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# cargo
. "$HOME/.cargo/env"

# Carapace
export LS_COLORS="$(vivid generate catppuccin-mocha)"

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
eval "$(carapace _carapace)"

bindkey '^I' complete-word
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{blue}%d%f'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# Sesh
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

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
alias clear='clear && printf "\033[3J\033[H\033[2J"'
alias c="clear"

# bat
alias cat="bat"

# LazyGit
alias g="lazygit"

# UUID
alias uuid='command uuidgen | tr "[:upper:]" "[:lower:]"'

