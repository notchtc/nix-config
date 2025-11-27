{ lib, ... }:
{
  imports = [
    ./amd.nix
    ./intel.nix
  ];

  options.mama.hardware.cpu = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "amd"
        "intel"
      ]
    );
    default = null;
    description = "The manufacturer of your CPU";
  };
}
