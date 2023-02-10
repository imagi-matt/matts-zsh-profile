# Enabled.ini loads in modules dynamically if enabled

local regex='^([a-zA-Z0-9\-]+)=([0,1])$'

echo -e -n "\033[90m"

while IFS="" read -r setting; do
    local match=($(grep -Eo "$regex" <<<"$setting"))
    if [[ -z "${match[1]}" ]]; then
        continue
    fi

    local parts=($(grep -Eo '[a-zA-Z0-9\-]+|[=]' <<<"$setting"))

    if [[ "${parts[3]}" == "1" ]]; then
        if [[ -f "$HOME/.zsh_profile.d/modules/${parts[1]}.sh" ]]; then
            if result=$(source "$HOME/.zsh_profile.d/modules/${parts[1]}.sh" 2>&1); then
                source "$HOME/.zsh_profile.d/modules/${parts[1]}.sh"
                echo "\033[32m${parts[1]}\033[90m: Enabled"
            else
                echo "\033[31m${parts[1]}\033[90m: Error - $result"
            fi
        else
            echo "\033[33m${parts[1]}\033[90m: Missing"
        fi
    else
        echo "${parts[1]}: Disabled"
    fi

done < "$HOME/.zsh_profile.d/enabled.ini"

echo -e "\033[00m"


# Provided Autocompletion
## TODO: Not sure if this works anymore
autoload -Uz compinit && compinit
