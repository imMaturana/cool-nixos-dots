{
  programs.git = {
    enable = true;
    userName = "imMaturana";
    userEmail = "git.frighten632@simplelogin.fr";

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApciVrwNsMaaPNIPn9CMoHfKSx1Gzq/QY8Ri4ResOAW";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      gpg.format = "ssh";
    };
  };

  services.ssh-agent = {
    enable = true;
  };
}
