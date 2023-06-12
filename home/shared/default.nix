{ pkgs
, lib
, config
, self
, hyprland
, nix-colors
, nixvim
, osConfig
, ...
}: {
  imports = [
    self.homeManagerModules
    hyprland.homeManagerModules.default
    nix-colors.homeManagerModule
    nixvim.homeManagerModules.nixvim

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
    ./syncthing.nix
    ./tmux.nix
  ];

  home = {
    username = "maturana";
    homeDirectory = "/home/maturana";
    stateVersion = osConfig.system.stateVersion;

    sessionVariables = {
      PATH = lib.makeBinPath [
        "$HOME/.local"
      ];
    };

    keyboard = {
      layout = "us";
      variant = "colemak";
      options = [ "caps:swapescape" ];
    };
  };
}
