{
  config.modules.nixos.xdg-portals = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;

      config.niri.default = [
        "gnome"
        "gtk"
      ];
    };
  };
}
