{
  self,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    self.nixosModules.boot
    self.nixosModules.networking
    self.nixosModules.security
    self.nixosModules.nix
  ];

  environment = {
    localBinInPath = true;

    systemPackages = lib.attrValues {
      inherit (pkgs)
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
    keyMap = "pl";
    packages = with pkgs; [ terminus_font ];
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

  programs = {
    command-not-found.enable = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    dconf.enable = true;
    zsh = {
      enable = true;
      enableCompletion = false;
    };
  };

  fonts = {
    packages = lib.attrValues {
      inherit (pkgs)
        cantarell-fonts
        liberation_ttf
        iosevka
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        ;

      nerdfonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
    };

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "Iosevka Aile" ];
        monospace = [ "Iosevka Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  services.journald.extraConfig = ''
    SystemMaxUse=50M
  '';

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services."getty@tty1".enable = lib.mkForce false;

  zramSwap.enable = true;
}
