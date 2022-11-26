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
  ];

  modules = {
    desktop.gnome = {
      enable = true;
      bindings = {
        "<Ctrl><Alt>T" = "kgx";
      };
    };

    syncthing.enable = true;
    podman.enable = true;

    helix.enable = true;
    helix.theme = "gruvbox";

    vscode.enable = true;
    vscode.hide = [ "menu" ];
  };

  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/g8/wallhaven-g876zd.jpg";
    sha256 = "sha256-5NJfjpmO02XHa41eSxidm0uzPMe2Iay2IYZz4BMyINk=";
  };
}
