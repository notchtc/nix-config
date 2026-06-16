{
  config.modules.nixos.nix =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (builtins) storePath;
      inherit (lib.modules) mkForce;
    in
    {
      imports = [
        inputs.nix-index-database.result.nixosModules.default
        inputs.nix-monitored.result.nixosModules.default
        "${inputs.srvos.result}/shared/mixins/trusted-nix-caches.nix"
      ];

      environment.systemPackages = [
        inputs.nilla-cli.result.packages.default.result.${pkgs.stdenv.hostPlatform.system}
        inputs.nilla-nixos.result.packages.default.result.${pkgs.stdenv.hostPlatform.system}
      ];

      nix.monitored = {
        enable = true;
        package = pkgs.nix-monitored.override { nix = pkgs.lixPackageSets.latest.lix; };
        notify = false;
      };

      nixpkgs.overlays = [ (_: prev: { comma = prev.comma.override { nix = config.nix.package; }; }) ];

      nix = {
        nixPath = [ "/etc/nix/nixpkgs" ];
        registry.nixpkgs.flake = mkForce inputs.nixpkgs-flake.result;

        settings = {
          accept-flake-config = false;
          auto-allocate-uids = true;
          auto-optimise-store = true;
          flake-registry = "";
          http3 = true;
          keep-going = true;
          log-format = "multiline-with-logs";
          max-jobs = "auto";
          sandbox = true;
          use-cgroups = true;
          use-xdg-base-directories = true;
          warn-dirty = false;

          experimental-features = [
            "auto-allocate-uids"
            "cgroups"
            "pipe-operator"
          ];

          deprecated-features = [
            "broken-string-escape"
            "or-as-identifier"
          ];

          substituters = [ "https://attic.xuyh0120.win/lantian" ];
          trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
        };

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };

      environment = {
        variables.NIXPKGS_CONFIG = mkForce "";
        etc."nix/nixpkgs".source = storePath pkgs.path;
      };

      system = {
        disableInstallerTools = true;
        tools.nixos-rebuild.enable = true;
      };

      programs.nix-index-database.comma.enable = true;

      systemd = {
        services.nix-gc.unitConfig.ConditionACPower = true;

        tmpfiles.rules = [
          "R /root/.nix-defexpr/channels - - - -"
          "R /nix/var/nix/profiles/per-user/root/channels - - - -"
        ];
      };
    };

}
