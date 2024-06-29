{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    nvim.url = "github:ArgonCat/nvim-nix";
  };

  outputs = { self, nixpkgs, home-manager, nvim, neorg-overlay, catppuccin, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        { nixpkgs.overlays = [ nvim.overlays.default ]; }
        catppuccin.nixosModules.catppuccin
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cat = {
            imports = [
              ./home-manager/home.nix
              catppuccin.homeManagerModules.catppuccin
            ];
          };
        }
      ];
    };
  };
}
