{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    channel.enable = false;
    optimise.automatic = true;
    generateNixPathFromInputs = true;

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

      substituters = [
        "https://aseipp-nix-cache.freetls.fastly.net?priority=10"
        "https://cache.nixos.org?priority=20"
        "https://nix-community.cachix.org?priority=30"
        "https://cache.garnix.io?priority=40"
        "https://numtide.cachix.org?priority=50"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment = {
    systemPackages = [
      inputs.nilla-cli.result.packages.default.result.${pkgs.system}
      inputs.nilla-utils.result.packages.default.result.${pkgs.system}
    ];
    variables.NIXPKGS_CONFIG = lib.mkForce "";
  };

  system = {
    disableInstallerTools = true;
    tools.nixos-rebuild.enable = true;
    stateVersion = "25.11";
  };
}
