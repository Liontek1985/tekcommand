#!/usr/bin/env bash

# This file is part of the microplay-hub
# Designs by Liontek1985
# for RetroPie and offshoot
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="tekcommand"
rp_module_desc="Runcommand Launchscreens"
rp_module_repo="git https://github.com/Liontek1985/tekcommand.git master"
rp_module_section="main"
rp_module_flags="noinstclean"

function depends_tekcommand() {
    local depends=(cmake)
     getDepends "${depends[@]}"
}


function sources_tekcommand() {
    if [[ -d "$md_inst" ]]; then
        git -C "$md_inst" reset --hard  # ensure that no local changes exist
    fi
    gitPullOrClone "$md_inst"
}

function install_tekcommand() {
    local teksetup="$scriptdir/scriptmodules/supplementary"
	
    cd "$md_inst"

	cp -rvf "configs" "$rootdir"	
    chown -R $user:$user "$rootdir/configs"
	
	cp -r -u "tekcommand.sh" "$teksetup/tekcommand.sh"
    chown -R $user:$user "$teksetup/tekcommand.sh"
	chmod 755 "$teksetup/tekcommand.sh"
	rm -r "tekcommand.sh"
	
}


function remove_tekcommand() {

	rm -rf "$md_inst"
	cd "$rootdir/configs"
	find . -name "*launching.png" | sed -e "p;s/g.png/g.bkpng/" | xargs -n2 mv
	find . -name "*launching.bkpng" -exec rm {} \;
}

function gui_tekcommand() {

    while true; do
		
        local options=(	
            1 "Turn On - Tekcommand"
            2 "Turn Off - Tekcommand"
        )
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
                cd "$rootdir/configs"
				find . -name "*launching.bkpng" | sed -e "p;s/g.bkpng/g.png/" | xargs -n2 mv
                printMsgs "dialog" "Tekcommand turn on."
                ;;
            2)
                cd "$rootdir/configs"
				find . -name "*launching.png" | sed -e "p;s/g.png/g.bkpng/" | xargs -n2 mv
                printMsgs "dialog" "Tekcommand turn off."
                ;;
        esac
    done
}
