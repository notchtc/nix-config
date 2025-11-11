{ pkgs, ... }:
{
  imports = [
    ./console.nix
    ./documentation.nix
    ./locale.nix
    ./packages.nix
    ./paths.nix
    ./shell.nix
  ];

  environment = {
    stub-ld.enable = false;
    variables.PAGER = "${pkgs.moor}/bin/moor";
  };

  system.etc.overlay = {
    enable = true;
    mutable = false;
  };
}
