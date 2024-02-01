{config, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      save-position-on-quit = true;
      hwdec = "auto-copy";
      hwdec-codecs = "all";
      deband = "yes";
      deband-iterations = 3;
      deband-treshhold = 45;
      deband-range = 25;
      deband-grain = 15;
      dither-depth = "auto";
      volume = 100;
      volume-max = 100;
      scale = "ewa_lanczossharp";
      dscale = "mitchell";
      cscale = "spline36";
    };
  };
}
