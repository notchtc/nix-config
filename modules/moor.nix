{
  config.modules.nixos.moor = { pkgs, ... }: {
    environment = {
      systemPackages = [ pkgs.moor ];
      variables = {
        PAGER = "moor";
        MANPAGER = "moor";
      };
    };
  };
}
