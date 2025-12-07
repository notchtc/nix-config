{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (builtins) storeDir storePath;
  inherit (lib) mapAttrs' mkForce optionalAttrs;
  inherit (lib.strings) isStringLike hasPrefix;
in
{
  imports = [
    ./overlay.nix
    ./substituters.nix
    ./tools.nix
  ];

  nix = {
    package = pkgs.nix-monitored;

    channel.enable = false;

    optimise.automatic = true;

    nixPath = [ "/etc/nix/inputs" ];
    registry.nixpkgs.flake = mkForce inputs.nixpkgs-flake.result;

    settings = {
      min-free = 5 * 1024 * 1024 * 1024;
      max-free = 20 * 1024 * 1024 * 1024;

      accept-flake-config = false;
      auto-optimise-store = true;
      flake-registry = "";
      keep-going = true;
      max-jobs = "auto";
      sandbox = true;
      use-cgroups = true;
      use-xdg-base-directories = true;
      warn-dirty = false;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "pipe-operator"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  }
  // optionalAttrs config.mama.profiles.graphical.enable {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;
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
