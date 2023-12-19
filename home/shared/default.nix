{ lib
, self
, nix-colors
, nixvim
, osConfig
, ...
}: {
  imports = [
    self.homeManagerModules
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
        "$PATH"
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
