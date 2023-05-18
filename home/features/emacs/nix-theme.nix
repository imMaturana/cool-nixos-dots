{
  emacsPackagesFor,
  writeText,
  config,
  ...
}:

let
  inherit (config.colorscheme) name slug colors;
  emacsPackages = emacsPackagesFor config.programs.emacs.package;
in emacsPackages.trivialBuild rec {
  pname = "nix-theme";
  packageRequires = [ emacsPackages.base16-theme ];
  src = writeText "${pname}.el" ''
    (require 'base16-theme)

    (defvar base16-${slug}-theme-colors
     '(:base00 "#${colors.base00}"
       :base01 "#${colors.base01}"
       :base02 "#${colors.base02}"
       :base03 "#${colors.base03}"
       :base04 "#${colors.base04}"
       :base05 "#${colors.base05}"
       :base06 "#${colors.base06}"
       :base07 "#${colors.base07}"
       :base08 "#${colors.base08}"
       :base09 "#${colors.base09}"
       :base0A "#${colors.base0A}"
       :base0B "#${colors.base0B}"
       :base0C "#${colors.base0C}"
       :base0D "#${colors.base0D}"
       :base0E "#${colors.base0E}"
       :base0F "#${colors.base0F}")
     "All colors for Base16 ${name} are defined here.")

    ;; Define the theme
    (deftheme base16-${slug})

    ;; Add all the faces to the theme
    (base16-theme-define 'base16-${slug} base16-${slug}-theme-colors)

    ;; Mark the theme as provided
    (provide-theme 'base16-${slug})

    (provide 'base16-${slug}-theme)
  '';
}
