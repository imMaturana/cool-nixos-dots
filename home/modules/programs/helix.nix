{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.helix;
in
{
  options = {
    modules.helix = {
      enable = mkEnableOption "Enable helix";

      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;

      settings = {
        theme = mkIf (!isNull cfg.theme) cfg.theme;

        editor = {
          line-number = "relative";

          lsp = {
            display-messages = true;
          };

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "block";
          };
        };

        keys.normal = {
          space.f = "file_picker";
        };
      };

      languages = [{
        name = "python";
        language-server = { command = "pyright-langserver"; args = [ "--stdio" ]; };
        config = {};
      }];
    };
  };
}
