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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    hm = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:Misterio77/nix-colors/4.0.0";

    nixvim.url = "github:nix-community/nixvim/nixos-23.11";

    nur.url = "github:nix-community/NUR";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { pre-commit-hooks
    , ...
    } @ inputs:
    let
      lib = import ./lib.nix inputs;

      inherit (lib)
        eachSystem
        legacyPackages
        mkHost
        mkDiskFor
        mkHome;
    in
    {
      homeManagerModules = import ./home/modules;
      nixosModules = import ./hosts/modules;

      checks = eachSystem (system: {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
          };
        };
      });

      formatter = eachSystem (system: legacyPackages.${system}.nixpkgs-fmt);

      nixosConfigurations.mercury = mkHost {
        hostname = "mercury";
        system = "x86_64-linux";
        stateVersion = "23.11";
      };

      diskoConfigurations = mkDiskFor [
        "mercury"
      ];

      homeConfigurations.mercury = mkHome "mercury";
    };
}
