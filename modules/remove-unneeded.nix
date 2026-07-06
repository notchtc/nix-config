{
  config.modules.nixos.remove-unneeded =
    { lib, ... }:
    let
      inherit (lib.modules) mkForce;
    in
    {
      boot = {
        bcache.enable = false;
        kexec.enable = false; # rendered useless
      };

      # replaced by kmscon
      console.enable = false;

      programs = {
        nano.enable = false; # we use helix
        less.enable = mkForce false; # we use moor
      };

      services.speechd.enable = false; # enabled by default, just takes up space
    };
}
