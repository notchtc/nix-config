{
  config.modules.nixos.moor = { pkgs, ... }: {
    environment = {
      systemPackages = [ pkgs.moor ];
      variables = {
        BAT_PAGER = "moor -no-linenumbers";
        MANPAGER = "moor";
        PAGER = "moor";
        SYSTEMD_PAGERSECURE = "true";
      };
    };
  };
}
