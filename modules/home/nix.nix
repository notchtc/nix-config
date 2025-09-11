{
  nix = {
    settings.use-xdg-base-directories = true;
    gc = {
      automatic = true;
      randomizedDelaySec = "15min";
      options = "--delete-older-than 7d";
    };
  };
}
