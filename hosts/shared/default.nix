{ self
, pkgs
, lib
, ...
}:

{
  imports = [
    ./hardware.nix
    ./locale.nix
    ./programs.nix
    ./services.nix
    ./environment.nix
    ./cachix.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  networking.networkmanager.enable = true;
  
  # nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
}
