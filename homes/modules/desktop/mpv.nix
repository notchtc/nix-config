{
  programs = {
    yt-dlp.enable = true;
    mpv = {
      enable = true;
      config = {
        save-position-on-quit = true;
        hwdec = "auto-safe";
        vo = "gpu";
        hr-seek-framedrop = "no";
        gpu-context = "wayland";
        deband = "yes";
        deband-iterations = 3;
        deband-threshold = 45;
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
  };
}
