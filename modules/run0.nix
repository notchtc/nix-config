{
  config.modules.nixos.run0 = {
    security = {
      run0 = {
        enable = true;
        sudo-shim.enable = true;
      };

      sudo.enable = false;

      polkit.enablePkexecWrapper = false;
      wrappers = {
        su.enable = false;
        sg.enable = false;
      };
    };
  };
}
