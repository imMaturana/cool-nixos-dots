{
  description = "My NixOS config";

  inputs = {
    # channels
    stable.url = "github:nixos/nixpkgs/nixos-22.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # flakes
    hm.url = "github:nix-community/home-manager";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:Misterio77/nix-colors/3.0.0";

    nixvim.url = "github:pta2002/nixvim";
    
    nur.url = "github:nix-community/NUR";

    # nixpkgs
    nixpkgs.follows = "unstable";
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
      
      legacyPackages = eachSupportedSystem (system: import nixpkgs rec {
        inherit system;
        config = { allowUnfree = true; };
        overlays = with inputs; [
          nur.overlay

          (_: _: {
            stable = import stable { inherit system config; };
          })
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
