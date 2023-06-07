{ pkgs
, config
, nix-colors
, ...
}:
let
  inherit (nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
in
{
  imports = [
    ./mpv.nix
    ./ncmpcpp.nix
    ./zathura.nix
  ];

  gtk = {
    enable = true;

    theme = {
      name = config.colorscheme.slug;
      package = gtkThemeFromScheme {
        scheme = config.colorscheme;
      };
    };

    iconTheme = {
      name =
        if config.colorscheme.kind == "light"
        then "Papirus"
        else "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
