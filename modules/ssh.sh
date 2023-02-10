ssh () {
    local success=false
    local wait=false

    if [[ -z $1 ]]; then
        return
    fi

    if (nc -vz "$1" 22 &> /dev/null); then
        local success=true
    else
        local wait=true
        echo "Waiting for port to open..."
    fi

    while [[ "$success" == false ]]; do
        if (nc -vz "$1" 22 &> /dev/null); then
            echo "Port open!"
            local success=true
        else
            sleep 10
        fi
    done

    if [[ "$wait" = true ]]; then
        echo "Connecting to $1 ..."
        osascript -e "display notification \"Successfully logged into ${1}!\" with title \"Connected to ${1}\""
    fi

    if [[ "$success" = true ]]; then
        # shellcheck disable=SC2068
        command ssh $@
    fi
}
