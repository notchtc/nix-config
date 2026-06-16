{
  config.modules.home = {
    arianna = { pkgs, ... }: { packages = [ pkgs.kdePackages.arianna ]; };

    gwenview =
      { lib, pkgs, ... }:
      let
        inherit (lib.attrsets) genAttrs;
        inherit (lib.trivial) const flip;
      in
      {
        packages = [ pkgs.kdePackages.gwenview ];

        xdg.mime-apps.default-applications = flip genAttrs (const "org.kde.gwenview.desktop") [
          "image/avif"
          "image/bmp"
          "image/gif"
          "image/heic"
          "image/jpeg"
          "image/png"
          "image/svg+xml"
          "image/tiff"
          "image/webp"
          "image/x-icon"
        ];
      };

    mpv =
      { lib, pkgs, ... }:
      let
        inherit (lib.attrsets) attrValues genAttrs;
        inherit (lib.trivial) const flip;
      in
      {
        rum.programs.mpv = {
          enable = true;

          scripts = attrValues { inherit (pkgs.mpvScripts) modernz mpris thumbfast; };

          config = {
            profile = "high-quality";
            hwdec = "auto-safe";
            gpu-context = "wayland";
            vo = "gpu-next";

            dither-depth = 8;

            dscale = "mitchell";
            cscale = "ewa_lanczossharp";

            scale-antiring = 0.6;
            dscale-antiring = 0.6;
            cscale-antiring = 0.6;

            correct-downscaling = true;
            linear-downscaling = true;

            tone-mapping = "bt.2446a";

            deband = true;
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
            force-seekable = true;
            pause = true;

            ytdl-format = "bestvideo+bestaudio/best";
            hls-bitrate = "max";

            cache = true;
            demuxer-max-back-bytes = "20M";
            demuxer-max-bytes = "20M";

            osc = false;
            title-bar = false;
          };
        };

        xdg.mime-apps.default-applications = flip genAttrs (const "mpv.desktop") [
          "video/mp4"
          "video/ogg"
          "video/quicktime"
          "video/webm"
          "video/x-matroska"
          "video/x-msvideo"
          "video/x-ms-wmv"
        ];
      };

    music =
      { lib, pkgs, ... }:
      let
        inherit (lib) attrValues;
        inherit (lib.attrsets) genAttrs;
        inherit (lib.trivial) const flip;
      in
      {
        packages = attrValues { inherit (pkgs) nicotine-plus picard strawberry; };

        xdg.mime-apps.default-applications =
          flip genAttrs (const "org.strawberrymusicplayer.strawberry.desktop")
            [
              "audio/aac"
              "audio/flac"
              "audio/mpeg"
              "audio/ogg"
              "audio/opus"
              "audio/wav"
              "audio-x-ms-wma"
            ];
      };
  };
}
