{ self
, nixpkgs
, hm

, nur
, ...
} @ inputs:
let
  inherit (self.outputs) nixosConfigurations diskoConfigurations;

  eachSystem = nixpkgs.lib.genAttrs [
    "x86_64-linux"
  ];

  legacyPackages = eachSystem (system:
    import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [ nur.overlay ];
    });
in
{
  inherit eachSystem legacyPackages;

  mkHost =
    { hostname
    , system
    , stateVersion
    }:
    nixpkgs.lib.nixosSystem {
      pkgs = legacyPackages.${system};

      modules = [
        ./hosts/${hostname}
        diskoConfigurations.${hostname}

        {
          networking.hostName = hostname;
          nixpkgs.hostPlatform.system = system;

          system.stateVersion = stateVersion;
        }
      ];

      specialArgs = inputs;
    };

  mkDisk = hostname: import ./disko/${hostname}.nix;

  mkHome = hostname: hm.lib.homeManagerConfiguration {
    pkgs = nixosConfigurations.${hostname}.pkgs;
    modules = [ ./home/${hostname} ];
    extraSpecialArgs = inputs // {
      osConfig = nixosConfigurations.${hostname}.config;
    };
  };
}
