{
  description = "shard's nixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # twixvim vim framework
    twixvim.url = "github:null0xeth/twixvim";

    ags.url = "github:Aylur/ags";

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    more-waita = {
      url = "github:somepaulo/MoreWaita";
      flake = false;
    };

    # plasma manager
    # plasma-manager.url = "github:pjones/plasma-manager";
    # plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    # plasma-manager.inputs.home-manager.follows = "home-manager";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "x86_64-linux"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;
    
    # custom devshells
    #devShells = forAllSystems (system: {
    #  school = import ./shells/school-shell.nix {
    #    inherit (nixpkgs.legacyPackages.${system}) pkgs;
    #	inherit home-manager;
    #  };
    # });

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      omen = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
          # home-manager.nixosModules.home-manager
          # {
          #  home-manager.extraSpecialArgs = {inherit inputs;};
          # home-manager.users.shard.imports = [ ./home-manager/home.nix ];
          #   home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
          #}
        ];
      };
    };
  };
}
