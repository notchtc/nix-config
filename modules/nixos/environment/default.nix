{ lib, ... }:
{
  imports = [
    ./documentation.nix
    ./locale.nix
    ./packages.nix
    ./paths.nix
    ./shell.nix
    ./variables.nix
  ];

  environment.stub-ld.enable = false;
  console.enable = false;
  fonts.fontconfig.enable = lib.mkDefault false;

  system.etc.overlay = {
    enable = true;
    mutable = false;
  };
}
