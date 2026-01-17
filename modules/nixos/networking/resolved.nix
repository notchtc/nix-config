{
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "true";
      DNSSEC = "true";
      LLMNR = "false";
      FallbackDNS = [ "9.9.9.9" ];
    };
  };
  systemd.services.systemd-resolved.stopIfChanged = false;
}
