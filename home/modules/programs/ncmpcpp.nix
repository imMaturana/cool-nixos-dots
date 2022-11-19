{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.ncmpcpp;
in
{
  options = {
    modules.ncmpcpp = {
      enable = mkEnableOption "Enable ncmpcpp";
    };
  };

  config = mkIf cfg.enable {
    modules.mpd.enable = true;

    programs.ncmpcpp = {
      enable = true;
      settings = {
        progressbar_look = "━━━";
        progressbar_elapsed_color = "blue:b";
        execute_on_song_change = ''notify-send -t 3000 -a "Ncmpcpp" "Now Playing" "$(mpc --format '%title% \n%artist%' current)"'';
      };
    };
  };
}
