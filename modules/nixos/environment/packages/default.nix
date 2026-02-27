{
  config,
  inputs,
  lib,
  pkgs,
  system,
  ...
}:
{
  imports = [
    ./core.nix
    ./uutils.nix
  ];

  environment = {
    defaultPackages = lib.mkForce [ ];

    systemPackages =
      lib.attrValues
      <|
        {
          inherit (pkgs)
            bottom
            deadnix
            ffmpeg
            file
            git
            moor
            statix
            ;

          inherit (pkgs.ghostty) terminfo;

          npins = inputs.npins.result { inherit pkgs system; };
        }
        // lib.optionalAttrs config.mama.profiles.graphical.enable {
          inherit (pkgs)
            gimp
            keepassxc
            nicotine-plus
            pcmanfm-qt
            picard
            pwvucontrol
            qbittorrent
            strawberry
            tutanota-desktop
            ;

          inherit (pkgs.kdePackages)
            arianna
            ark
            gwenview
            okular
            ;

          nvtop = pkgs.nvtopPackages.full;
          telegram = pkgs.telegram-desktop.override { withWebkit = false; };
        };
  };
}
