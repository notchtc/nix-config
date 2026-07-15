{ config, lib }:
let
  inherit (builtins) mapAttrs;
  inherit (lib.modules) when;

  pins = import ../npins;
  pkgs = import pins.nixpkgs { };

  loaders = {
    agenix = "raw";
    srvos = "raw";
    ucodenix = "raw";
  };

  settings = {
    nixpkgs.configuration.allowUnfree = true;

    autoaspm.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    hjem.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    hjem-rum.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    nix-index-database.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    nix-mineral.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    noctalia.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
    qtengine.inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
  };
in
{
  config.inputs =
    mapAttrs (name: pin: {
      src = if name == "nixpkgs" then pin else pin { inherit pkgs; };
      loader = loaders.${name} or (when false { });
      settings = settings.${name} or (when false { });
    }) (removeAttrs pins [ "__functor" ])
    // {
      nixpkgs-flake = {
        inherit (config.inputs.nixpkgs) src;
        loader = "flake";
      };
    };
}
