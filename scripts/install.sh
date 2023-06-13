#!/usr/bin/env bash

host=$1

# setup disks
nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --flake "path:$PWD#$host" --mode zap_create_mount

# install NixOS
nixos-install --flake ".#$host" --no-root-password --root /mnt
