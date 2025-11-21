{ lib, ... }:
let
  inherit (lib) mkOption;
  inherit (lib.types) enum listOf;
in
{
  imports = [
    ./amd.nix
    ./intel.nix
    ./nvidia.nix
  ];

  options.mama.hardware.gpu = mkOption {
    type =
      listOf
      <| enum [
        "amd"
        "intel"
        "nvidia"
      ];
    default = [ ];
    description = "The manufacturer(s) of your GPU(s)";
  };
}
