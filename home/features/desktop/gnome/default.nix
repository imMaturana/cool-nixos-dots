{
  pkgs,
  lib,
  ...
}: {
  imports = [../shared];

  home.packages = with pkgs; [
    amberol
  ];

  fontProfiles.regular = lib.mkForce {
    family = "Noto Sans";
  };

  desktopEnvironment.gnome = {
    enable = true;
    themeVariant = "dark";

    monospaceFont = {
      inherit (config.fontProfiles.monospace) family;
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
