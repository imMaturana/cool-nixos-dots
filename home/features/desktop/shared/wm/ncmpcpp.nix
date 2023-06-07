{ pkgs
, config
, ...
}: {
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

  programs.ncmpcpp = {
    enable = true;
    settings = {
      progressbar_look = "━━━";
      progressbar_elapsed_color = "blue:b";
      execute_on_song_change = ''notify-send -t 3000 -a "Ncmpcpp" "Now Playing" "$(mpc --format '%title% \n%artist%' current)"'';
    };
  };
}
