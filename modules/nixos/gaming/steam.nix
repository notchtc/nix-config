{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mama.profiles) gaming;
in
{
  options.mama.profiles.gaming.steam.enable = mkEnableOption "Steam" // {
    default = gaming.enable;
  };

  config = mkIf gaming.steam.enable {
    programs.steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      extest.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
    };

    environment.variables = {
      PROTON_ENABLE_WAYLAND = 1;
      PROTON_USE_NTSYNC = 1;
      PROTON_ENABLE_NVAPI = mkIf config.hardware.nvidia.enabled 1;
    };

    hardware.steam-hardware.enable = true;
    services.udev.packages = [ pkgs.game-devices-udev-rules ];
  };
}
