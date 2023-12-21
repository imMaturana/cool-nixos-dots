{ self
, nixpkgs
, hm

, nur
, ...
} @ inputs:
let
  inherit (nixpkgs.lib) genAttrs listToAttrs;
  inherit (self.outputs) nixosConfigurations diskoConfigurations;

  eachSystem = genAttrs [
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

  mkDiskFor = hosts: listToAttrs (map
    (h: {
      name = h;
      value = import ./disko/${h}.nix;
    })
    hosts);

  mkHomeFor = hosts: listToAttrs (map
    (h: {
      name = h;
      value = hm.lib.homeManagerConfiguration {
        pkgs = nixosConfigurations.${h}.pkgs;
        modules = [ ./home/${h} ];
        extraSpecialArgs = inputs // {
          osConfig = nixosConfigurations.${h}.config;
        };
      };
    })
    hosts);
}
