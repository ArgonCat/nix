build:
  sudo nix flake lock --update-input nvim
  sudo nixos-rebuild switch --flake .
