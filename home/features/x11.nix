{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./wm.nix
  ];

  home.packages = with pkgs; [
    sxiv
    maim
  ];
}
