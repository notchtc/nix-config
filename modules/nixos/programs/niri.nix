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
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
    systemd.user.services.niri-flake-polkit.enable = lib.mkForce false;
  };
}
