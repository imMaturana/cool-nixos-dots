{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
  ];

  home.packages = with pkgs; [
    sxiv
    maim
  ];
}
