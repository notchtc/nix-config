{
  config.modules.nixos.modern =
    { lib, ... }:
    let
      inherit (lib.modules) mkForce;
    in
    {
      programs.fuse.enable = mkForce false;

      system = {
        nixos-init.enable = true;

        etc.overlay = {
          enable = true;
          mutable = false;
        };
      };

      security = {
        account-utils.enable = true;
        polkit.enablePkexecWrapper = false;

        wrappers = {
          su.enable = false;
          sg.enable = false;
          newgrp.enable = false;
        };
      };

      services.userborn = {
        enable = true;
        passwordFilesLocation = "/var/lib/nixos";
      };

      systemd.settings.Manager.NoNewPrivileges = true;
    };
}
