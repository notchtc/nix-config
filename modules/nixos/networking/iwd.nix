{
  networking.wireless.iwd = {
    enable = true;

    settings = {
      Settings.AutoConnect = true;
      General.AddressRandomization = "network";
    };
  };
}
