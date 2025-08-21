{ lib, ... }:
{
  nix-mineral.overrides = {
    desktop = {
      allow-multilib = true;
      hideproc-off = true;
      #home-exec = true;
      skip-restrict-home-permission = true;
      tmp-exec = true;
    };
    security.disable-bluetooth-kmodules = lib.mkForce false;
  };

  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
}
