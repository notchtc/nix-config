{
  config.packages.split-clock = {
    systems = [ "x86_64-linux" ];

    package =
      { stdenvNoCC, fetchFromGitHub }:
      stdenvNoCC.mkDerivation {
        pname = "split-clock";
        version = "0-unstable-2024-03-20";

        src = fetchFromGitHub {
          owner = "bainonline";
          repo = "split-clock";
          rev = "e9cf2ad66c8b8f5dc3f783bfd9ed144a9726503a";
          hash = "sha256-oyhwudhqbxAwW0R3KmFzfNNOWgHtHV1lOtshvuv4/ws=";
        };

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/plasma/plasmoids/split-clock
          cp -r * $out/share/plasma/plasmoids/split-clock/

          runHook postInstall
        '';
      };
  };
}
