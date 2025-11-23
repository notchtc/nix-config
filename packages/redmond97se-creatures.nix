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
        version = "2.03";
      in
      stdenvNoCC.mkDerivation {
        pname = "redmond97se-creatures";
        inherit version;

        src = fetchurl {
          url = "https://github.com/SliverXReal/Redmond97-SE/releases/download/Version_${version}/Redmond97-SE_v${version}_Themes_Only.7z";
          hash = "sha256-LXL7UBlRMeKPejaE6X434XJ/SKEl5k1mrvyBUVqOtkI=";
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
