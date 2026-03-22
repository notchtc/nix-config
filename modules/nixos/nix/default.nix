{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (builtins) storeDir storePath;
  inherit (lib) mapAttrs' mkForce;
  inherit (lib.strings) isStringLike hasPrefix;
in
{
  imports = [
    "${inputs.srvos.result}/shared/mixins/trusted-nix-caches.nix"
    ./overlay.nix
    ./tools.nix
  ];

  nix = {
    package = pkgs.nix-monitored;

    nixPath = [ "/etc/nix/inputs" ];
    registry.nixpkgs.flake = mkForce inputs.nixpkgs-flake.result;

    settings = {
      accept-flake-config = false;
      auto-optimise-store = true;
      flake-registry = "";
      keep-going = true;
      max-jobs = "auto";
      sandbox = true;
      use-cgroups = true;
      use-xdg-base-directories = true;
      warn-dirty = false;

      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "flakes"
        "nix-command"
        "pipe-operator"
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
    etc = mapAttrs' (name: value: {
      name = "nix/inputs/${name}";
      value.source =
        if isStringLike value.result && (hasPrefix storeDir <| toString value.result) then
          storePath value.result
        else
          storePath value.src;
    }) inputs;
  };
}
