{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) attrValues mergeAttrsList optionalAttrs;
  graphical = config.mama.profiles.graphical.enable;
  inherit (config.mama) desktop;
in
{
  imports = [
    ./bat.nix
    ./difftastic.nix
    ./ghostty.nix
    ./mpv.nix
    ./schizofox.nix
    ./vesktop.nix
    ./zsh.nix
    ./nix-index.nix
    ./eza.nix
    ./helix.nix
    ./jj.nix
    ./git.nix
  ];

  home.packages = attrValues (mergeAttrsList [
    { inherit (pkgs) ffmpeg; }

    (optionalAttrs graphical {
      inherit (pkgs)
        cardinal
        gimp3
        nicotine-plus
        picard
        qbittorrent
        telegram-desktop
        tutanota-desktop
        qpwgraph
        ;
    })

    (optionalAttrs (desktop == "gnome") { inherit (pkgs) papers pwvucontrol quodlibet-full; })
    (optionalAttrs (desktop == "plasma") { inherit (pkgs) haruna strawberry; })
  ]);

  programs = {
    bottom.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  }
  // optionalAttrs graphical {
    foliate.enable = true;
    keepassxc.enable = true;
  };
}
