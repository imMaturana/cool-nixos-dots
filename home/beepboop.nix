{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./shared

    ./features/hyprland
    ./features/podman
    ./features/helix

    ./features/vscode
    ./features/vscode/minimal.nix
    #./features/vscode/vim.nix
  ];

  home.monitors = [
    "eDP-1"
  ];

  home.packages = with pkgs; [
    distrobox
    element-desktop
    libreoffice
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

  programs.vscode.userSettings = {
    workbench.colorTheme = "Gruvbox Dark Medium";
  };

  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/g8/wallhaven-g876zd.jpg";
    sha256 = "sha256-5NJfjpmO02XHa41eSxidm0uzPMe2Iay2IYZz4BMyINk=";
  };
}
