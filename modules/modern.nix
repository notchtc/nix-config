{
  config.modules.nixos.modern = {
    system = {
      nixos-init.enable = true;

      etc.overlay = {
        enable = true;
        mutable = false;
      };
    };

    services.userborn = {
      enable = true;
      passwordFilesLocation = "/var/lib/nixos";
    };
  };
}
