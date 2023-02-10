ansible-vault () {
    VAULT_ID="/location/key"

    ACTION=False
    if [[ $1 == "decrypt" ]]; then
        ACTION=decrypt
    elif [[ $1 == "edit" ]]; then
        ACTION=edit
    elif [[ $1 == "encrypt" ]]; then
        ACTION=encrypt
    else
        echo -e "Action not supported.\nPlease use one of the following:\n - decrypt\n - edit\n - encrypt\n\nOtherwise use the default command"
    fi

    if [[ $ACTION != "False" ]]; then
        command ansible-vault ${ACTION} --vault-id ${VAULT_ID} $2
    fi
}

