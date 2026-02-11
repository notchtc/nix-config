{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.niri.result.nixosModules.niri ];
  nixpkgs.overlays = [ inputs.niri.result.overlays.niri ];

  programs.niri = lib.mkIf config.mama.profiles.graphical.enable {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
