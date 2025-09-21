{
  imports = [
    ./console.nix
    ./documentation.nix
    ./locale.nix
    ./packages.nix
    ./paths.nix
    ./shell.nix
  ];
  system.etc.overlay.enable = true;
}
