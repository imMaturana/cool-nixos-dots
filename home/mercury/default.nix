{ pkgs
, nix-colors
, ...
}: {
  imports = [
    ../shared
    ../features/podman
    ../features/nvim
    ../features/helix
    ../features/emacs

    ./hyprland.nix
  ];

  colorscheme = nix-colors.colorSchemes.catppuccin-mocha;

  home.monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      wallpaper = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/g8/wallhaven-g876zd.jpg";
        sha256 = "sha256-5NJfjpmO02XHa41eSxidm0uzPMe2Iay2IYZz4BMyINk=";
      };
    }
  ];

  home.fonts = {
    regular = {
      family = "Noto Sans";
      package = pkgs.noto-fonts;
    };

    monospace = {
      family = "CaskaydiaCove Nerd Font";
      package = pkgs.nerdfonts.override {
        fonts = [ "CascadiaCode" ];
      };
    };
  };
}
