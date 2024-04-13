{
  services.openssh.enable = true;

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      insertNameservers = [
        "45.90.28.26"
        "45.90.30.26"
      ];
    };

    nftables.enable = true;
  };
}
