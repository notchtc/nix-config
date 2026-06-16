{
  config.modules.nixos.run0 = { inputs, pkgs, ... }: {
    environment.systemPackages = [
      #  pkgs.run0-sudo-shim
      inputs.run0-sudo-shim.result.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    security = {
      #      run0.enable = true;

      sudo.enable = false;

      #      polkit.enablePkexecWrapper = false;
      wrappers = {
        su.enable = false;
        sg.enable = false;
      };
    };
  };
}
