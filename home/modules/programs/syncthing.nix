{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.syncthing;
in
{
  options = {
    modules.syncthing = {
      enable = mkEnableOption "Enable syncthing";
    };
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
    };
  };
}
