{
  config.modules.nixos.documentation = {
    documentation = {
      dev.enable = false;
      doc.enable = false;
      info.enable = false;
      nixos.enable = false;
      man = {
        enable = true;
        cache.enable = true;
        man-db.enable = false;
        mandoc.enable = true;
      };
    };
  };
}
