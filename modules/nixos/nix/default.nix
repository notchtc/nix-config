{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkForce;
in
{
  imports = [
    "${inputs.srvos.result}/shared/mixins/trusted-nix-caches.nix"
    ./lix-monitored.nix
    ./substituters.nix
    ./tools.nix
  ];

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
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  systemd = {
    services.nix-gc.unitConfig.ConditionACPower = true;

    tmpfiles.rules = [
      "R /root/.nix-defexpr/channels - - - -"
      "R /nix/var/nix/profiles/per-user/root/channels - - - -"
    ];
  };

  environment = {
    variables.NIXPKGS_CONFIG = mkForce "";
    etc."nix/nixpkgs".source = builtins.storePath pkgs.path;
  };
}
