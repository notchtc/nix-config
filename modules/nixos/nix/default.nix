{
  config,
  lib,
  pkgs,
  project,
  ...
}:
{
  imports = [
    ./substituters.nix
    ./tools.nix
  ];

  nix = {
    package = pkgs.lixPackageSets.git.lix;

    channel.enable = false;
    daemonCPUSchedPolicy = lib.mkIf config.mama.profiles.graphical.enable "idle";
    optimise.automatic = true;
    nixPath = [ "/etc/nix/inputs" ];

    settings = {
      use-xdg-base-directories = true;
      accept-flake-config = false;
      auto-optimise-store = true;
      keep-going = true;
      sandbox = true;
      use-cgroups = true;
      max-jobs = "auto";

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
      options = "--delete-older-than 7d";
    };
  };

  environment = {
    variables.NIXPKGS_CONFIG = lib.mkForce "";
    etc = lib.mapAttrs' (name: value: {
      name = "nix/inputs/${name}";
      value.source =
        if
          (lib.strings.isStringLike value.result)
          && (lib.strings.hasPrefix builtins.storeDir (builtins.toString value.result))
        then
          builtins.storePath value.result
        else
          builtins.storePath value.src;
    }) project.inputs;
  };

  systemd.services.nix-gc.unitConfig.ConditionACPower = true;
}
