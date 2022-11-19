{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.wlsunset;
in
{
  options = {
    modules.wlsunset = {
      enable = mkEnableOption "Enable wlsunset";
    };
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      latitude = "-11.5057";
      longitude = "-63.5806";
      temperature = {
        day = 6000;
        night = 4000;
      };
    };
  };
}
