{ inputs, pkgs, ... }:
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
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = [
    inputs.nilla-cli.result.packages.default.result.${pkgs.system}
    inputs.nilla-utils.result.packages.default.result.${pkgs.system}
  ];

  system.stateVersion = "25.11";
}
