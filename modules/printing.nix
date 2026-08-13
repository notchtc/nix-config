{
  config.modules.nixos.printing = {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
      };

      printing.enable = true;
    };
  };
}
