{pkgs, ...}: {
  users.users.maturana = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
