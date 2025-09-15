{
  config,
  lib,
  pkgs,
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
    optimise.automatic = true;
    generateNixPathFromInputs = true;

    daemonCPUSchedPolicy = lib.mkIf config.mama.profiles.graphical.enable "idle";

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
        "nix-command"
      ];

    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment.variables.NIXPKGS_CONFIG = lib.mkForce "";
  systemd.services.nix-gc.unitConfig.ConditionACPower = true;
}
