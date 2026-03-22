{ inputs, system, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      nix-monitored = inputs.nix-monitored.result.packages.${system}.default.override {
        nix = final.lixPackageSets.git.lix;
      };

      comma = prev.comma.override { nix = final.nix-monitored; };
      nixos-rebuild = prev.nixos-rebuild.override { nix = final.nix-monitored; };
    })
  ];
}
