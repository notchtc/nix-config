{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        cantarell-fonts
        liberation_ttf
        iosevka
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        ;

      nerdfonts = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
    };

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = ["DejaVu Serif"];
        sansSerif = ["Iosevka Aile"];
        monospace = ["Iosevka Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
