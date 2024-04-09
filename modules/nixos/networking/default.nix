{
  networking = {
    nameservers = [
      "45.90.28.26"
      "45.90.30.26"
    ];

    nftables.enable = true;
  };

  services = {
    openssh.enable = true;
    connman = {
      enable = true;
      wifi.backend = "iwd";
      extraConfig = ''
        PreferredTechnologies=ethernet,wifi
      '';
    };
  };
}
