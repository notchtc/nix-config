{
  self,
  inputs,
  ...
}: {
  imports = [
    ./home-manager.nix
    ./nixos.nix
  ];

  perSystem = {
    lib,
    pkgs,
    system,
    inputs',
    ...
  }: {
    _module.args = rec {
      nix = import ./nix-settings.nix {
        inherit lib inputs inputs';
      };

      nixpkgs = {
        config = lib.mkForce {
          allowUnfree = true;
        };

        hostPlatform = system;

        overlays = lib.mkForce [
          self.overlays.default

          inputs.nur.overlay
        ];
      };

      extraModuleArgs = {
        inherit inputs' system;
        inputs = lib.mkForce inputs;

        branches = let
          pkgsFrom = branch: system:
            import branch {
              inherit system;
              inherit (nixpkgs) config overlays;
            };
        in {
          master = pkgsFrom inputs.master system;
          unstable = pkgsFrom inputs.unstable system;
          stable = pkgsFrom inputs.stable system;
        };
      };

      basePackagesFor = pkgs:
        __attrValues {
          inherit
            (pkgs)
            vim
            curl
            fd
            ripgrep
            man-pages-posix
            wget
            git
            ;

          home-manager = inputs'.home.packages.home-manager.override {path = "${inputs.home}";};

          man-pages = pkgs.man-pages;

          gnu-coreutils = pkgs.coreutils;
        };
    };
    formatter = inputs.alejandra.defaultPackage.${system};
  };
}
