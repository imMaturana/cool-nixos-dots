{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    amberol
  ];

  fontProfiles.regular = lib.mkForce {
    family = "Noto Sans";
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
}
