{
  config.packages.reactionary-plus = {
    systems = [ "x86_64-linux" ];

    package =
      { stdenvNoCC, fetchFromGitLab }:
      stdenvNoCC.mkDerivation {
        pname = "reactionary-plus";
        version = "0-unstable-2025-04-29";

        src = fetchFromGitLab {
          domain = "opencode.net";
          owner = "phob1an";
          repo = "Reactionary";
          rev = "4aa2d20f0e93ae4387a90947fcc6c90940c18122";
          hash = "sha256-obKYi85SEMSvoF9KY8TbU02mag57yr/03TvNNNa67N0=";
        };

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/{aurorae/themes,color-schemes,icons,plasma/desktoptheme,plasma/look-and-feel,sddm/themes}

          cp -a PLUS/desktoptheme/reactplus $out/share/plasma/desktoptheme/
          cp -a PLUS/look-and-feel/org.magpie.reactplus.desktop $out/share/plasma/look-and-feel/
          cp -a PLUS/themes/reactplus $out/share/aurorae/themes/
          cp -a PLUS/*.colors $out/share/color-schemes/

          cp -a icons/Reactionary $out/share/icons/

          cp -a wallpapers/Reactionary $out/share/wallpapers/

          cp -a sddm/themes/reactionary $out/share/sddm/themes/
          cp -a KDE1/sddm/themes/reactionary-kde1 $out/share/sddm/themes/

          runHook postInstall
        '';
      };
  };
}
