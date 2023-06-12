inputs:
let
  inherit (inputs) nixpkgs hm;
  inherit (nixpkgs) lib;
  inherit (inputs.self.outputs) nixosConfigurations;

  eachSystem = lib.genAttrs [
    "x86_64-linux"
  ];

  legacyPackages = eachSystem (system:
    import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [ inputs.nur.overlay ];
    });
in
{
  inherit eachSystem legacyPackages;

  mkHost =
    { hostname
    , system
    , stateVersion
    }:
    lib.nixosSystem {
      pkgs = legacyPackages.${system};

      modules = [
        ./hosts/${hostname}

        {
          networking.hostName = hostname;
          nixpkgs.hostPlatform.system = system;

          system.stateVersion = stateVersion;
        }
      ];

      specialArgs = inputs;
    };

  mkHome = hostname: hm.lib.homeManagerConfiguration {
    pkgs = nixosConfigurations.${hostname}.pkgs;
    modules = [ ./home/${hostname} ];
    extraSpecialArgs = inputs // {
      osConfig = nixosConfigurations.${hostname}.config;
    };
  };
}
