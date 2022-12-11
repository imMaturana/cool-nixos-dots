{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.programs.hyprpaper;
in
{
  options = {
    programs.hyprpaper = {
      enable = mkEnableOption "Enable hyprpaper";
      
      monitors = mkOption {
        type = types.listOf (types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              example = literalExpression "DP-1";
            };
            
            wallpaper = mkOption {
              type = types.path;
              example = literalExpression "path/to/wallpaper.jpg";
            };
          };
        });
        default = [ ];
        defaultText = literalExpression "[ ]";
        example = literalExpression ''
          [{
            name = "DP-1";
            wallpaper = path/to/wallpaper.jpg;
          }]
        '';
      };
    };
  };
  
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ hyprpaper ];
    
    xdg.configFile."hypr/hyprpaper.conf" = mkIf (cfg.monitors != [ ]) {
      text =
        let
          wallpapers = lib.unique (map (m: m.wallpaper) cfg.monitors);
        in
        ''
          ${lib.concatStringsSep "\n" (map (w: "preload=${w}") wallpapers)}
          ${lib.concatStringsSep "\n" (map (m: "wallpaper=${m.name},${m.wallpaper}") cfg.monitors)}
        '';
    };
  };
}
