#!/usr/bin/env bash

function install() {
    if [ $UID -ne 0 ]; then
        echo "Root must be used."
        exit 1
    fi
    
    if [ -z "$1" ]; then
        echo "A hostname must be specified."
        exit 1
    fi

    host="$1"

    nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --flake "path:$PWD#$host" --mode zap_create_mount

    nixos-install --flake ".#$host" --no-root-password --root /mnt
}

function update() {
    nix flake update
}

function update_input() {
    if [ -z "$1" ]; then
        echo "Argument required."
        exit 1
    fi

    nix flake lock --update-input "$1"
}

function deploy() {
    nixos-rebuild boot --flake .# --use-remote-sudo
}

function debug() {
    nixos-rebuild boot --flake .# --use-remote-sudo --show-trace --verbose
}

function home_deploy() {
    home-manager switch --flake .#$HOSTNAME
}

function home_debug() {
    home-manager -v switch --flake .#$HOSTNAME --show-trace
}

case $1 in
    install) install "$2" ;;
    up|update) update ;;
    upi|update-input) update_input "$2" ;;
    deploy) deploy ;;
    debug) debug ;;
    home-deploy) home_deploy ;;
    home-debug) home_debug ;;
    *) echo "$1: Invalid argument." && exit 1 ;;
esac
