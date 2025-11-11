{
  nix = {
    settings.use-xdg-base-directories = true;
    gc = {
      automatic = true;
      randomizedDelaySec = "15min";
      options = "--delete-older-than 7d";
    };
  };

  services.home-manager.autoExpire = {
    enable = true;
    frequency = "weekly";
    timestamp = "-7 days";
  };
}
