{
  config,
  lib,
  inputs,
  withSystem,
  ...
}: let
  inherit lib;
  inherit (lib) types;

  homeOpts = opts @ {
    config,
    lib,
    name,
    ...
  }: {
    options = {
      system = lib.mkOption {
        type = types.enum [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ];

        description = "System architecture for the configuration.";
      };

      stateVersion = lib.mkOption {
        type = types.str;
        description = "home-manager state version, changing this value DOES NOT update your config.";
      };

      modules = lib.mkOption {
        type = types.listOf types.unspecified;
        description = "List of home-manager modules to include in the configuration.";
      };

      _home = lib.mkOption {
        type = types.unspecified;
        readOnly = true;
        description = "Composed home-manager configuration.";
      };
    };

    config._home = withSystem config.system (
      ctx:
        inputs.home.lib.homeManagerConfiguration {
          # Default nixpkgs for home.nix
          pkgs = inputs.nixpkgs.legacyPackages.${ctx.system};

          modules =
            config.modules
            ++ [
              # Shared configuration across all users
              ../home-manager

              ({
                config,
                lib,
                ...
              }: {
                _module.args = ctx.extraModuleArgs;
                nixpkgs = removeAttrs ctx.nixpkgs ["hostPlatform"];

                home = {
                  username = __elemAt (lib.strings.split "@" name) 0;
                  enableNixpkgsReleaseCheck = false;
                  inherit (opts.config) stateVersion;

                  homeDirectory = lib.mkMerge [
                    "/home/${config.home.username}"
                  ];
                };
              })
            ];
        }
    );
  };
in {
  options.parts.homeConfigurations = lib.mkOption {
    type = types.attrsOf (types.submodule homeOpts);
  };

  config.flake.homeConfigurations = __mapAttrs (_: value: value._home) config.parts.homeConfigurations;
}
