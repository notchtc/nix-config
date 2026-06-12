{ inputs, pkgs, ... }: {

  nixpkgs.overlays = [
    (final: prev: {
      nix-monitored =
        inputs.nix-monitored.result.packages.${pkgs.stdenv.hostPlatform.system}.default.override
          { nix = final.lixPackageSets.latest.lix; };

      comma = prev.comma.override { nix = final.nix-monitored; };
      nix-direnv = prev.nix-direnv.override { nix = final.nix-monitored; };
      nixos-rebuild = prev.nixos-rebuild.override { nix = final.nix-monitored; };
    })
  ];
}
