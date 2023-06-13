{ lib
, config
, ...
}:
with lib; let
  cfg = config.home.fonts;

  fontModule = {
    family = mkOption {
      type = types.str;
    };

    package = mkOption {
      type = types.nullOr types.package;
    };
  };
in
{
  options.home.fonts = {
    regular = fontModule;
    monospace = fontModule;
  };

  config = {
    fonts.fontconfig.enable = true;
    home.packages = [
      cfg.regular.package
      cfg.monospace.package
    ];

    gtk.font.name = cfg.regular.family;
  };
}
