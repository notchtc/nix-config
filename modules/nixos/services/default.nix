{ config, lib, ... }:
{
  imports = [
    ./greetd.nix
    ./journald.nix
    ./keyd.nix
    ./kmscon.nix
    ./logrotate.nix
    ./ntpd-rs.nix
    ./oomd.nix
    ./scx.nix
    ./snowflake.nix
    ./systemd.nix
    ./zram.nix
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
