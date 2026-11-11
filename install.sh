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
      brew list --cask font-fira-code >/dev/null 2>&1 || brew install --cask font-fira-code
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
      if [[ "$(fc-match -f '%{family}' 'Fira Code' 2>/dev/null)" != *'Fira Code'* ]]; then
        sudo apt-get install -y fonts-firacode
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

install_dotdrop() {
  if command -v dotdrop >/dev/null 2>&1; then
    return
  fi
  if command -v brew >/dev/null 2>&1; then
    brew install dotdrop
  else
    sudo apt-get update
    sudo apt-get install -y dotdrop
  fi
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
install_dotdrop
clone_plugin zsh-users/zsh-autosuggestions zsh-autosuggestions
clone_plugin zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting

case "$(uname -s)" in
  Darwin) profile=macos ;;
  Linux) profile=linux ;;
esac
dotdrop install --cfg "$ROOT/config.yaml" --profile "$profile" --no-prompt
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  if ! grep -Fq 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc.local" 2>/dev/null; then
    printf '\n# User-installed command line tools\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$HOME/.zshrc.local"
  fi
fi
printf 'Applied dotfiles from %s with Dotdrop\n' "$ROOT"
echo 'Start a new Zsh session to apply the setup.'
