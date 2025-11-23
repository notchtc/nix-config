{
  config.packages.memphis98 = {
    systems = [ "x86_64-linux" ];

    package =
      { stdenvNoCC, fetchzip }:
      let
        version = "1.2";
      in
      stdenvNoCC.mkDerivation {
        pname = "memphis98";
        inherit version;

        src = fetchzip {
          url = "https://github.com/Stanton731/Memphis98/releases/download/${version}/Memphis98_v.${version}.zip";
          hash = "sha256-87tgFb1vrShWx59LQR6MdOXTfx2JxiHVtAVi9zjw5aM=";
        };

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/icons/Memphis98
          cp -a * $out/share/icons/Memphis98/

          runHook postInstall
        '';
      };
  };
}
