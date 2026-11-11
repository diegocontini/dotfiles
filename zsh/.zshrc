# Keep machine-specific additions out of this shared file. Source ~/.zshrc.local
# below for local PATH entries, SDK managers, or other unshared settings.

export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# Starship provides the prompt independently of Oh My Zsh themes.
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Keep common interactive behavior consistent across machines.
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
