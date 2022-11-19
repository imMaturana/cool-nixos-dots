{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.firefox;
in
{
  options = {
    modules.firefox = {
      enable = mkEnableOption "Enable firefox";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;

      profiles.default = {
        name = "Default";
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];
    };
  };
}
