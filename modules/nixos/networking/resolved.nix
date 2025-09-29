{
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    dnssec = "false";
    llmnr = "false";
    fallbackDns = [ "9.9.9.9" ];
  };
}
