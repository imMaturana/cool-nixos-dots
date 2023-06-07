inputs:
let
  inherit (inputs) nixpkgs hm;
  inherit (nixpkgs) lib;

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
      ] ++ lib.optionals (lib.pathExists ./home/${hostname}) [
        hm.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.maturana = lib.mkMerge [
            ./home/${hostname}

            { home.stateVersion = stateVersion; }
          ];

          home-manager.extraSpecialArgs = inputs;
        }
      ];

      specialArgs = inputs;
    };
}
