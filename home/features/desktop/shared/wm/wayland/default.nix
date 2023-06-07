{ pkgs
, lib
, config
, ...
}:
let
  inherit (config.colorscheme) colors;

  fuzzel-menu = pkgs.writeScriptBin "fuzzel_menu" ''
    ${lib.getExe pkgs.fuzzel} -p 'run ' \
    -f '${config.home.fonts.regular.family}:size=10' -i '${config.gtk.iconTheme.name}' \
    -r 2 -B 3 -y 20 -P 10 \
    -b '${colors.base00}ff' -t '${colors.base06}ff' \
    -C '${colors.base0D}ff' -m '${colors.base08}ff' \
    -s '${colors.base02}ff' -S '${colors.base06}ff'
  '';
in
{
  imports = [
    ./fnott.nix
    ./foot.nix
    ./swayidle.nix
    ./waybar.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    fuzzel
    fuzzel-menu
    imv
    swaylock
    wl-clipboard
    grim
    slurp
    wf-recorder
  ];
}
