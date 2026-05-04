{
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "opportunistic";
      DNSSEC = "allow-downgrade";
      LLMNR = "false";
    };
  };
}
