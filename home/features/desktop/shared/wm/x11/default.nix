{pkgs, ...}: {
  imports = [
    ../shared
    ./alacritty.nix
  ];

  home.packages = with pkgs; [
    sxiv
    maim
  ];
}
