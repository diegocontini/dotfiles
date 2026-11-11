# Dotfiles

Portable Zsh and WezTerm configuration for Linux Mint and macOS.

## Contents

- `zsh/.zshrc`: Oh My Zsh, Starship and common plugins.
- `starship/starship.toml`: shared Starship prompt settings.
- `wezterm/wallpaper.png`: terminal background image.
- `wezterm/wezterm.lua`: terminal appearance and cross-platform settings.
- `install.sh`: backs up existing config files and links these files into place.

## Install

Install Zsh, Git and Starship with your system package manager, then install Oh My Zsh using its official installer. Install the Zsh plugins listed in `.zshrc` under `$ZSH_CUSTOM` (or use the platform package manager where available). On macOS with Homebrew: `brew install starship`.

Install WezTerm using the official instructions for your OS. On macOS, install a Nerd Font such as MesloLGS NF and select it in WezTerm. The config uses the same font when available; Linux can use any installed Nerd Font by changing `font` in `wezterm/wezterm.lua`.

Run the setup script:

```sh
./install.sh
```

The script installs missing system tools (Zsh, Git, and cURL), Oh My Zsh, Starship, and the two Zsh plugins, then links the shared config files. On Linux Mint, it uses `apt` and may ask for your `sudo` password; install WezTerm from its [official Linux instructions](https://wezterm.org/install/linux.html) if it is not already present. On macOS, it uses Homebrew to install Zsh and WezTerm. It keeps existing config files as timestamped backups. Open a new shell to use the setup. This repo does not include machine-specific secrets or API keys.

## Updating

```sh
git pull
```

Configuration changes take effect in new shell sessions. WezTerm reloads its Lua config automatically when possible.
