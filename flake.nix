{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;

    # flakes
    hm.url = "github:nix-community/home-manager/release-22.11";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    emacs.url = github:nix-community/emacs-overlay;
    emacs.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = github:hyprwm/Hyprland/v0.19.1beta;

    nix-colors.url = "github:Misterio77/nix-colors/3.0.0";

    nixvim.url = "github:pta2002/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    hm,
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
        ];
      });

    mkHost = nixpkgs.lib.nixosSystem;
    mkHome = hm.lib.homeManagerConfiguration;
  in {
    homeManagerModules = import ./modules/home-manager;
    nixosModules = import ./modules/host;

    devShells = eachSupportedSystem (system: {
      default = import ./shell.nix {pkgs = legacyPackages.${system};};
    });

    formatter = eachSupportedSystem (system: legacyPackages.${system}.alejandra);

    nixosConfigurations."beepboop" = mkHost {
      pkgs = legacyPackages.x86_64-linux;
      modules = [./hosts/beepboop.nix];
      specialArgs = {inherit self inputs;};
    };

    homeConfigurations."beepboop" = mkHome {
      pkgs = self.outputs.nixosConfigurations.beepboop.pkgs;
      modules = [./home/beepboop.nix];
      extraSpecialArgs = {inherit self inputs;};
    };
  };
}
