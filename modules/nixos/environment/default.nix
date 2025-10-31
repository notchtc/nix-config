{
  imports = [
    ./console.nix
    ./documentation.nix
    ./locale.nix
    ./packages.nix
    ./paths.nix
    ./shell.nix
  ];

  environment.stub-ld.enable = false;
  system.etc.overlay = {
    enable = true;
    mutable = false;
  };
}
