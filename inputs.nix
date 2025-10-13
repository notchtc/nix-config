{ config, lib }:
let
  pins = import ./npins { };
  pkgs = import pins.nixpkgs { };

  loaders = {
    preservation = "raw";
  };

  settings = {
    nixpkgs.configuration.allowUnfree = true;
    home-manager.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    nix-index-database.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    niri.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    openmw-nix.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    schizofox.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
  };
in
{
  config.inputs =
    builtins.mapAttrs (name: pin: {
      src = if name == "nixpkgs" then pin else pin { inherit pkgs; };

      loader = loaders.${name} or (lib.modules.when false { });
      settings = settings.${name} or (lib.modules.when false { });
    }) pins
    // {
      nixpkgs-flake = {
        inherit (config.inputs.nixpkgs) src;
        loader = "flake";
      };
    };
}
