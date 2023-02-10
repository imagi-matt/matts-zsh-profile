timer () {
    local remaining=$1
    local name=""
    if [[ -n "$2" ]]; then
        local name="${2} "
    fi

    echo -e "Starting Timer ${name}"

    while [[ $remaining -gt 0 ]]; do
        echo -ne "Remaining Time: \033[95m${remaining}\033[00m           \r"
        sleep 1
        local remaining=$((remaining - 1))
    done
    echo -ne "\033[32mDone!\033[00m                       \n"

    # TODO: Notifications don't work anymore...
    osascript -e "display notification \"You timer ${name}for ${1}s has finished!\" with title \"${name}Timer Finished\""
}
