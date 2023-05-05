{
  self,
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    self.homeManagerModules
    inputs.hyprland.homeManagerModules.default
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim

    # misc
    ./xdg.nix

    # programs
    ./packages.nix
    ./programs.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./gpg.nix
    ./lazygit.nix
    ./neovim.nix
    ./syncthing.nix
    ./tmux.nix
  ];

  home = {
    username = "maturana";
    homeDirectory = "/home/maturana";
    stateVersion = "22.11";

    sessionVariables = {
      PATH = lib.makeBinPath [
        "$PATH"
        "$HOME/.local/bin"
        "$HOME/.bin"
      ];
    };

    keyboard = {
      layout = "us";
      variant = "colemak";
      options = ["caps:swapescape"];
    };
  };
}
