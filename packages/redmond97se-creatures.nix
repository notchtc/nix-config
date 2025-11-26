{
  config.packages.redmond97se-creatures = {
    systems = [ "x86_64-linux" ];

    package =
      {
        stdenvNoCC,
        fetchurl,
        _7zz,
      }:
      let
        version = "2.04";
      in
      stdenvNoCC.mkDerivation {
        pname = "redmond97se-creatures";
        inherit version;

        src = fetchurl {
          url = "https://codeberg.org/Sliver_X/Redmond97-SE/releases/download/v${version}/Redmond97-SE_v${version}_Themes_Only.7z";
          hash = "sha256-rf7WQBosHs7IMllnS4LIAoy+LHmByUTZzi/7Z3dddR4=";
        };

        unpackPhase = ''
          runHook preUnpack

          7zz x $src

          runHook postUnpack
        '';

        nativeBuildInputs = [ _7zz ];

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/themes
          cp -a "themes/Old/Normal/Windows 95 Plus!/Redmond97 SE Dangerous Creatures" $out/share/themes/

          runHook postInstall
        '';
      };
  };
}
