{
  programs.git = {
    enable = true;
    userName = "imMaturana";
    userEmail = "git@maturana.simplelogin.com";

    signing = {
      key = "CBB817BF7AB06ADBB418646CEC57406107E88C18";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
