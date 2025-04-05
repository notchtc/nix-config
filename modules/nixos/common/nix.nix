{ inputs, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    registry = {
      home-manager.flake = inputs.home-manager;
      nixpkgs.flake = inputs.nixpkgs;
    };

    package = pkgs.lixPackageSets.stable.lix;

    optimise.automatic = true;
    channel.enable = false;

    settings = {
      use-xdg-base-directories = true;

      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "flakes"
        "nix-command"
      ];

      substituters = [
        "https://cache.lix.systems"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 1w";
    };
  };
}
