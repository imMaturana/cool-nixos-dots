{ osConfig
, ...
}: {
  programs.fish = {
    inherit (osConfig.programs.fish) enable;
    shellAliases = import ./_shellAliases.nix;

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
