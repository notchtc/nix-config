{ pkgs, ... }:
{
  services.logrotate.settings = {
    header = {
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
      compresscmd = "${pkgs.zstd}/bin/zstd";
      compressoptions = " -Xcompression-level 10";
      compressext = "zst";
      uncompresscmd = "${pkgs.zstd}/bin/unzstd";
    };

    "/var/log/audit/audit.log" = {
      frequency = "daily";
      minsize = "500M";
      rotate = 3;
    };
  };
}
