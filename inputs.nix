{ config, lib }:
let
  pins = import ./npins { };
  pkgs = import pins.nixpkgs { };
  nothing = lib.modules.when false { };

  loaders = {
    agenix = "raw";
    plasma-manager = "raw";
  };

  settings = {
    nixpkgs.configuration.allowUnfree = true;
    home-manager.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    nix-index-database.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    openmw-nix.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    run0-sudo-shim.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
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

    loader = loaders.${name} or nothing;
    settings = settings.${name} or nothing;
  }) pins;
}
