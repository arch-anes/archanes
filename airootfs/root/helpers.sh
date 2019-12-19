#!/bin/bash

function run_as_user() {
    $CHROOT sudo -u $USERNAME $@
}

function install_packages() {
    until run_as_user yay -Syu --noconfirm --needed --noeditmenu --nodiffmenu $@; do
        :
    done
}

function install_packages_dependencies() {
    install_packages --asdeps $@
}

function enable_services() {
    $CHROOT systemctl enable $@
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

    echo -e '\n\n'
    echo "====================== $SCRIPT_PATH ======================" 
    if [ -f "$SCRIPT_DONE_PATH" ]; then
        echo "$SCRIPT_PATH already executed"
    else
        source $SCRIPT_PATH
        touch $SCRIPT_DONE_PATH
    fi
}
