alias gs='git status -s'
alias gb='git branch'
alias gc='git commit'

git () {
    if [[ $1 == "pull" ]]; then
        command git fetch -p && command git pull

    elif [[ $1 == "hash" ]]; then
        if [[ -n "$2" ]]; then
	    local hash="$2"
        else
            local hash=$(git log | head -n 1 | cut -d' ' -f2)
        fi

        echo -e "${hash:0:11}  \033[90m- copied to clipboard\033[00m"
	    echo -n "${hash:0:11}" | pbcopy

    elif [[ $1 == "checkout" ]]; then
        command git $@;
        if [[ ! "$2" =~ ^- ]]; then
            if (command git stash list | grep -q "$2"); then
                echo -e "\033[32mFound stash for this branch\033[39m"
                command git stash list | grep "$2"
            fi
        fi

    elif [[ $1 == "author" ]]; then
        if [[ $2 == "commits" ]]; then

            echo -e -n "\033[90m"
            echo -e "Commits\tAuthor <email>"
            echo -e -n "\033[00m"

            command git shortlog -sne
        else
            echo -e -n "\033[90m"
            echo "Author <email>"
            echo -e -n "\033[00m"

            git log --pretty="%an <%ae>%n%cn <%ce>" --expand-tabs | sort -u
        fi
    
    else
        # shellcheck disable=SC2068
        command git $@
    fi
}
