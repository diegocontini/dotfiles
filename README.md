# Dotfiles

Portable Zsh and WezTerm configuration for Linux Mint and macOS.

## Contents

- `zsh/.zshrc`: Oh My Zsh, Starship and common plugins.
- `starship/starship.toml`: shared Starship prompt settings.
- `wezterm/wallpaper.png`: terminal background image.
- `wezterm/wezterm.lua`: terminal appearance and cross-platform settings.
- `config.yaml`: Dotdrop mapping and Linux/macOS profiles.

## Install

Clone this repository to `~/git/dotfiles`. Install Dotdrop, Zsh, Oh My Zsh, Starship, Fira Code, WezTerm, and the two Zsh plugins once on each machine. On macOS with Homebrew:

```sh
brew install dotdrop zsh starship
brew install --cask wezterm font-fira-code
```

On Linux Mint with Homebrew:

```sh
sudo apt install zsh fonts-firacode
brew install dotdrop starship
```

Install WezTerm from its [official Linux instructions](https://wezterm.org/install/linux.html) if needed.

Install Oh My Zsh with its [official instructions](https://ohmyz.sh/#install), then clone the two plugins into its custom plugin directory:

```sh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
```

Apply the configuration with Dotdrop from the repository root:

```sh
dotdrop install --cfg config.yaml --profile macos  # use linux on Linux Mint
```

Dotdrop creates absolute symlinks and backs up existing files that differ. Open a new shell to use the setup. This repo does not include machine-specific secrets or API keys.

## Updating

```sh
git pull
dotdrop install --cfg config.yaml --profile linux  # use macos on macOS
```

Configuration changes take effect in new shell sessions. WezTerm reloads its Lua config automatically when possible.
