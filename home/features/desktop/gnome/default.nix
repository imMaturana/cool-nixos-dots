{ pkgs
, lib
, ...
}: {
  imports = [ ../shared ];

  home.packages = with pkgs; [
    amberol
  ];

  home.fonts.regular = lib.mkForce {
    family = "Noto Sans";
  };

  desktopEnvironment.gnome = {
    enable = true;
    themeVariant = "dark";

    monospaceFont = {
      inherit (config.home.fonts.monospace) family;
      size = 10;
    };

    bindings = {
      "<Ctrl><Alt>T" = "kgx";
    };

    nightLight = {
      enable = true;
      temperature = 3500;
    };
  };
}
