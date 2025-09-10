{ lib, ... }:
{
  nix-mineral.overrides = {
    desktop = {
      allow-multilib = true;
      hideproc-ptraceable = true;
      #home-exec = true;
      skip-restrict-home-permission = true;
      tmp-exec = true;
    };
    security.disable-bluetooth-kmodules = lib.mkForce false;
  };

  fileSystems."/home" = {
    device = lib.mkForce "/dev/pool/root";
    options = lib.mkForce [
      "subvol=/home"
      "compress=zstd"
      "noatime"
      "exec"
      "nosuid"
      "nodev"
    ];
  };
}
