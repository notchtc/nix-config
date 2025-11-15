{
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    dnssec = "allow-downgrade";
    llmnr = "false";
    fallbackDns = [ "9.9.9.9" ];
  };
}
