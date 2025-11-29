{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib) attrValues optionalAttrs;
  graphical = osConfig.mama.profiles.graphical.enable;
in
{
  imports = [
    ./difftastic.nix
    ./eza.nix
    ./git.nix
    ./ghostty.nix
    ./haruna.nix
    ./helix.nix
    ./jj.nix
    ./librewolf.nix
    ./mpv.nix
    ./nix-index.nix
    ./vesktop.nix
    ./zsh.nix
  ];

  home.packages =
    attrValues
    <|
      {
        inherit (pkgs) tlrc;
      }
      // optionalAttrs graphical {
        inherit (pkgs)
          cardinal
          gimp
          nicotine-plus
          picard
          qbittorrent
          strawberry
          telegram-desktop
          tutanota-desktop
          qpwgraph
          ;
      };

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
