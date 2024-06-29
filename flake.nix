{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };

  outputs = { self, nixpkgs, home-manager, neorg-overlay, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [ neorg-overlay.overlays.default ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cat = import ./home-manager/home.nix;
        }
      ];
    };
  };
}
