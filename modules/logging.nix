{
  config.modules.nixos.logrotate =
    { lib, pkgs, ... }:
    let
      inherit (lib.meta) getExe getExe';
    in
    {
      services.logrotate.settings.header = {
        global = true;
        dateext = true;
        dateformat = "-%Y-%d-%m";
        nomail = true;
        missingok = true;
        copytruncate = true;

        priority = 1;
        frequency = "weekly";
        rotate = 7;
        minage = 7;

        compress = true;
        compresscmd = getExe pkgs.zstd;
        compressoptions = " -Xcompression-level 10";
        compressext = "zst";
        uncompresscmd = getExe' pkgs.zstd "unzstd";
      };
    };

  config.modules.nixos.journald = {
    services.journald.extraConfig = ''
      SystemMaxUse=100M
      RuntimeMaxUse=50M
      SystemMaxFileUse=50M
    '';
  };
}
