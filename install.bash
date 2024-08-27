set -euo pipefail

OMZ_PLUGINS_DIR=~/.oh-my-zsh/custom/plugins

PLUGINS=(
    tamcore/autoupdate-oh-my-zsh-plugins
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting
    "$@"
)

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

install_omz2() {
    curl -fsSL "$OMZ_URL" | sh

    local plugin
    for plugin in "${PLUGINS[@]}"; do
        local package_name=${plugin##*/}
        git clone "https://github.com/$plugin.git" "$OMZ_PLUGINS_DIR/$package_name"
        sed -i \
            "s/plugins=(\(.*\))/plugins=(\1 $package_name)/" \
            ~/.zshrc
    done

    chsh -s /bin/zsh
}

if command -v apt-get >/dev/null; then
    apt-get update
    apt-get upgrade -y
    apt-get install -y zsh git curl
    install_omz2
else
    echo 'Unrecognized package manager' >&2
fi
