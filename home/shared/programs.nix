{
  programs = {
    jq.enable = true;
    fzf.enable = true;
    nix-index.enable = true;
    starship.enable = true;
    zoxide.enable = true;

    bat = {
      enable = true;
      config.theme = "base16";
    };

    eza = {
      enable = true;
      enableAliases = true;
    };
  };
}
