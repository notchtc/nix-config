{
  lib,
  pkgs,
  ...
}: {
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.max_map_count" = 1048576;
    };

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 3;
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
    font = "Lat2-Terminus16";
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
    fish.enable = true;
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
    pulseaudio.enable = false;
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Warsaw";
  };

  zramSwap.enable = true;

  environment = {
    localBinInPath = true;

    binsh = "${pkgs.zsh}/bin/zsh";
    pathsToLink = ["/share/zsh"];
    shells = with pkgs; [zsh];
  };

  users = {
    mutableUsers = true;

    users.chtc = {
      isNormalUser = true;
      initialPassword = "changeme";
      home = "/home/chtc";
      shell = pkgs.fish;

      extraGroups = ["wheel" "networkmanager" "audio" "video"];
    };

    users.root.hashedPassword = "!";
  };
}
