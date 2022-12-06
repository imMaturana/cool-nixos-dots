{ inputs
, pkgs
, ...
}:

{
  imports = [
    ./shared
    ./modules
  ];

  home.packages = with pkgs; [
    distrobox
    element-desktop
    libreoffice
  ];

  modules = {
    desktop.sway.enable = true;
    waybar.bars."eDP-1" = {
      modules-left = [
        "custom/scratchpad"
        "sway/workspaces"
        "sway/mode"
      ];
      modules-right = [
        "tray"
        "idle_inhibitor"
        "pulseaudio"
        "battery"
        "network"
        "clock"
      ];
    };

    syncthing.enable = true;
    podman.enable = true;

    helix.enable = true;
    helix.theme = "gruvbox";

    vscode.enable = true;
    vscode.theme = "Gruvbox Dark Medium";
    vscode.vim.enable = true;
    vscode.hide = [ "menu" "scrollbars" "activity" ];
  };

  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/g8/wallhaven-g876zd.jpg";
    sha256 = "sha256-5NJfjpmO02XHa41eSxidm0uzPMe2Iay2IYZz4BMyINk=";
  };
}
