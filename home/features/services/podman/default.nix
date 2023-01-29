{pkgs, ...}: {
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
}
