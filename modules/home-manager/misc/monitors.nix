{
  lib,
  config,
  ...
}:
with lib; let
  ms = config.home.monitors;

  monitorModule = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
      };

      width = mkOption {
        type = types.int;
      };

      height = mkOption {
        type = types.int;
      };

      position = mkOption {
        type = types.attrsOf types.int;
        default = {
          x = 0;
          y = 0;
        };
      };

      wallpaper = mkOption {
        type = types.nullOr types.path;
        default = null;
      };

      primary = mkOption {
        type = types.uniq types.bool;
        default = false;
      };
    };
  };
in {
  options = {
    home = {
      monitors = mkOption {
        type = types.listOf monitorModule;
        example = literalExpression ''
          [
            {
              name = "DP-1";
              width = 1920;
              height = 1080;
              primary = true;
            }
            {
              name = "DP-2";
              width = 1920;
              height = 1080;
              position = { x = 0; y = 1080; };
            }
          ]
        '';
      };

      primaryMonitor = mkOption {
        type = monitorModule;
        internal = true;
      };
    };
  };

  config = {
    home.primaryMonitor =
      if (length ms > 1)
      then filter (m: m.primary) ms
      else head ms;
  };
}
