{
  programs.git = {
    enable = true;
    userName = "imMaturana";
    userEmail = "maturana.dev@gmail.com";

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIApciVrwNsMaaPNIPn9CMoHfKSx1Gzq/QY8Ri4ResOAW maturana.dev@gmail.com";
      signByDefault = true;
    };

    extraConfig = {
      gpg.format = "ssh";
      init.defaultBranch = "main";
    };
  };
}
