{
  lib,
  pkgs,
  ...
}: {
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.max_map_count" = 1048576;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.tcp_rfc1337" = 1;
      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.tcp_congestion_control" = "bbr2";
      "net.core.default_qdisc" = "cake";
    };

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        consoleMode = "auto";
        editor = false;
      };
    };
  };

  security = {
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  console = {
    keyMap = "pl";
  };

  fonts = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        cantarell-fonts
        liberation_ttf
        iosevka
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        ;

      nerdfonts = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
    };

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = ["DejaVu Serif"];
        sansSerif = ["Iosevka Aile"];
        monospace = ["Iosevka Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
    };
  };

  programs = {
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

  services = {
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware = {
    enableAllFirmware = true;
    pulseaudio.enable = false;
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Warsaw";
  };

  zramSwap.enable = true;

  environment.localBinInPath = true;

  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;

    users.chtc = {
      isNormalUser = true;
      initialPassword = "changeme";
      home = "/home/chtc";

      extraGroups = ["wheel" "networkmanager" "audio" "video"];
    };

    users.root.hashedPassword = "!";
  };
}
