{
  config.modules.nixos.moor =
    { lib, pkgs, ... }:
    let
      inherit (lib.modules) mkForce;
    in
    {
      programs.less.enable = mkForce false;
      environment = {
        systemPackages = [ pkgs.moor ];
        variables = {
          PAGER = "moor";
          MANPAGER = "moor";
        };
      };
    };
}
