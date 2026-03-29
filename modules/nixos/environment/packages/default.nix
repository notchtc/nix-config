{
  config,
  inputs,
  lib,
  pkgs,
  system,
  ...
}:
{
  imports = [ ./replacements.nix ];

  environment = {
    defaultPackages = lib.mkForce [ ];

    systemPackages =
      lib.attrValues
      <|
        {
          inherit (pkgs)
            _7zz-rar
            bat
            bottom
            cyme
            deadnix
            dust
            fd
            ffmpeg
            file
            git
            jq
            moor
            ripgrep
            statix
            ;

          inherit (pkgs.ghostty) terminfo;

          npins = inputs.npins.result { inherit pkgs system; };
        }
        // lib.optionalAttrs config.mama.profiles.graphical.enable {
          inherit (pkgs)
            gimp
            keepassxc
            file-roller
            nemo-with-extensions
            nicotine-plus
            picard
            pwvucontrol
            qbittorrent
            strawberry
            tutanota-desktop
            ;

          inherit (pkgs.kdePackages) arianna gwenview okular;

          nvtop = pkgs.nvtopPackages.full;
          telegram = pkgs.telegram-desktop.override { withWebkit = false; };
        };
  };
}
