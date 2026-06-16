{
  # anything that's made useless by other parts of this config or I just don't need
  config.modules.nixos.remove-unused =
    { lib, ... }:
    let
      inherit (lib) mkForce;
    in
    {
      boot = {
        bcache.enable = false;
        kexec.enable = false;
      };

      services = {
        lvm.enable = false;
        fstrim.enable = false;
      };

      programs = {
        less.enable = mkForce false;
        nano.enable = false;
      };
    };
}
