#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_system_tools() {
  case "$(uname -s)" in
    Darwin)
      if ! command -v brew >/dev/null 2>&1; then
        echo 'Homebrew is required on macOS. Install it from https://brew.sh and rerun.' >&2
        exit 1
      fi
      local missing=()
      for tool in zsh git curl; do
        command -v "$tool" >/dev/null 2>&1 || missing+=("$tool")
      done
      ((${#missing[@]} == 0)) || brew install "${missing[@]}"
      brew list --cask wezterm >/dev/null 2>&1 || brew install --cask wezterm
      ;;
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        local missing=()
        for tool in zsh git curl; do
          command -v "$tool" >/dev/null 2>&1 || missing+=("$tool")
        done
        if ((${#missing[@]})); then
          sudo apt-get update
          sudo apt-get install -y "${missing[@]}"
        fi
      else
        echo 'Install zsh, git, and curl with your Linux package manager, then rerun.' >&2
        exit 1
      fi
      if ! command -v wezterm >/dev/null 2>&1; then
        echo 'WezTerm is not installed. Install it using the official Linux instructions: https://wezterm.org/install/linux.html'
      fi
      ;;
    *)
      echo "Unsupported operating system: $(uname -s)" >&2
      exit 1
      ;;
  esac
}

install_oh_my_zsh() {
  if [[ -s "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
    echo 'Oh My Zsh already installed.'
  else
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

backup_and_link() {
  local source="$1" target="$2"
  mkdir -p "$(dirname "$target")"
  if [[ -e "$target" && ! -L "$target" ]]; then
    mv "$target" "$target.backup.$(date +%Y%m%d%H%M%S)"
  elif [[ -L "$target" ]]; then
    rm "$target"
  fi
  ln -s "$source" "$target"
}

install_starship() {
  if command -v starship >/dev/null 2>&1; then
    echo 'Starship already installed.'
    return
  fi

  if command -v brew >/dev/null 2>&1; then
    brew install starship
  else
    mkdir -p "$HOME/.local/bin"
    curl -sS https://starship.rs/install.sh | sh -s -- -b "$HOME/.local/bin"
  fi
}

clone_plugin() {
  local repo="$1" name="$2" dest="$ZSH_CUSTOM/plugins/$2"
  if [[ -d "$dest/.git" ]]; then
    echo "$name already installed."
  else
    mkdir -p "$ZSH_CUSTOM/plugins"
    git clone --depth=1 "https://github.com/$repo.git" "$dest"
  fi
}

install_system_tools
install_oh_my_zsh
install_starship
clone_plugin zsh-users/zsh-autosuggestions zsh-autosuggestions
clone_plugin zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting

backup_and_link "$ROOT/zsh/.zshrc" "$HOME/.zshrc"
backup_and_link "$ROOT/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
backup_and_link "$ROOT/wezterm/wallpaper.png" "$HOME/.config/wezterm/wallpaper.png"
backup_and_link "$ROOT/starship/starship.toml" "$HOME/.config/starship.toml"
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  if ! grep -Fq 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc.local" 2>/dev/null; then
    printf '\n# User-installed command line tools\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$HOME/.zshrc.local"
  fi
fi
printf 'Linked dotfiles from %s\n' "$ROOT"
echo 'Start a new Zsh session to apply the setup.'
