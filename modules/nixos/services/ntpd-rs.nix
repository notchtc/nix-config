{
  services = {
    timesyncd.enable = false;
    ntpd-rs = {
      enable = true;
      settings = {
        source =
          [
            "time.cloudflare.com"
            "ntppool1.time.nl"
            "nts.netnod.se"
            "ptbtime1.ptb.de"
            "time.dfm.dk"
            "time.cifelli.xyz"
          ]
          |> map (address: {
            inherit address;
            mode = "nts";
          });
      };
    };
  };
}
