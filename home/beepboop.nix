{ inputs
, pkgs
, config
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
  
  fontProfiles = {
    regular = {
      family = "Noto Sans";
      package = pkgs.noto-fonts;
    };
    
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      };
    };
  };
  
  desktopEnvironment.gnome = {
    enable = true;
    themeVariant = "dark";
  
    bindings = {
      "<Ctrl><Alt>T" = "kgx";
    };
    
    nightLight = {
      enable = true;
      temperature = 3500;
    };
  };

  modules = {
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
