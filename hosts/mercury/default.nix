{ pkgs, ... }: {
  imports = [
    ../shared
    ../features/desktop/hyprland
    ../features/profiles/laptop.nix
    ../features/networking/firewall.nix
    ../users/maturana.nix

    ./disko.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "xhci_pci" "ahci" "uas" "sd_mod" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  networking.interfaces = {
    wlp3s0.useDHCP = true;
    enp2s0.useDHCP = true;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };
}
