{ pkgs
, config
, ...
}:
let
  pinentry =
    if config.gtk.enable
    then {
      packages = [ pkgs.pinentry-gnome pkgs.gcr ];
      name = "gnome3";
    }
    else {
      packages = [ pkgs.pinentry-curses ];
      name = "curses";
    };
in
{
  programs.gpg = {
    enable = true;
    settings = {
      keyserver = "hkp://keys.openpgp.org";
      fixed-list-mode = true;
      keyid-format = "long";
      use-agent = true;
      no-emit-version = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = pinentry.name;
  };

  home.packages = pinentry.packages;
}
