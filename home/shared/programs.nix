{
  programs = {
    home-manager.enable = true;
    jq.enable = true;
    fzf.enable = true;
    nix-index.enable = true;
    starship.enable = true;
    zoxide.enable = true;

    bat = {
      enable = true;
      config.theme = "base16";
    };

    exa = {
      enable = true;
      enableAliases = true;
    };
  };
}
