{ config }:
let
  pins = import ./npins;

  nixpkgs-flake = config.inputs.flake-compat.result.load {
    inherit (config.inputs.nixpkgs) src;
  };

  settings = {
    nixpkgs = {
      configuration = {
        allowUnfree = true;
      };
    };

    disko = {
      inputs = {
        nixpkgs = nixpkgs-flake;
      };
    };

    home-manager = {
      inputs = {
        nixpkgs = nixpkgs-flake;
      };
    };

    nix-index-database = {
      inputs = {
        nixpkgs = nixpkgs-flake;
      };
    };

    schizofox = {
      inputs = {
        nixpkgs = nixpkgs-flake;
      };
    };

    stylix = {
      inputs = {
        nixpkgs = nixpkgs-flake;
      };
    };
  };
in
{
  config = {
    inputs = builtins.mapAttrs (name: pin: {
      src = pin;

      settings = settings.${name} or (config.lib.modules.never { });
    }) pins;
  };
}
