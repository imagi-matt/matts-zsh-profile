docker () {
    if [[ $1 == "ssh" || $1 == "down" ]]; then
        local image="$2"
        local container_id=${"$(command docker ps | grep "$image")":0:12}

        if [[ -n "${container_id}" ]]; then
            if [[ $1 == "ssh" ]]; then
                command docker exec -it "$container_id" /bin/bash
            elif [[ $1 == "down" ]]; then
                command docker kill "$container_id"
                command docker rm -v "$container_id"
            fi
        else
            echo "Container for $image not found"
        fi

    else
        command docker $@
    fi
}
