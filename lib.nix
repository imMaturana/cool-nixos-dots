inputs: let
  inherit
    (inputs)
    nixpkgs
    home
    ;

  inherit
    (nixpkgs.lib)
    nixosSystem
    genAttrs
    optionals
    pathExists
    ;

  eachSystem = genAttrs [
    "x86_64-linux"
  ];

  legacyPackages = eachSystem (system:
    import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [inputs.nur.overlay];
    });
in {
  inherit eachSystem legacyPackages;

  mkHost = {
    hostname,
    system,
  }:
    nixosSystem {
      pkgs = legacyPackages.${system};

      modules =
        [
          ./hosts/${hostname}

          {
            networking.hostName = hostname;
            nixpkgs.hostPlatform.system = system;
          }
        ]
        ++ optionals (pathExists ./home/${hostname}) [
          home.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.maturana = ./home/${hostname};
            home-manager.extraSpecialArgs = inputs;
          }
        ];

      specialArgs = inputs;
    };
}
