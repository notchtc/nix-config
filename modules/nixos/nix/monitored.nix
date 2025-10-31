{ project, system, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      nix-monitored = project.inputs.nix-monitored.result.packages.${system}.default.override {
        nix = final.lixPackageSets.git.lix;
      };
      nixos-rebuild = prev.nixos-rebuild.override { nix = final.nix-monitored; };
    })
  ];
}
