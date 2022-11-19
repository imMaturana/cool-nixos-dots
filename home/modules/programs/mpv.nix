{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.mpv;
in
{
  options = {
    modules.mpv = {
      enable = mkEnableOption "Enable mpv";
      
      gnome = mkOption {
        type = types.bool;
        internal = true;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      package = pkgs.mpv-unwrapped;

      config = {
        geometry = "50%:50%";
        autofit = "80%x80%";
        volume = "60";
      };

      bindings = {
        h = "seek -5";
        l = "seek 5";
        "Shift+h" = "seek -60";
        "Shift+l" = "seek 60";
      };
    };
  };
}
