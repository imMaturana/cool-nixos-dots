{ pkgs
, ...
}:
{
  imports = [
    ./fnott.nix
    ./foot.nix
    ./fuzzel.nix
    ./swayidle.nix
    ./waybar.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    imv
    swaylock
    wl-clipboard
    grim
    slurp
    sway-contrib.grimshot
    wf-recorder
  ];
}
