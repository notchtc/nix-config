{
  config.modules.nixos.firmware = {
    hardware.enableRedistributableFirmware = true;
    services.fwupd.enable = true;
  };
}
