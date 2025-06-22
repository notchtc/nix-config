{ pkgs, ... }:
{
  security = {
    rtkit.enable = true;
    sudo.enable = false;

    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  environment.systemPackages = [ pkgs.doas-sudo-shim ];
}
