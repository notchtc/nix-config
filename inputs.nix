{ config }:
let
  pins = import ./npins;

  nixpkgs-flake = config.inputs.flake-compat.result.load {
    inherit (config.inputs.nixpkgs) src;
  };

  loaders = {
    nixos-hardware = "raw";
    "nixos-25.05" = "flake";
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

      loader = loaders.${name} or (config.lib.modules.never { });
      settings = settings.${name} or (config.lib.modules.never { });
    }) pins;
  };
}
