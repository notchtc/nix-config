{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.wireless.iwd = {
    enable = true;

    settings = {
      Settings.AutoConnect = true;
      General.AddressRandomization = "network";
    };
  };

  environment.systemPackages = lib.mkIf config.mama.profiles.graphical.enable [ pkgs.iwgtk ];
}
