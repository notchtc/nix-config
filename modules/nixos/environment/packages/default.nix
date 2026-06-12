{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./core.nix ];

  environment = {
    defaultPackages = lib.mkForce [ ];

    systemPackages =
      lib.attrValues
      <|
        {
          inherit (pkgs)
            uutils-coreutils-noprefix
            uutils-diffutils
            uutils-findutils
            uutils-hostname
            uutils-procps
            uutils-sed
            ;

          inherit (pkgs)
            _7zz-rar
            bat
            bottom
            deadnix
            dust
            fd
            ffmpeg
            file
            git
            jq
            moor
            npins
            nixfmt
            nixfmt-tree
            ripgrep
            statix
            ;

          inherit (pkgs.ghostty) terminfo;
        }
        // lib.optionalAttrs config.mama.profiles.graphical.enable {
          inherit (pkgs)
            cyanrip
            file-roller
            gimp
            keepassxc
            nemo-with-extensions
            nicotine-plus
            picard
            plugdata
            pwvucontrol
            qbittorrent
            qpwgraph
            renoise
            strawberry
            tutanota-desktop
            yt-dlp
            ;

          inherit (pkgs.kdePackages) arianna gwenview okular;

          nvtop = pkgs.nvtopPackages.full;
          telegram = pkgs.telegram-desktop.override { withWebkit = false; };
        };
  };
}
