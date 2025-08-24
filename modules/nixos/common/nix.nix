{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  nix = {
    package = pkgs.lixPackageSets.latest.lix;

    channel.enable = false;
    optimise.automatic = true;
    nixPath = [ "/etc/nix/inputs" ];

    settings = {
      use-xdg-base-directories = true;
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

  environment = {
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
    }) inputs;
    systemPackages = [
      inputs.nilla-cli.result.packages.default.result.${pkgs.system}
      inputs.nilla-utils.result.packages.default.result.${pkgs.system}
    ];
  };

  system = {
    stateVersion = "25.11";
  };
}
