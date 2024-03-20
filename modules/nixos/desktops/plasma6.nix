{ lib, pkgs, ... }:
{
  environment.systemPackages = lib.attrValues { inherit (pkgs.kdePackages) sddm-kcm; };

  services = {
    xserver = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
        defaultSession = "plasma";
      };
    };

    desktopManager.plasma6.enable = true;
  };

  programs.gnupg.agent.pinentryPackage = lib.mkForce pkgs.pinentry-qt;

  environment.plasma6.excludePackages = lib.attrValues {
    inherit (pkgs.kdePackages) elisa kate konsole;
  };
}
