{
  self,
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./core/boot.nix
    ./core/security.nix
    ./core/users.nix
    ./networking
    ./programs
    ./services
  ];

  nix = import ./core/nix-settings.nix {
    inherit config lib inputs;
  };

  nixpkgs = {
    config = lib.mkForce {
      allowUnfree = true;
    };

    overlays = lib.mkForce [
      self.overlays.default
    ];
  };

  environment = {
    localBinInPath = true;

    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        coreutils
        curl
        difftastic
        doas-sudo-shim
        fd
        ffmpeg
        git
        home-manager
        man-pages
        man-pages-posix
        ripgrep
        vim
        wget
        ;
    };
  };

  console.keyMap = "pl";

  i18n = {
    defaultLocale = "en_US.UTF-8";
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
