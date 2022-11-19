{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.alacritty;
  
  inherit (config.fontProfiles.monospace) family;
in
{
  options = {
    modules.alacritty = {
      enable = mkEnableOption "Enable alacritty";
    };
  };
  
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = { x = 6; y = 6; };
        };

        font = {
          normal = { inherit family; };
          bold = { inherit family; };
          italic = { inherit family; };
          bold_italic = { inherit family; };
          size = 7.0;
          offset = { x = 0; y = 0; };
        };

        colors = with config.colorscheme; {
          primary = {
            background = "0x${colors.base00}";
            foreground = "0x${colors.base05}";
          };

          cursor = {
            text = "0x${colors.base00}";
            cursor = "0x${colors.base05}";
          };

          normal = {
            black = "0x${colors.base00}";
            red = "0x${colors.base08}";
            green = "0x${colors.base0B}";
            yellow = "0x${colors.base0A}";
            blue = "0x${colors.base0D}";
            magenta = "0x${colors.base0E}";
            cyan = "0x${colors.base0C}";
            white = "0x${colors.base05}";
          };

          bright = {
            black = "0x${colors.base02}";
            red = "0x${colors.base08}";
            green = "0x${colors.base0B}";
            yellow = "0x${colors.base0A}";
            blue = "0x${colors.base0D}";
            magenta = "0x${colors.base0E}";
            cyan = "0x${colors.base0C}";
            white = "0x${colors.base07}";
          };
        };
      };
    };
  };
}
