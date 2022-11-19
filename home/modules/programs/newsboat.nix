{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.newsboat;
in
{
  options = {
    modules.newsboat = {
      enable = mkEnableOption "Enable newsboat";
    };
  };

  config = mkIf cfg.enable {
    programs.newsboat = {
      enable = true;

      urls = [
        {
          title = "g1";
          tags = [ "news" ];
          url = "https://g1.globo.com/rss/g1/";
        }
      ];
    };
  };
}
