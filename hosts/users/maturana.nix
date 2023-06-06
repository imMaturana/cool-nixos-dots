{
  pkgs,
  lib,
  config,
  ...
}: let
  shell = "fish";
in {
  users.users.maturana = {
    isNormalUser = true;

    extraGroups =
      [
        "wheel"
        "networkmanager"
        "video"
      ]
      ++ lib.optionals config.services.greetd.enable [
        "greeter"
      ];

    initialPassword = "";
    shell = pkgs.${shell};
  };

  programs.${shell}.enable = true;
}
