#!/usr/bin/env bash

# This file is part of The RetroPie Project
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

function depends_tekcommand() {
    getDepends mc
}


function sources_tekcommand() {
    gitPullOrClone
}

function install_tekcommand() {
    local tekdir="$scriptdir/scriptmodules/supplementary/tekcommand"
    local teksetup="$scriptdir/scriptmodules/supplementary"

    mkdir -p "$tekdir"
    chown -R $user:$user "$tekdir"
	
	cp -r -u "configs" "$tekdir/configs"
    chown -R $user:$user "$tekdir"

	cp -rvf "$tekdir/configs/" "$rootdir/configs"	
    chown -R $user:$user "$rootdir/configs"
	
	cp -r -u "tekcommand.sh" "$teksetup/tekcommand.sh"
    chown -R $user:$user "$teksetup/tekcommand.sh"
	
}

function configure_tekcommand() {
    [[ "$md_mode" == "remove" ]] && return


}


function remove_tekcommand() {

    rm -rf "$scriptdir/scriptmodules/supplementary/tekcommand"
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
                printMsgs "dialog" "Tekcommand turn on.\n\nRestart EmulationStation to apply."
                ;;
            2)
                cd "$rootdir/configs"
				find . -name "*launching.png" | sed -e "p;s/g.png/g.bkpng/" | xargs -n2 mv
                printMsgs "dialog" "Tekcommand turn off.\n\nRestart EmulationStation to apply."
                ;;
        esac
    done
}
