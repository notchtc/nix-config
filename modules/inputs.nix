{ config, lib }:
let
  inherit (builtins) mapAttrs;
  inherit (lib.modules) merge when;

  pins = import ../npins;
  pkgs = import pins.nixpkgs { };

  loaders = {
    agenix = "raw";
    srvos = "raw";
    ucodenix = "raw";
  };

  settings.nixpkgs.configuration.allowUnfree = true;
in
{
  config.inputs =
    mapAttrs (name: pin: {
      src = if name == "nixpkgs" then pin else pin { inherit pkgs; };
      loader = loaders.${name} or (when false { });

      settings = merge [
        (settings.${name} or (when false { }))

        (when (config.inputs.${name}.loader == "flake") {
          inputs.nixpkgs = config.inputs.nixpkgs-flake.result;
        })
      ];
    }) (removeAttrs pins [ "__functor" ])
    // {
      nixpkgs-flake = {
        inherit (config.inputs.nixpkgs) src;
        loader = "flake";
      };
    };
}
