{ pkgs
, config
, ...
}:
let
  summary-font = "${config.home.fonts.regular.family}:size=10:weight=bold";
  title-font = "${config.home.fonts.regular.family}:size=6:weight=bold:slant=italic";
  body-font = "${config.home.fonts.regular.family}:size=8:weight=regular";
  default-timeout = 5;
in
{
  home.packages = [ pkgs.libnotify ];

  services.fnott = {
    enable = true;
    settings = {
      main = {
        notification-margin = 15;
        icon-theme = config.gtk.iconTheme.name;
      };

      low = {
        inherit summary-font title-font body-font default-timeout;
        background = "${config.colorscheme.colors.base01}ff";
        title-color = "${config.colorscheme.colors.base03}ff";
      };

      normal = {
        inherit summary-font title-font body-font default-timeout;
        background = "${config.colorscheme.colors.base00}ff";
        title-color = "${config.colorscheme.colors.base03}ff";
        summary-color = "${config.colorscheme.colors.base05}ff";
        body-color = "${config.colorscheme.colors.base06}ff";
      };
    };
  };
}
