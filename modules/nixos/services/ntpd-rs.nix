{ lib, ... }:
{
  services = {
    timesyncd.enable = false;
    ntpd-rs = {
      enable = true;
      settings = {
        source =
          lib.map
            (address: {
              inherit address;
              mode = "nts";
            })
            [
              "time.cloudflare.com"
              "ntppool1.time.nl"
              "nts.netnod.se"
              "ptbtime1.ptb.de"
              "time.dfm.dk"
              "time.cifelli.xyz"
            ];
      };
    };
  };
}
