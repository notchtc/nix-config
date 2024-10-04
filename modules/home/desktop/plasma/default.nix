{ inputs, ... }:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./configFile.nix
    ./desktop.nix
    ./input.nix
    ./krunner.nix
    ./kscreenlocker.nix
    ./kwin.nix
    ./panels.nix
    ./shortcuts.nix
    ./theme.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    windows = {
      allowWindowsToRememberPositions = true;
    };
  };
}
