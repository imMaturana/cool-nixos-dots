#!/usr/bin/env bash

host=$1

# setup disks
nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode zap_create_mount "./hosts/$host/disko.nix"

# install NixOS
nixos-install --flake ".#$host" --no-root-password --root /mnt
