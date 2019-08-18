#!/bin/bash

function install_pkgs() {
    until $CHROOT sudo -u $USERNAME yay -Syu --noconfirm --needed --noeditmenu --nodiffmenu $@; do
        :
    done
}

function wait_for_internet() {
    until ping archlinux.org -c 1; do
        echo "Unable to reach archlinux.org. Trying again soon."
        sleep 5
    done
}

function execute_script() {
    SCRIPT_PATH=$(realpath $1)
    SCRIPT_DONE_PATH="$SCRIPT_PATH.done"

    if [ -f "$SCRIPT_DONE_PATH" ]; then
        echo "$SCRIPT_PATH already executed"
    else
        $SCRIPT_PATH
        touch $SCRIPT_DONE_PATH
    fi
}
