{ lib, ... }:
{
  imports = [
    ./amd.nix
    ./intel.nix
    ./nvidia.nix
  ];

  options.mama.hardware.gpu = lib.mkOption {
    type = lib.types.listOf (
      lib.types.enum [
        "amd"
        "intel"
        "nvidia"
      ]
    );
    default = [ ];
    description = "The manufacturer(s) of your GPU(s)";
  };
}
