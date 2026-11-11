# Dotfiles

Portable Zsh and WezTerm configuration for Linux Mint and macOS.

## Contents

- `zsh/.zshrc`: Oh My Zsh, Starship and common plugins.
- `starship/starship.toml`: shared Starship prompt settings.
- `wezterm/wallpaper.png`: terminal background image.
- `wezterm/wezterm.lua`: terminal appearance and cross-platform settings.
- `config.yaml`: Dotdrop mapping and Linux/macOS profiles.
- `install.sh`: installs dependencies and runs Dotdrop.

## Install

Clone this repository to `~/git/dotfiles`. Homebrew is required on macOS. Install WezTerm using its official Linux instructions if it is not already present on Linux Mint.

Run the setup script:

```sh
./install.sh
```

The script installs missing system tools, Oh My Zsh, Starship, Dotdrop, Fira Code, and the two Zsh plugins. Dotdrop applies the `linux` or `macos` profile as absolute symlinks and backs up existing files that differ. On Linux Mint, package installation may ask for your `sudo` password. On macOS, the script uses Homebrew to install WezTerm. Open a new shell to use the setup. This repo does not include machine-specific secrets or API keys.

## Updating

```sh
git pull
dotdrop install --cfg config.yaml --profile linux  # use macos on macOS
```

Configuration changes take effect in new shell sessions. WezTerm reloads its Lua config automatically when possible.
