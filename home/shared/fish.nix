{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: {
  programs.fish = {
    enable = osConfig.programs.fish.enable;

    shellAliases = {
      mv = "mv -i";
      cp = "cp -i";
      rm = "rm -i";
      mkdir = "mkdir -p";

      parrot = "curl parrot.live";
    };

    shellAbbrs = {
      # cd
      ".." = "cd ..";
      ".2" = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";

      # systemd
      sctl = "systemctl";
      sctlu = "systemctl --user";

      # bluetooth
      bt = "bluetoothctl";
      btc = "bluetoothctl connect";
      btd = "bluetoothctl disconnect";
      bton = "bluetoothctl power on";
      btoff = "bluetoothctl power off";
    };

    interactiveShellInit = ''
      # disable startup shell message
      set fish_greeting

      fish_vi_key_bindings
    '';

    functions = {
      fish_prompt = ''
        printf "%s%s%s > " (set_color green) (prompt_pwd) (set_color normal)
      '';

      qrcode = ''
        set -l input $argv
        [ -z "$input" ] && set -l input "@/dev/stdin"
        curl -d "$input" qrcode.show
      '';
    };
  };
}
