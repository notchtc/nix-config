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
    ./helix.nix
    ./jj.nix
    ./librewolf.nix
    ./mpv-haruna.nix
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
          tutanota-desktop
          qpwgraph
          ;

        inherit (pkgs.kdePackages) arianna;

        telegram = pkgs.telegram-desktop.override { withWebkit = false; };
      };

  programs = {
    bat.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  }
  // optionalAttrs graphical { keepassxc.enable = true; };
}
