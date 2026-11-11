# Dotfiles

Configura Zsh com Oh My Zsh e Starship, além do WezTerm com Fira Code, Catppuccin Mocha e wallpaper. O Dotdrop cria os links para os arquivos do repositório e guarda backup de configurações existentes.

## Preparar o sistema

**macOS** (com Homebrew):

```sh
brew install dotdrop starship
brew install --cask wezterm font-fira-code
```

**Linux Mint** (com Homebrew):

```sh
sudo apt install zsh fonts-firacode
brew install dotdrop starship
```

No Linux, instale também o [WezTerm](https://wezterm.org/install/linux.html) se ainda não estiver instalado.

## Clonar e aplicar

```sh
mkdir -p ~/git
git clone git@github.com:diegocontini/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles

test -d ~/.oh-my-zsh || RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
test -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions || git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
test -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting || git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Mac: use macos. Linux Mint: troque por linux.
dotdrop install --cfg config.yaml --profile macos
```

Abra uma nova sessão do Zsh após aplicar.
