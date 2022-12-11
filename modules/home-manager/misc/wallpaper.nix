{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  options.wallpaper = mkOption {
    type = types.nullOr types.path;
    default = null;
  };
}
