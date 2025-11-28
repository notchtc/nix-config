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
    ./foot.nix
    ./git.nix
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
