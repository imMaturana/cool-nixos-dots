{pkgs, ...}: {
  users.users.maturana = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    hashedPassword = "$6$BF3dksnCg0pChV0I$AHcbX8GO1ctXpzjAuvex1jpnzNe7V9w2iblLvPJQ2Vp2mG8qpuMGlZsIB/wVKZgTgQEml02k1qGeTwddlpraN0";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
