{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.niri.result.nixosModules.niri ];

  config = lib.mkIf config.mama.profiles.graphical.enable {
    nixpkgs.overlays = [ inputs.niri.result.overlays.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    systemd.user.services.niri-flake-polkit.enable = lib.mkForce false;
  };
}
