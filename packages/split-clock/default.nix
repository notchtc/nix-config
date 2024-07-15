{ pkgs }:
pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "split-clock";
  version = "e9cf2ad66c8b8f5dc3f783bfd9ed144a9726503a";

  src = pkgs.fetchFromGitHub {
    owner = "bainonline";
    repo = "split-clock";
    rev = "${finalAttrs.version}";
    hash = "sha256-oyhwudhqbxAwW0R3KmFzfNNOWgHtHV1lOtshvuv4/ws=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plasma/plasmoids/split-clock
    cp -r ./* $out/share/plasma/plasmoids/split-clock
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "A fork of stock Digital Clock widget with extra option to split text in vertical panel.";
    homepage = "https://github.com/baionline/split-clock";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ notchtc ];
    inherit (pkgs.kdePackages.kwindowsystem.meta) platforms;
  };
})
