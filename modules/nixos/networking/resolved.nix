{
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    dnssec = "false";
    llmnr = "false";
    fallbackDns = [ "9.9.9.9" ];
  };
}
