{ lib, osConfig, ... }:
{
  programs.mpv = lib.mkIf osConfig.mama.profiles.graphical.enable {
    enable = true;
    config = {
      profile = "high-quality";
      hwdec = "auto-safe";
      gpu-context = "waylandvk";
      vo = "gpu-next";

      dither-depth = 8;

      dscale = "mitchell";
      cscale = "ewa_lanczossharp";

      scale-antiring = 0.6;
      dscale-antiring = 0.6;
      cscale-antiring = 0.6;

      correct-downscaling = "yes";
      linear-downscaling = "yes";

      tone-mapping = "bt.2446a";

      deband = "yes";
      deband-iterations = 4;
      deband-threshold = 64;
      deband-range = 20;
      deband-grain = 64;

      video-sync = "display-resample";

      audio-file-auto = "fuzzy";
      sub-auto = "fuzzy";
      volume = 100;
      volume-max = 100;

      save-position-on-quit = true;
      force-seekable = "yes";
      pause = "yes";

      ytdl-format = "bestvideo+bestaudio/best";
      hls-bitrate = "max";

      cache = "yes";
      demuxer-max-back-bytes = "20M";
      demuxer-max-bytes = "20M";
    };
  };
}
