{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-25.05; # or unstable
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # extraSpecialArgs = { inherit inputs; };
      modules = [
        ./nixos/hardware-configuration.nix
        ./nixos/configuration.nix
        inputs.home-manager.nixosModules.home-manager
      ];
    };

  };
}
