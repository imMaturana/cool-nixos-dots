{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    
    # flakes
    hm.url = "github:nix-community/home-manager/release-22.11";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:Misterio77/nix-colors/3.0.0";

    nixvim.url = "github:pta2002/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    { self
    , nixpkgs
    , hm
    , ...
    }@inputs:
    let
      eachSupportedSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
      
      legacyPackages = eachSupportedSystem (system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = with inputs; [
          nur.overlay
        ];
      });
    in
    {
      homeManagerModules = import ./modules/home-manager;
      nixosModules = import ./modules/host;
      
      devShells = eachSupportedSystem (system: {
        default = import ./shell.nix { pkgs = legacyPackages.${system}; };
      });
      
      nixosConfigurations."beepboop" = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        modules = [ ./hosts/beepboop.nix ];
        specialArgs = { inherit self inputs; };
      };

      homeConfigurations."maturana@beepboop" = hm.lib.homeManagerConfiguration {
        pkgs = self.outputs.nixosConfigurations.beepboop.pkgs;
        modules = [ ./home/beepboop.nix ];
        extraSpecialArgs = { inherit self inputs; };
      };
    };
}
