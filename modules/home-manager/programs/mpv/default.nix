{config, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      save-position-on-quit = true;
      hwdec = "auto-copy";
      hwdec-codecs = "all";
      hr-seek-framedrop = "no";
      gpu-api = "vulkan";
      vulkan-swap-mode = "mailbox";
      deband = "yes";
      deband-iterations = 3;
      deband-threshhold = 45;
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
