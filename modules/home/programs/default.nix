{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) attrValues optionalAttrs;
  graphical = config.mama.profiles.graphical.enable;
  inherit (config.mama) desktop;
in
{
  imports = [
    ./difftastic.nix
    ./eza.nix
    ./ghostty.nix
    ./foot.nix
    ./git.nix
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
          telegram-desktop
          tutanota-desktop
          qpwgraph
          ;
      }
      // optionalAttrs (desktop == "gnome") {
        inherit (pkgs)
          foliate
          papers
          pwvucontrol
          quodlibet-full
          ;
      }
      // optionalAttrs (desktop == "plasma") {
        inherit (pkgs) haruna strawberry;
        inherit (pkgs.kdePackages) arianna;
      };

  programs = {
    bat.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  }
  // optionalAttrs graphical { keepassxc.enable = true; };
}
