t480s:
  sudo nix flake lock --update-input nvim
  sudo nixos-rebuild switch --flake .#t480s
legion:
  sudo nix flake lock --update-input nvim
  sudo nixos-rebuild switch --flake .#legion
