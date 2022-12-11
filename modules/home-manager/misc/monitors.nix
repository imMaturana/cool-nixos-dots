{
  lib,
  config,
  ...
}:
with lib; let
  ms = config.home.monitors;
in {
  options = {
    home = {
      monitors = mkOption {
        type = types.listOf types.str;
        example = literalExpression ''
          [
            "DP-1"
            "DP-2"
          ]
        '';
      };

      primaryMonitor = mkOption {
        type = types.str;
        internal = true;
      };
    };
  };

  config = {
    home.primaryMonitor = head ms;
  };
}
