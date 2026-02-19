{ config, lib }:
let
  pins = import ./npins { };
  pkgs = import pins.nixpkgs { };
  none = lib.modules.when false { };

  loaders = {
    agenix = "raw";
    home-manager = "raw";
  };

  settings = {
    nixpkgs.configuration.allowUnfree = true;

    autoaspm.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    niri.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    nix-index-database.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    nix-mineral.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    noctalia.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    openmw-nix.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    run0-sudo-shim.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    stylix.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
  };
in
{
  config.inputs = {
    nixpkgs-flake = {
      inherit (config.inputs.nixpkgs) src;
      loader = "flake";
    };
  }
  // builtins.mapAttrs (name: pin: {
    src = if name == "nixpkgs" then pin else pin { inherit pkgs; };

    loader = loaders.${name} or none;
    settings = settings.${name} or none;
  }) pins;
}
