{ lib, ... }:

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
    pinentryFlavor = lib.mkDefault "curses";
  };
}
