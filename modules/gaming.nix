{
  config.modules = {
    nixos.gaming = { modules, pkgs, ... }: {
      boot.kernel.sysctl."kernel.split_lock_mitigate" = 0;

      environment = {
        systemPackages = [
          pkgs.heroic
          pkgs.fluidsynth
        ];

        variables = {
          PROTON_DLSS_UPGRADE = 1;
          PROTON_ENABLE_WAYLAND = 1;
          PROTON_USE_NTSYNC = 1;
          PROTON_USE_WOW64 = 1;
        };
      };

      programs = {
        gamescope = {
          enable = true;
          capSysNice = false;
        };

        steam = {
          enable = true;
          dedicatedServer.openFirewall = true;
          extest.enable = true;
          gamescopeSession.enable = true;
          localNetworkGameTransfers.openFirewall = true;
          protontricks.enable = true;
          remotePlay.openFirewall = true;

          extraCompatPackages = [ pkgs.proton-ge-bin ];
          extraPackages = [ pkgs.steamtinkerlaunch ];
        };
      };

      hardware.steam-hardware.enable = true;
      services.udev.packages = [ pkgs.game-devices-udev-rules ];

      hjem.extraModules = [ modules.home.gaming ];
    };

    home.gaming =
      { lib, pkgs, ... }:
      let
        inherit (lib.attrsets) genAttrs;
        inherit (lib.trivial) const flip;
      in
      {
        xdg = {
          config.files."heroic/tools/proton/GE-Proton".source = pkgs.proton-ge-bin.steamcompattool;
          mime-apps.default-applications = flip genAttrs (const "steam.desktop") [ "x-scheme-handler/steam" ];
        };
      };
  };
}
