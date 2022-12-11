{
  pkgs,
  config,
  ...
}: let
  emacsPackage = pkgs.emacsPackagesFor pkgs.emacsPgtkNativeComp;
in {
  home.packages = [pkgs.emacs-all-the-icons-fonts];

  programs.emacs = {
    enable = true;
    package = emacsPackage.emacsWithPackages (epkgs:
      with epkgs; [
        vterm
      ]);
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
