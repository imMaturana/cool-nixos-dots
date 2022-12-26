{
  pkgs,
  config,
  ...
}:
{
  home.packages = [pkgs.emacs-all-the-icons-fonts];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;

    extraPackages = epkgs: with epkgs; [
      vterm
    ];
  };

  services.emacs = {
    enable = true;
    package = config.programs.emacs.package;
  };

  programs.git.ignores = [
    "#*#"
    "*~"
    ".*#"
  ];
}
