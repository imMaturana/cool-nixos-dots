{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.modules.emacs;
  
  emacsPackage = pkgs.emacsPackagesFor pkgs.emacsPgtkNativeComp;
in
{
  options = {
    modules.emacs = {
      enable = mkEnableOption "Enable emacs";
    };
  };
  
  config = mkIf cfg.enable {
    home.packages = [ pkgs.emacs-all-the-icons-fonts ];

    programs.emacs = {
      enable = true;
      package = emacsPackage.emacsWithPackages (epkgs: with epkgs; [
        vterm
      ]);
    };
    
    services.emacs = {
      enable = true;
      package = config.programs.emacs.package;
    };
  };
}
