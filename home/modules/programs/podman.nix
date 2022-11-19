{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.podman;
in
{
  options = {
    modules.podman = {
      enable = mkEnableOption "Enable podman";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      podman
      podman-compose
      buildah
      skopeo
    ];

    xdg.configFile."containers/registries.conf".text = ''
      [registries.search]
      registries = ["docker.io", "quay.io"]

      [registries.block]
      registries = []
    '';

    xdg.configFile."containers/policy.json".source = "${pkgs.skopeo.src}/default-policy.json";
  };
}
