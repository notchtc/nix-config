{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) attrValues mergeAttrsList optionalAttrs;
  cfg = config.mama;
in
{
  imports = [
    ./bat.nix
    ./foot.nix
    ./ghostty.nix
    ./mpv.nix
    ./schizofox.nix
    ./vesktop.nix
    ./zsh.nix
    ./nix-index.nix
    ./eza.nix
    ./helix.nix
    ./xdg
    ./jj.nix
    ./git.nix
  ];

  home.packages = attrValues (mergeAttrsList [
    { inherit (pkgs) ffmpeg; }
    (optionalAttrs cfg.profiles.graphical.enable {
      inherit (pkgs)
        cardinal
        gimp3
        nicotine-plus
        papers
        picard
        pwvucontrol
        qbittorrent
        strawberry
        telegram-desktop
        ;
    })
  ]);

  programs = {
    bottom.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  }
  // optionalAttrs cfg.profiles.graphical.enable {
    foliate.enable = true;
    keepassxc.enable = true;
  };
}
