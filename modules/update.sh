update () {
    local current_pwd="$PWD"

    cd "$HOME/.zsh_profile.d" || exit 1
    command git pull

    cd "$current_pwd" || cd "$HOME" || exit 1

    source "$HOME/.zshrc"
    echo -e "\033[32mProfile updated\033[39m"
}
