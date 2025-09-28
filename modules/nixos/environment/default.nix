{
  imports = [
    ./console.nix
    ./documentation.nix
    ./etc.nix
    ./locale.nix
    ./packages.nix
    ./paths.nix
    ./shell.nix
  ];

  environment.stub-ld.enable = false;
}
