{
  config,
  lib,
  inputs,
}: {
  registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

  nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

  optimise.automatic = true;
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  settings = lib.mkMerge [
    {
      use-xdg-base-directories = true;
      experimental-features = ["nix-command" "flakes" "ca-derivations" "auto-allocate-uids"];
      max-jobs = "auto";

      trusted-users = ["chtc"];
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://cache.ngi0.nixos.org/"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    }
  ];
}
