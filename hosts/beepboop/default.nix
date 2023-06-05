{pkgs, ...}: {
  imports = [
    ../shared
    ../features/laptop.nix
    ../features/noto-fonts.nix
    ../features/wayland.nix
    ../features/flatpak.nix
    ../features/firewall.nix
    ../users/maturana.nix

    ./disko.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = ["xhci_pci" "ahci" "uas" "sd_mod"];
  boot.blacklistedKernelModules = ["nouveau"];

  networking.interfaces = {
    wlp3s0.useDHCP = true;
    enp2s0.useDHCP = true;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  system.stateVersion = "22.11";
}
