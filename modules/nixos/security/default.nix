{
  imports = [
    ./kernel.nix
    ./mineral.nix
    ./run0.nix
  ];

  security.wrappers.su.enable = false;
}
