{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mama.profiles.gaming.steam.enable = lib.mkEnableOption "Steam" // {
    default = config.mama.profiles.gaming.enable;
  };

  config = lib.mkIf config.mama.profiles.gaming.steam.enable {
    environment.systemPackages = [ pkgs.protonup-qt ];

    programs.steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      extest.enable = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
    };

    environment.sessionVariables = {
      PROTON_ENABLE_WAYLAND = 1;
      PROTON_USE_NTSYNC = 1;
      PROTON_ENABLE_NVAPI = lib.mkIf config.hardware.nvidia.enabled 1;
    };

    hardware.steam-hardware.enable = true;
    services.udev.packages = [ pkgs.game-devices-udev-rules ];
  };
}
