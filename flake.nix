{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    nvim.url = "github:ArgonCat/nvim-nix";
  };

  outputs = { self, nixpkgs, home-manager, nvim, neorg-overlay, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # I have no clue why you need neorg-overlay here as well, but it works so ehhhhhh TODO
        { nixpkgs.overlays = [ nvim.overlays.default neorg-overlay.overlays.default ]; }
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cat = import ./home-manager/home.nix;
        }
      ];
    };
  };
}
