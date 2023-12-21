{ pkgs
, config
, ...
}:
let
  inherit (config.colorscheme) colors;
in
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "${config.home.fonts.regular.family}:size=10";
        icon-theme = config.gtk.iconTheme.name;
        terminal = "${pkgs.foot}/bin/foot";
        layer = "overlay";
        dpi-aware = "yes";
      };

      border.width = 2;
      border.radius = 8;

      colors = {
        background = "${colors.base00}ff";
        text = "${colors.base06}ff";
        border = "${colors.base0D}ff";
        match = "${colors.base08}ff";
        selection = "${colors.base02}ff";
        selection-text = "${colors.base06}ff";
      };
    };
  };
}
