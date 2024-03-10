{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./core/boot.nix
    ./core/security.nix
    ./desktops
    ./networking
    ./nix
    ./programs
    ./services
  ];

  environment = {
    localBinInPath = true;

    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        coreutils
        curl
        doas-sudo-shim
        fd
        ffmpeg
        git
        man-pages
        man-pages-posix
        ripgrep
        vim
        wget
        ;
    };
  };

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
    packages = with pkgs; [terminus_font];
    useXkbConfig = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "pl_PL.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_TIME = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
    };
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Warsaw";
  };

  zramSwap.enable = true;
}
