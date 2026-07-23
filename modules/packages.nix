{
  config.modules.nixos.packages =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib.attrsets) attrValues optionalAttrs;
      inherit (lib.modules) mkForce;
    in
    {
      environment = {
        defaultPackages = mkForce [ ];

        systemPackages =
          attrValues
          <|
            {
              inherit (pkgs)
                _7zz
                bottom
                dash
                deadnix
                dust
                eza
                fd
                file
                gitMinimal
                jq
                npins
                ripgrep
                statix
                unrar
                uutils-coreutils-noprefix
                ;

              inherit (pkgs.ghostty) terminfo;
            }
            // optionalAttrs config.xdg.portal.enable {
              inherit (pkgs)
                feather
                ffmpeg
                gimp
                pwvucontrol
                sparrow
                tutanota-desktop
                yt-dlp
                ;

              nvtop = pkgs.nvtopPackages.amd.override {
                intel = true;
                nvidia = true;
              };
            };
      };
    };
}
