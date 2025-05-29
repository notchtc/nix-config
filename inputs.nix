{ config }:
let
  pins = import ./npins;

  nixpkgs-flake = config.inputs.flake-compat.result.load {
    src = config.inputs.nixpkgs.src;
  };

  loaders = {
    home-manager = "flake";
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

      loader = loaders.${name} or (config.lib.modules.when false { });
      settings = settings.${name} or (config.lib.modules.when false { });
    }) pins;
  };
}
