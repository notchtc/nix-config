{ config, ... }:
{
  programs.plasma.kscreenlocker = {
    autoLock = true;
    lockOnResume = true;
    passwordRequired = true;
    passwordRequiredDelay = 10;
    timeout = 3;
    appearance = {
      alwaysShowClock = true;
      showMediaControls = true;
      wallpaper = "${config.stylix.image}";
    };
  };
}
