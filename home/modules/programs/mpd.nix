{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.mpd;
in
{
  options = {
    modules.mpd = {
      enable = mkEnableOption "Enable mpd";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.mpc_cli ];

    services.mpd = {
      enable = true;
      musicDirectory = config.xdg.userDirs.music;

      network = {
        listenAddress = "127.0.0.1";
        port = 6600;
      };

      extraConfig = ''
        audio_output {
          type "pulse"
          name "pulse audio"
          device "pulse"
          mixer_type "hardware"
        }

        audio_output {
          type "fifo"
          name "my_fifo"
          path "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };
  };
}
