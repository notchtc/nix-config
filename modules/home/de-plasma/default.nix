{ inputs, ... }:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ../desktop
    ./configFile.nix
    ./desktop.nix
    ./input.nix
    ./keybinds.nix
    ./krunner.nix
    ./kscreenlocker.nix
    ./kwin.nix
    ./panels.nix
    ./theme.nix
    ./window-rules.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    windows = {
      allowWindowsToRememberPositions = true;
    };
  };
}
