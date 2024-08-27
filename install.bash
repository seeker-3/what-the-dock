set -euo pipefail

OMZ_PLUGINS_DIR=~/.oh-my-zsh/custom/plugins

OMZ_URL=https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
AUTOUPDATE_REPO=https://github.com/tamcore/autoupdate-oh-my-zsh-plugins.git
ZSH_AUTOSUGGEST_REPO=https://github.com/zsh-users/zsh-autosuggestions.git
ZSH_SYNTAX_HIGHLIGHTING_REPO=https://github.com/zsh-users/zsh-syntax-highlighting.git

install_omz() {
    curl -fsSL "$OMZ_URL" | sh
    git clone "$AUTOUPDATE_REPO" $OMZ_PLUGINS_DIR/autoupdate
    git clone "$ZSH_AUTOSUGGEST_REPO" $OMZ_PLUGINS_DIR/zsh-autosuggestions
    git clone "$ZSH_SYNTAX_HIGHLIGHTING_REPO" $OMZ_PLUGINS_DIR/zsh-syntax-highlighting
    sed -i \
        's/plugins=(\(.*\))/plugins=(\1 autoupdate zsh-autosuggestions zsh-syntax-highlighting)/' \
        ~/.zshrc
    chsh -s /bin/zsh
}

if command -v apt-get >/dev/null; then
    apt-get update
    apt-get upgrade -y
    apt-get install -y zsh git curl
    install_omz
else
    echo 'Unrecognized package manager' >&2
fi
