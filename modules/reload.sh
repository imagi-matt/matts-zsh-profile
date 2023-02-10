reload () {
    echo -e -n "\033[90m"
    source "$HOME/.zshrc" 2> /dev/null
    echo -e "\033[32mProfile reloaded\033[39m"
}
