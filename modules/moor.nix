{
  config.modules.nixos.moor = { pkgs, ... }: {
    environment = {
      systemPackages = [ pkgs.moor ];
      variables = {
        SYSTEMD_PAGERSECURE = "true";
        PAGER = "moor";
        MANPAGER = "moor";
      };
    };
  };
}
