{lib, ...}: {
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.backend = "iwd";
      insertNameservers = ["45.90.28.26" "45.90.30.26"];
    };
  };

  services = {
    openssh.enable = true;
    resolved.enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
