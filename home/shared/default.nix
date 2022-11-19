{ self
, inputs
, pkgs
, lib
, config
, ...
}:

{
  imports = [
    self.homeManagerModules
    inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim

    ./xdg.nix
    ./programs
  ];
  
  home = {
    username = "maturana";
    homeDirectory = "/home/maturana";
    stateVersion = "22.05";

    sessionVariables = {
      PATH = lib.makeBinPath [ 
        "$PATH"
        "$HOME/.local/bin"
        "$HOME/.bin"
      ];
    };
  };
  
  fontProfiles = {
    enable = true;
    
    regular = lib.mkDefault {
      family = "JetBrainsMono";
      package = pkgs.jetbrains-mono;
    };
    
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      };
    };
  };
}
