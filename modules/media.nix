{
  config.modules.home.media =
    { lib, pkgs, ... }:
    let
      inherit (lib.attrsets) attrValues genAttrs;
      inherit (lib.meta) getExe';
      inherit (lib.modules) mkForce;
      inherit (lib.trivial) const flip;
    in
    {
      packages = attrValues {
        inherit (pkgs) nicotine-plus picard strawberry;
        inherit (pkgs.kdePackages) arianna gwenview;
      };

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

      systemd.services.nicotine-plus = {
        description = "Nicotine";
        path = mkForce [ ];
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];

        serviceConfig.ExecStart = "${getExe' pkgs.nicotine-plus "nicotine"} --hidden";
      };

      xdg.mime-apps =
        let
          defaults =
            flip genAttrs (const "org.kde.gwenview.desktop") [
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
            ]
            // flip genAttrs (const "mpv.desktop") [
              "video/mp4"
              "video/ogg"
              "video/quicktime"
              "video/webm"
              "video/x-matroska"
              "video/x-msvideo"
              "video/x-ms-wmv"
            ]
            // flip genAttrs (const "org.strawberrymusicplayer.strawberry.desktop") [
              "audio/aac"
              "audio/flac"
              "audio/mpeg"
              "audio/ogg"
              "audio/opus"
              "audio/wav"
              "audio-x-ms-wma"
            ];
        in
        {
          added-associations = defaults;
          default-applications = defaults;
        };
    };
}
