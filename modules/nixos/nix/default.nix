{
  config,
  lib,
  pkgs,
  project,
  ...
}:
let
  inherit (lib) mapAttrs' mkForce optionalAttrs;
  inherit (lib.strings) isStringLike hasPrefix;
  graphical = config.mama.profiles.graphical.enable;
in
{
  imports = [
    ./monitored.nix
    ./substituters.nix
    ./tools.nix
  ];

  nix = {
    package = pkgs.nix-monitored;

    channel.enable = false;

    optimise.automatic = true;
    nixPath = [ "/etc/nix/inputs" ];

    settings = {
      min-free = 5 * 1024 * 1024 * 1024;
      max-free = 20 * 1024 * 1024 * 1024;

      accept-flake-config = false;
      auto-optimise-store = true;
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
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  }
  // optionalAttrs graphical {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;
  };

  environment = {
    variables.NIXPKGS_CONFIG = mkForce "";
    etc = mapAttrs' (name: value: {
      name = "nix/inputs/${name}";
      value.source =
        if (isStringLike value.result) && (hasPrefix builtins.storeDir (toString value.result)) then
          builtins.storePath value.result
        else
          builtins.storePath value.src;
    }) project.inputs;
  };

  systemd.services.nix-gc.unitConfig.ConditionACPower = true;
}
