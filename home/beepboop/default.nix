{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../shared
    ../features/hyprland
    ../features/podman
    ../features/helix
  ];

  home.monitors = [
    "eDP-1"
  ];

  home.packages = with pkgs; [
    distrobox
    element-desktop
  ];

  fontProfiles = {
    regular = {
      family = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
    };

    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {
        fonts = ["JetBrainsMono"];
      };
    };
  };

  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/g8/wallhaven-g876zd.jpg";
    sha256 = "sha256-5NJfjpmO02XHa41eSxidm0uzPMe2Iay2IYZz4BMyINk=";
  };
}
