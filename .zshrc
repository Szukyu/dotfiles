# Zinit Directory and Plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit If It's Not There Yet 
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Zsh Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load Completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Keybinds
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# HomeBrew
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Starship
eval "$(starship init zsh)"

# Alias
alias ls="eza --color=always --icons --group-directories-first"
alias ll="eza --color=always --icons --group-directories-first --all --long"
alias mkdir="mkdir -vp"
alias mv="mv -iv"
alias cp="cp -riv"

# Shell Integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Update
update() {
  echo "[update] Nix"
  nix flake update --flake ~/.config/nix
  darwin-rebuild switch --flake ~/.config/nix#tsukuyomi

  echo "[update] Homebrew"
  brew update
  brew upgrade

  # echo "[update] Cleaning Brew"
  # brew cleanup -s
  # brew bundle dump --describe --force 
}
