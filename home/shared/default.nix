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
    inputs.hyprland.homeManagerModules.default
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
    
    keyboard = {
      layout = "us";
      variant = "colemak";
      options = [ "caps:swapescape" ];
    };
  };
}
