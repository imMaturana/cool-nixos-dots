{
  description = "My NixOS config";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.19.1beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:Misterio77/nix-colors/3.0.0";

    nixvim.url = "github:pta2002/nixvim";

    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    eachSupportedSystem = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];

    legacyPackages = eachSupportedSystem (system:
      import nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
        overlays = with inputs; [
          nur.overlay
          emacs.overlay

          # TODO temporary fix to nixvim, remove if backporting be implemented
          (_: _: let
            inherit (nixvim.inputs) nixpkgs;
          in {
            inherit (nixpkgs.legacyPackages.${system}) vimPlugins;
          })
        ];
      });

    mkHost = nixpkgs.lib.nixosSystem;
    mkHome = home-manager.lib.homeManagerConfiguration;
  in {
    homeManagerModules = import ./modules/home-manager;
    nixosModules = import ./modules/host;

    devShells = eachSupportedSystem (system: {
      default = import ./shell.nix {pkgs = legacyPackages.${system};};
    });

    formatter = eachSupportedSystem (system: legacyPackages.${system}.alejandra);

    nixosConfigurations."beepboop" = mkHost {
      pkgs = legacyPackages.x86_64-linux;
      modules = [./hosts/beepboop];
      specialArgs = {inherit self inputs;};
    };

    homeConfigurations."beepboop" = mkHome {
      pkgs = self.outputs.nixosConfigurations."beepboop".pkgs;
      modules = [./home/beepboop.nix];
      extraSpecialArgs = {inherit self inputs;};
    };
  };
}
