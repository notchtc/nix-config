{
  config.modules.home.media =
    { lib, pkgs, ... }:
    let
      inherit (lib.attrsets) attrValues genAttrs;
      inherit (lib.meta) getExe';
      inherit (lib.trivial) const flip;
    in
    {
      packages = attrValues {
        inherit (pkgs) nicotine-plus picard strawberry;
        inherit (pkgs.kdePackages) arianna gwenview;
        inherit (pkgs.mpvScripts) modernz mpris thumbfast;
      };

      systemd.services.nicotine-plus = {
        description = "Nicotine";
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];

        serviceConfig.ExecStart = "${getExe' pkgs.nicotine-plus "nicotine"} --hidden";
      };

      xdg = {
        config.files."mpv/mpv.conf".text = ''
          audio-file-auto=fuzzy
          cache=yes
          correct-downscaling=yes
          cscale=ewa_lanczossharp
          cscale-antiring=0.600000
          deband=yes
          deband-grain=64
          deband-iterations=4
          deband-range=20
          deband-threshold=64
          demuxer-max-back-bytes=20M
          demuxer-max-bytes=20M
          dither-depth=8
          dscale=mitchell
          dscale-antiring=0.600000
          force-seekable=yes
          gpu-context=wayland
          hls-bitrate=max
          hwdec=auto-safe
          linear-downscaling=yes
          osc=no
          pause=yes
          profile=high-quality
          save-position-on-quit=yes
          scale-antiring=0.600000
          sub-auto=fuzzy
          title-bar=no
          tone-mapping=bt.2446a
          video-sync=display-resample
          vo=gpu-next
          volume=100
          volume-max=100
          ytdl-format=bestvideo+bestaudio/best
        '';

        mime-apps.default-applications =
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
      };
    };
}
