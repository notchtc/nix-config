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
    ./difftastic.nix
    ./eza.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./jj.nix
    ./librewolf.nix
    ./mpv.nix
    ./nix-index.nix
    ./vesktop.nix
    ./zsh.nix
  ];

  home.packages = attrValues (mergeAttrsList [
    { inherit (pkgs) ffmpeg moor; }

    (optionalAttrs graphical {
      inherit (pkgs)
        cardinal
        gimp
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
    bat.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  }
  // optionalAttrs graphical {
    foliate.enable = true;
    keepassxc.enable = true;
  };
}
