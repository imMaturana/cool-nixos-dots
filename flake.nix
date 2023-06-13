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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    hm = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.26.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:Misterio77/nix-colors/4.0.0";

    nixvim.url = "github:pta2002/nixvim/nixos-23.05";

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs:
    let
      lib = import ./lib.nix inputs;

      inherit (lib)
        eachSystem
        legacyPackages
        mkHost
        mkHome;
    in
    {
      homeManagerModules = import ./home/modules;
      nixosModules = import ./hosts/modules;

      devShells = eachSystem (system:
        let 
          pkgs = legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            name = "dotfiles";
            buildInputs = with pkgs; [
              home-manager
              cryptsetup
            ];
          };
        });

      formatter = eachSystem (system: legacyPackages.${system}.nixpkgs-fmt);

      nixosConfigurations."mercury" = mkHost {
        hostname = "mercury";
        system = "x86_64-linux";
        stateVersion = "23.05";
      };

      homeConfigurations."maturana@mercury" = mkHome "mercury";
    };
}
