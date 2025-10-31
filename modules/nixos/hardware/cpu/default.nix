{ lib, ... }:
let
  inherit (lib) mkOption;
  inherit (lib.types) enum nullOr;
in
{
  imports = [
    ./amd.nix
    ./intel.nix
  ];

  options.mama.hardware.cpu = mkOption {
    type = nullOr (enum [
      "amd"
      "intel"
    ]);
    default = null;
    description = "The manufacturer of your CPU";
  };
}
