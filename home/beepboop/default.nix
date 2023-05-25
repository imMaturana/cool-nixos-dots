{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../shared
    ../features/desktop/hyprland
    ../features/podman
    ../features/nvim
    ../features/helix
  ];

  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home.monitors = [{
    name = "eDP-1";
    width = 1920;
    height = 1080;
    wallpaper = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/g8/wallhaven-g876zd.jpg";
      sha256 = "sha256-5NJfjpmO02XHa41eSxidm0uzPMe2Iay2IYZz4BMyINk=";
    };
  }];

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
}
