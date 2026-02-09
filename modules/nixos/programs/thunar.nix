{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mama.profiles.graphical.enable {
    programs.thunar = {
      enable = true;
      plugins = lib.attrValues { inherit (pkgs.xfce) thunar-archive-plugin thunar-volman; };
    };

    environment.systemPackages = lib.attrValues {
      inherit (pkgs) ffmpegthumbnailer libgsf;
      inherit (pkgs.kdePackages) ark;
    };
  };
}
