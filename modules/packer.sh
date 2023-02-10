packer () {
    local packer_version_file="$HOME/.zsh_profile.d/configs/packer-version"

    if [[ ! -f "$packer_version_file" ]]; then
        touch "$packer_version_file"
    fi

    if [[ $1 == "switch" ]]; then
        local versions=$(ls -r /usr/local/bin/packer* | sed 's|/usr/local/bin/packer-||g')
        local version_found=False
        for version in $versions; do
            if [[ $version =~ $2 ]]; then
                echo "$version" > "${packer_version_file}"
                echo -e "\033[32mPacker version switched to $version\033[39m"
                local version_found=True
                break 1
            fi
        done

        if [[ $version_found == "False" ]]; then
            echo "Available Packer Versions: "
            local current_version=$(cat "${packer_version_file}")
            for version in $versions; do
                # shellcheck disable=SC2076
                if [[ -n "$current_verions" && $version =~ "$current_version" ]]; then
                    echo -e " - \033[32m${version}\033[00m"
                else
                    echo " - ${version}"
                fi
            done
            echo ""
        fi

    elif [[ $1 == "versions" ]]; then
        local current_version=$(cat "${packer_version_file}")
        local versions=$(ls -r /usr/local/bin/packer* | sed 's|/usr/local/bin/packer-||g')
        echo "Available Packer Versions: "
        for version in $versions; do
            # shellcheck disable=SC2076
            if [[ -n "$current_version" && $version =~ "$current_version" ]]; then
                echo -e " - \033[32m${version}\033[00m"
            else
                echo " - ${version}"
            fi
        done
        echo ""

    elif [[ $1 == "install" ]]; then
        local version=$2
        echo -e "\033[90mInstalling version ${version}"
        (
	    wget "https://releases.hashicorp.com/packer/${version}/packer_${version}_darwin_amd64.zip" -O /tmp/packer-download.zip &&
            unzip /tmp/packer-download.zip -d /tmp &&
            rm -rf /tmp/packer-download.zip &&
            mv /tmp/packer "/usr/local/bin/packer-${version}"
        ) &&
        echo -e "\033[32mInstalled version ${version}\033[00m" ||
        echo -e "\033[31mFailed installation of version ${version}\033[00m"

    elif [[ $1 == "uninstall" ]]; then
        local version=$2
        if [[ -e "/usr/local/bin/packer-${version}" ]]; then
            echo -e "\033[90mUninstalling version ${version}"

            rm "/usr/local/bin/packer-${version}" &&
            echo -e "\033[32mUninstalled version ${version}\033[00m" ||
            echo -e "\033[31mFailed uninstallation of version ${version}\033[00m"
        else
            echo -e "\033[31mVersion not installed\033[00m"
        fi
    
    else
        local version=$(cat "${packer_version_file}")
        if [[ -n "$version" ]]; then
            # shellcheck disable=SC2068
            "packer-${version}" $@
        else
            echo -e "\033[31mNo version selected\033[00m"
        fi
    fi

}
