{pkgs, ...}: let
  shell = "fish";
in {
  users.users.maturana = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    initialPassword = "";
    shell = pkgs.${shell};
  };

  programs.${shell}.enable = true;
}
