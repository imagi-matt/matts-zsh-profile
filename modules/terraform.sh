alias tf='terraform'

terraform () {
    local terraform_version_file="$HOME/.zsh_profile.d/configs/terraform-version"

    if [[ ! -f "$terraform_version_file" ]]; then
        touch "$terraform_version_file"
    fi

    if [[ $1 == "switch" ]]; then
        local versions=$(ls -r /usr/local/bin/terraform* | sed 's|/usr/local/bin/terraform-||g')
        local version_found=False
        ls -r /usr/local/bin/terraform* | sed 's|/usr/local/bin/terraform-||g' | while read version; do
            if [[ $version =~ $2 ]]; then
                echo "$version" > "${terraform_version_file}"
                echo -e "\033[32mTerraform version switched to $version\033[39m"
                local version_found=True
                break 1
            fi
        done

        if [[ $version_found == "False" ]]; then
            echo "Available Terraform Versions: "
            local current_version=$(cat "${terraform_version_file}")
            ls -r /usr/local/bin/terraform* | sed 's|/usr/local/bin/terraform-||g' | while read version; do
                # shellcheck disable=SC2076
                if [[ -n "$current_version" && $version =~ "$current_version" ]]; then
                    echo -e " - \033[32m${version}\033[00m"
                else
                    echo -e " - ${version}"
                fi
            done
            echo ""
        fi

    elif [[ $1 == "versions" ]]; then
        echo "Available Terraform Versions: "
        local current_version=$(cat "${terraform_version_file}")
        ls -r /usr/local/bin/terraform* | sed 's|/usr/local/bin/terraform-||g' | while read version; do
            # shellcheck disable=SC2076
            if [[ -n "$current_version" && $version =~ "$current_version" ]]; then
                echo -e " - \033[32m${version}\033[00m"
            else
                echo -e " - ${version}"
            fi
        done
        echo ""

    elif [[ $1 == "install" ]]; then
        local version=$2
        echo -e "\033[90mInstalling version ${version}"
        (
            wget "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_darwin_amd64.zip" -O /tmp/terraform-download.zip &&
            unzip /tmp/terraform-download.zip -d /tmp &&
            rm -rf /tmp/terraform-download.zip &&
            mv /tmp/terraform "/usr/local/bin/terraform-${version}"
        ) &&
        echo -e "\033[32mInstalled version ${version}\033[00m" ||
        echo -e "\033[31mFailed installation of version ${version}\033[00m"
        
    elif [[ $1 == "uninstall" ]]; then
        local version=$2
        if [[ -e "/usr/local/bin/terraform-${version}" ]]; then
            echo -e "\033[90mUninstalling version ${version}"

            rm "/usr/local/bin/terraform-${version}" &&
            echo -e "\033[32mUninstalled version ${version}\033[00m" ||
            echo -e "\033[31mFailed uninstallation of version ${version}\033[00m"
        else
            echo -e "\033[31mVersion not installed\033[00m"
        fi
        
    else
        local version=$(cat "${terraform_version_file}")
        if [[ -n "$version" ]]; then
            # shellcheck disable=SC2068
            "terraform-${version}" $@
        else
            echo -e "\033[31mNo version selected\033[00m"
        fi
    fi

}
