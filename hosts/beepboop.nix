{ pkgs, ... }:

{
  imports = [
    ./shared
    ./features/gnome.nix
    ./features/laptop.nix
    ./features/firewall.nix
    ./features/gaming.nix
    ./users/maturana.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "xhci_pci" "ahci" "uas" "sd_mod" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/dev/sda2";
  }];

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "btrfs";
    options = [ "subvol=@nixos" ];
  };

  networking.hostName = "beepboop";

  networking.interfaces = {
    wlp3s0.useDHCP = true;
    enp2s0.useDHCP = true;
  };

  nixpkgs.hostPlatform.system = "x86_64-linux";

  programs = {
    light.enable = true;
    dconf.enable = true;
  };
  
  system.stateVersion = "22.05";
}
