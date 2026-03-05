{ config, lib, ... }:
{
  imports = [
    ./greetd.nix
    ./kmscon.nix
    ./systemd.nix
  ];

  services = lib.mkIf config.mama.profiles.graphical.enable {
    gvfs.enable = true;
    udisks2.enable = true;
    dbus = {
      enable = true;
      implementation = "broker";
    };
  };
}
